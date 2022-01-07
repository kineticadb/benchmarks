#!/usr/bin/env python3
import subprocess
import traceback
import sys
import json
if len(sys.argv) < 2 or sys.argv[1] != "--test":
    from ansible.module_utils.basic import AnsibleModule


ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['stableinterface'],
                    'supported_by': 'kinetica'}


DOCUMENTATION = '''
---
module: gpudb_ha_facts
short_description: Gathers information about gpudb_ha services
description:
    - Runs gpudb_ha status
    - Generates facts for each component
versions_added: "0.1"
'''

def check_upgrades(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "yum check-update gpudb-ha"
        elif package_man == "dpkg":
            cmd = "apt-get --just-print upgrade | grep -w 'gpudb-ha'"
        else:
            module.fail_json(msg="could not check for upgrades")

        upg_check = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        upg_check_output, upg_check_error = upg_check.communicate()

        if package_man == "yum":
            if upg_check.returncode == 100:
                facts["gpudb_ha_upgrade_available"] = True
            else:
                facts["gpudb_ha_upgrade_available"] = False
        
        if package_man == "dpkg":
            if upg_check.returncode == 0:
                facts["gpudb_ha_upgrade_available"] = True
            else:
                facts["gpudb_ha_upgrade_available"] = False
        
    except:
        module.fail_json(msg="could not check for upgrades" + traceback.format_exc()) 

def get_conffiles(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "rpm -qc gpudb-ha"
        elif package_man == "dpkg":
            cmd = "cat /var/lib/dpkg/info/gpudb-ha.conffiles"
        else:
            module.fail_json(msg="could not retrieve configuration files associated with gpudb-ha")

        conffiles = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        conffiles_output, conffiles_error = conffiles.communicate()

        if conffiles_error is not None:
            module.fail_json(msg="could not retrieve configuration files associated with gpudb-ha")

        facts["gpudb_ha_conffiles"] = conffiles_output.split()
        
    except:
        module.fail_json(msg="could not retrieve configuration files associated with gpudb-ha" + traceback.format_exc()) 


def get_version(facts, module, package_man):
    try:
        if package_man == "yum":
            package_name = subprocess.Popen('rpm -qa | grep gpudb-ha || echo "0"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            count = package_output.split('\n')[0]
            print(count)
            if count != "0":
                facts["gpudb_ha_installed"] = True
                facts["gpudb_ha_version"] = package_output.split('-')[2].split('.ga')[0]
            else:
                facts["gpudb_ha_installed"] = False

        elif package_man == "dpkg":
            package_name = subprocess.Popen('dpkg -l | grep gpudb-ha || echo "0"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            count = package_output.split('\n')[0]
            if count != "0":
                facts["gpudb_ha_installed"] = True
                facts["gpudb_ha_version"] = package_output.split()[2].split('.ga')[0]
            else:
                facts["gpudb_ha_installed"] = False
        else:
             module.fail_json(msg="could not retrieve gpudb-ha version")
    except:
        module.fail_json(msg="could not retrieve gpudb-ha version:\n" + traceback.format_exc())


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


def get_gpudb_ha_info(facts, module):
    
    package_man = get_package_manager(module)
    get_version(facts, module, package_man)

    if facts["gpudb_ha_installed"]:

        try:
            if facts["gpudb_ha_version"][0:3] == "7.0":

                gpudb_proc = subprocess.Popen("/etc/init.d/gpudb-ha status | awk '{print $3}'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                output, error = gpudb_proc.communicate()

                service_status = output.split()
            
                if "not" in service_status[0]:
                    facts["gpudb_haproc_status"] = "Stopped"
                else:
                    facts["gpudb_haproc_status"] = "Running"

                if "not" in service_status[1]:
                    facts["gpudb_rabbitmq_status"] = "Stopped"
                else:
                    facts["gpudb_rabbitmq_status"] = "Running"
        
            else:
                gpudb_proc = subprocess.Popen("/opt/gpudb/ha/bin/gpudb-mq status | awk '{print $3}'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                output, error = gpudb_proc.communicate()

                service_status = output.split()

                if "not" in service_status[0]:
                    facts["gpudb_rabbitmq_status"] = "Stopped"
                else:
                    facts["gpudb_rabbitmq_status"] = "Running"
              
                facts["gpudb_haproc_status"] = "n/a"

            
        
            get_conffiles(facts, module, package_man)
            check_upgrades(facts, module, package_man)

        except:
            module.fail_json(msg="could not retrieve gpudb-ha status:\n" + traceback.format_exc())

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
    get_gpudb_ha_info(facts, module)
    module.exit_json(ansible_facts=facts)


def test_main():
    '''
        Main entrypoint for the module
    '''
    module = DummyModule()
    facts = {}
    get_gpudb_ha_info(facts, module)
    print(json.dumps(facts, indent = 4))


if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()