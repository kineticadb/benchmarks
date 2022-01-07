#!/usr/bin/env python3
import subprocess
import sys
import json
import traceback
if len(sys.argv) < 2 or sys.argv[1] != "--test":
    from ansible.module_utils.basic import AnsibleModule


ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['stableinterface'],
                    'supported_by': 'kinetica'}


DOCUMENTATION = '''
---
module: gpudb_kml_facts
short_description: Gathers information about gpudb_ha services
description:
    - Runs kinetica_ml status check
    - Generates facts for each component
versions_added: "0.1"
'''

def check_upgrades(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "yum check-update kinetica-ml"
        elif package_man == "dpkg":
            cmd = "apt-get --just-print upgrade | grep -w 'kinetica-ml'"
        else:
            module.fail_json(msg="could not check for upgrades")

        upg_check = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        upg_check_output, upg_check_error = upg_check.communicate()

        if package_man == "yum":
            if upg_check.returncode == 100:
                facts["gpudb_ml_upgrade_available"] = True
            else:
                facts["gpudb_ml_upgrade_available"] = False
        
        if package_man == "dpkg":
            if upg_check.returncode == 0:
                facts["gpudb_ml_upgrade_available"] = True
            else:
                facts["gpudb_ml_upgrade_available"] = False
        
    except:
        module.fail_json(msg="could not check for upgrades" + traceback.format_exc()) 

def get_conffiles(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "rpm -qc kinetica-ml"
        elif package_man == "dpkg":
            cmd = "cat /var/lib/dpkg/info/kinetica-ml.conffiles"
        else:
            module.fail_json(msg="could not retrieve configuration files associated with kinetica-ml")

        conffiles = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        conffiles_output, conffiles_error = conffiles.communicate()

        if conffiles_error is not None:
            module.fail_json(msg="could not retrieve configuration files associated with kinetica-ml")

        facts["gpudb_ml_conffiles"] = conffiles_output.split()
        
    except:
        module.fail_json(msg="could not retrieve configuration files associated with kinetica-ml" + traceback.format_exc())


def get_package_manager(module):
    try:
        rpm_count = subprocess.Popen('which rpm > /dev/null 2>/dev/null && rpm -qa | wc -l || echo "0"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        rpm_count_output, rpm_count_error = rpm_count.communicate()
        dpkg_count = subprocess.Popen('which dpkg > /dev/null 2>/dev/null && dpkg -l | wc -l || echo "0"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        dpkg_count_output, dpkg_count_error = dpkg_count.communicate()
        
        rpm_count = int(rpm_count_output.split('\n')[0])
        dpkg_count = int(dpkg_count_output.split('\n')[0])

        if rpm_count < dpkg_count:
            return "dpkg"
        else:
            return "yum"
    except:
        module.fail_json(msg="could not retrieve package manager")


def get_version(facts, module, package_man):
    try:
        if package_man == "yum":
            package_name = subprocess.Popen('rpm -qa | grep kinetica-ml', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            facts["gpudb_ml_version"] = package_output.split('-')[2].split('.ga')[0]
        elif package_man == "dpkg":
            package_name = subprocess.Popen('dpkg -l | grep kinetica-ml', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            facts["gpudb_ml_version"] = package_output.split()[2].split('.ga')[0]
        else:
             module.fail_json(msg="could not retrieve kml version")
    except:
        module.fail_json(msg="could not retrieve kml version:\n" + traceback.format_exc())

def get_gpudb_ml_info(facts, module):
    try:
        gpudb_proc = subprocess.Popen('/etc/init.d/kml status', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        output, error = gpudb_proc.communicate()
        if gpudb_proc.returncode == 127:
            facts["gpudb_ml_installed"] = False
        else:
            facts["gpudb_ml_installed"] = True
            service_status = output.split('\n')
            for line in service_status:
                if "UI" in line:
                    facts["gpudb_mlui_status"] = line.split(':')[1].split()[0].lower()                
            package_man = get_package_manager(module)
            get_version(facts, module, package_man)
            get_conffiles(facts, module, package_man)
            check_upgrades(facts, module, package_man)

    except:
        module.fail_json(msg="could not retrieve kml status:\n" + traceback.format_exc())


class DummyModule:
    '''
        Class to test ansible module
    '''
    def fail_json(self, msg):
        print("ERROR: " + msg)


def main():
    '''
        Main entrypoint for the module
    '''
    module = AnsibleModule(
        argument_spec=dict(
            enabled=dict(required=True, type='bool'))
    )
    facts = {}
    get_gpudb_ml_info(facts, module)
    module.exit_json(ansible_facts=facts)


def test_main():
    '''
        Main entrypoint for the module
    '''
    module = DummyModule()
    facts = {}
    get_gpudb_ml_info(facts, module)
    print(json.dumps(facts, indent = 4))


if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()