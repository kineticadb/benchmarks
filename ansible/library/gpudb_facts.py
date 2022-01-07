#!/usr/bin/env python3
import json
import os.path
import subprocess
import sys
import traceback

if len(sys.argv) < 2 or sys.argv[1] != "--test":
    from ansible.module_utils.basic import AnsibleModule


ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['stableinterface'],
                    'supported_by': 'kinetica'}


DOCUMENTATION = '''
---
module: gpudb_facts
short_description: Gathers information about gpudb services
description:
    - Runs gpudb status
    - Generates facts for each component
versions_added: "0.1"
'''

def check_upgrades(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "yum check-update gpudb-" + facts["gpudb_core_arch"] + "-license"
        elif package_man == "dpkg":
            cmd = "apt-get --just-print upgrade | grep -w 'gpudb-" + facts["gpudb_core_arch"] + "-license'"
        else:
            module.fail_json(msg="could not check for upgrades")

        upg_check = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        upg_check_output, upg_check_error = upg_check.communicate()

        if package_man == "yum":
            if upg_check.returncode == 100:
                facts["gpudb_core_upgrade_available"] = True
            else:
                facts["gpudb_core_upgrade_available"] = False
        
        if package_man == "dpkg":
            if upg_check.returncode == 0:
                facts["gpudb_core_upgrade_available"] = True
            else:
                facts["gpudb_core_upgrade_available"] = False
        
    except:
        module.fail_json(msg="could not check for upgrades" + traceback.format_exc()) 


def get_conffiles(facts, module, package_man):
    try:
        if package_man == "yum":
            cmd = "rpm -qc gpudb-" + facts["gpudb_core_arch"] + "-license"
        elif package_man == "dpkg":
            cmd = "cat /var/lib/dpkg/info/gpudb-" + facts["gpudb_core_arch"] + "-license.conffiles"
        else:
            module.fail_json(msg="could not retrieve configuration files associated with gpudb-" + facts["gpudb_core_arch"] + "-license")

        conffiles = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        conffiles_output, conffiles_error = conffiles.communicate()

        if conffiles_error is not None:
            module.fail_json(msg="could not retrieve configuration files associated with gpudb-" + facts["gpudb_core_arch"] + "-license")

        facts["gpudb_core_conffiles"] = conffiles_output.split()
        
    except:
        module.fail_json(msg="could not retrieve configuration files associated with gpudb-" + facts["gpudb_core_arch"] + "-license" + traceback.format_exc()) 


def get_ranks_hosts(facts, module):
    try:
        rank_hosts = subprocess.Popen('/opt/gpudb/core/bin/gpudb_hosts_addresses.sh -a | uniq -c', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        rank_hosts_out, rank_hosts_error = rank_hosts.communicate()

        head_port = subprocess.Popen("/opt/gpudb/bin/gpudb_env /opt/gpudb/core/bin/gpudb_conf_parser.py /opt/gpudb/core/etc/gpudb.conf gaia.head_port | cut -d '=' -f2", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        head_port_out, head_port_error = head_port.communicate()

        host_settings_cmd = subprocess.Popen("grep -E '^[ \\t]*host[0-9]+\..+' /opt/gpudb/core/etc/gpudb.conf", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        host_settings_out, host_settings_err = host_settings_cmd.communicate()

        # RANKS_HOSTS
        head_port = head_port_out.split()[0]
        if rank_hosts_out is None or len(rank_hosts_out.strip()) == 0:
            rank_hosts_list = []
        else:
            rank_hosts_list = rank_hosts_out.split('\n')
            rank_hosts_list = list(filter(None, rank_hosts_list))
        rank_hosts_d = {}
        rank_ports_d = {}
        rank_urls_d = {}
        hosts_d = {}
        rank_count = 0
        for rank_host in rank_hosts_list:
            ranks_list = []
            ports_list = []
            urls_list = []
            max_rank = int(rank_host.split()[0])
            for rank in range(rank_count, (rank_count + max_rank)):
                ranks_list.append(rank)
                ports_list.append(int(head_port) + rank)
                urls_list.append("http://"+rank_host.split()[1]+":"+str(int(head_port) + rank))
                rank_count += 1
            rank_hosts_d[rank_host.split()[1]] = ranks_list
            rank_ports_d[rank_host.split()[1]] = ports_list
            rank_urls_d[rank_host.split()[1]] = urls_list

        parsed_hosts = {}
        for line in host_settings_out.split('\n'):
            if line == "":
                continue

            line_period_split = line.split(".")
            if len(line_period_split) <= 0 or line_period_split[0].strip() == "":
                continue

            host_number = line_period_split[0]
            if host_number not in parsed_hosts:
                parsed_hosts[host_number] = {}

            if len(line_period_split) <= 1 or "=" not in line_period_split[1]:
                continue

            host_parameter = line_period_split[1].split("=")[0].strip()
            host_value = line.split("=", 1)[1].strip()
            parsed_hosts[host_number][host_parameter] = host_value

        for key, value in parsed_hosts.items():
            if "address" in value:
                if value["address"] in hosts_d:
                    # Uh oh - duplicate address in host list?
                    continue

                hosts_d[value["address"]] = {}
                current_host = hosts_d[value["address"]]
                current_host["host"] = key
                for sub_key, sub_value in value.items():
                    if sub_key != "address":
                        current_host[sub_key] = sub_value

        # RESULTS
        facts["rank_host_list"] = rank_hosts_d
        facts["rank_port_list"] = rank_ports_d
        facts["rank_url_list"] = rank_urls_d
        facts["gpudb_head_port"] = head_port
        facts["hosts_dict"] = hosts_d

    except:
        module.fail_json(msg="could not retrieve number of ranks:\n" + traceback.format_exc())


def get_secret(facts, module):
    if os.path.isfile('/opt/gpudb/.secret-key'):
        try:
            with open('/opt/gpudb/.secret-key') as sk:
                secret = sk.read()
            if len(secret.split()) == 0 or len(secret.split()) > 1:
                facts["gpudb_secret_key"] = "n/a"
            else:    
                facts["gpudb_secret_key"] = secret.split()[0]
        except:
            module.fail_json(msg="could not read secret-key:\n" + traceback.format_exc())
    else:
        facts["gpudb_secret_key"] = "n/a"


def get_version(facts, module, package_man):
    try:
        if package_man == "yum":
            package_name = subprocess.Popen('rpm -qa | grep gpudb | grep -v gpudb-ha', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            #if len(package_output) >= 4
            facts["gpudb_core_arch"] = package_output.split('-')[1]
            version = ".".join([num for num in package_output.split('-')[3].split(".") if num.isdigit()])
            facts["gpudb_core_version"] = version #package_output.split('-')[3].split('.ga')[0]
        elif package_man == "dpkg":
            package_name = subprocess.Popen('dpkg -l | grep gpudb | grep -v gpudb-ha', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            package_output, package_error = package_name.communicate()
            #if len(package_output) >= 2
            facts["gpudb_core_arch"] = package_output.split()[1].split("-")[1]
            version = ".".join([num for num in package_output.split()[2].split(".") if num.isdigit()])
            facts["gpudb_core_version"] = package_output.split()[2].split('.ga')[0]
        else:
             module.fail_json(msg="could not rdetermine gpudb version")
    except:
        module.fail_json(msg="could not determine gpudb version:\n" + traceback.format_exc())


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



def get_gpudb_info(facts, module):
    try:
        # NOTE: This will hang this script if we are not the owner of the gpudb script - add a check??

        gpudb_installed = os.path.exists("/opt/gpudb/core/bin/gpudb")
        user_mismatch = gpudb_installed and os.getuid() != os.stat("/opt/gpudb/core/bin/gpudb").st_uid and os.getuid() != 0

        if not gpudb_installed:
            facts["gpudb_core_installed"] = gpudb_installed
            if user_mismatch:
                module.fail_json(msg = "cannot retrieve gpudb status - run as gpudb user")
            rank_hosts_d = {}
            rank_ports_d = {}
            rank_urls_d = {}
            rank_hosts_d['127.0.0.1'] = 0
            rank_ports_d['127.0.0.1'] = 0
            rank_urls_d['127.0.0.1'] = 0
            facts["rank_host_list"] = rank_hosts_d
            facts["rank_port_list"] = rank_ports_d
            facts["rank_url_list"] = rank_urls_d
            facts["hosts_dict"] = {}
            facts["gpudb_host_manager_status"] = False
            facts["gpudb_core_status"] = False
            facts["gpudb_tomcat_status"] = False
            facts["gpudb_stats_status"] = False
            facts["gpudb_reveal_status"] = False
            facts["gpudb_httpd_status"] = False
            facts["gpudb_secret_key"] = "n/a"
            return

        gpudb_proc = subprocess.Popen('/opt/gpudb/core/bin/gpudb status', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        output, error = gpudb_proc.communicate()

        httpd_proc = subprocess.Popen('/opt/gpudb/httpd/gpudb-httpd.sh status', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        httpd_output, error = httpd_proc.communicate()

        facts["gpudb_core_installed"] = True

        service_status = output.split('\n')

        for line in service_status:
            if "Host Manager" in line:
                facts["gpudb_host_manager_status"] = line.split(':')[1].split()[0].lower()
            elif "GPUdb" in line:
                facts["gpudb_core_status"] = line.split(':')[1].split()[0].lower()
            elif "Tomcat" in line:
                facts["gpudb_tomcat_status"] = line.split(':')[1].split()[0].lower()
            elif "Stats" in line:
                facts["gpudb_stats_status"] = line.split(':')[1].split()[0].lower()
            elif "Reveal" in line:
                facts["gpudb_reveal_status"] = line.split(':')[1].split()[0].lower()
        
        facts["gpudb_httpd_status"] = httpd_output.split(':')[1].split()[0].lower()
        

        package_man = get_package_manager(module)
        get_version(facts, module, package_man)
        get_secret(facts, module)
        get_ranks_hosts(facts, module)
        get_conffiles(facts, module, package_man)
        check_upgrades(facts, module, package_man)
    except:
        module.fail_json(msg="could not retrieve gpudb status\n" + traceback.format_exc())

class DummyModule:
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
    get_gpudb_info(facts, module)
    module.exit_json(ansible_facts=facts)

def test_main():
    module = DummyModule()
    facts = {}
    get_gpudb_info(facts, module)
    print(json.dumps(facts, indent = 4))

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()
