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
module: gpudb_services_ops
short_description: Manages kinetica components
description:
    - Starts, Stops, Restarts or Kills components
versions_added: "0.1"
'''

def do_start_stop_gpudb(component, status, module):

    if component in ["tomcat", "stats", "reveal", "text-search"]:
        try:
            gpudb_component_command = subprocess.Popen('/opt/gpudb/core/bin/gpudb '+ component + '-' + status, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())

    if component == "host_manager":
        if status == "stop":
            try:
                gpudb_component_command = subprocess.Popen('timeout 2s /opt/gpudb/core/bin/gpudb stop-host-manager; /opt/gpudb/core/bin/gpudb kill 0', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                command_result, error = gpudb_component_command.communicate()
            except:
                module.fail_json(msg="could not stop host_manager successfully \n" + traceback.format_exc())
        elif status == "start":
            try:
                gpudb_component_command = subprocess.Popen('/opt/gpudb/core/bin/gpudb start-host-manager', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                command_result, error = gpudb_component_command.communicate()
            except:
                module.fail_json(msg="could not start host_manager successfully \n" + traceback.format_exc())
        elif status == "kill":
            try:
                gpudb_component_command = subprocess.Popen('/opt/gpudb/core/bin/gpudb kill 0', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                command_result, error = gpudb_component_command.communicate()
            except:
                module.fail_json(msg="could not kill host_manager successfully \n" + traceback.format_exc())

    if component == "gpudb":
        try:
            gpudb_component_command = subprocess.Popen('/opt/gpudb/core/bin/gpudb ' + status, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())

    if component == "kml":
        try:
            gpudb_component_command = subprocess.Popen('/etc/init.d/kml ' + status, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())

    if component == "etcd":
        try:
            gpudb_component_command = subprocess.Popen('systemctl ' + status + ' kinetica-etcd ' + status, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())

    if component == "mq":
        try:
            gpudb_component_command = subprocess.Popen('if systemctl is-enabled gpudb-mq > /dev/null ; then systemctl ' + status + ' gpudb-mq; else /opt/gpudb/ha/bin/gpudb-mq ' + status + '; fi', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())

    if component == "ha":
        try:
            gpudb_component_command = subprocess.Popen('/etc/init.d/gpudb-ha ' + status, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            command_result, error = gpudb_component_command.communicate()
        except:
            module.fail_json(msg="could not "+ status + " " + component +" successfully \n" + traceback.format_exc())


def do_validations(component, state, module):

    print("validating...")

    available_components = ["gpudb", "host_manager", "kml", "tomcat", "mq", "ha", "reveal", "stats", "text_search", "etcd"]
    available_states = ["start", "stop", "restart", "kill"]

    assert component in available_components, module.fail_json(msg="Component is not supported by this module, components supported: gpudb, host_manager, kml, tomcat, mq, ha, reveal, stats, text_search, all_gpudb, all")
    assert state in available_states, module.fail_json(msg="State is not supported, supported states are: start, stop, restart, kill(host_manager only)")
    if state == "kill" and component != "host_manager":
        module.fail_json(msg="kill is only supported for host_manager")


class DummyModule:
    def fail_json(self, msg):
        print("ERROR: " + msg)


def main():
    '''
        Main entrypoint for the module
    '''
    module_args = dict(
        component=dict(type='str', required=True),
        state=dict(type='str', required=True)
    )
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=False
    )
    result = dict(
        changed=False
    )
    component = module.params["component"]
    state = module.params["state"]

    do_validations(component, state, module)
    

    if state in ["start", "stop", "kill"]:
        do_start_stop_gpudb(component, state, module)
    elif state == "restart":
        do_start_stop_gpudb(component, "stop", module)
        do_start_stop_gpudb(component, "start", module)


    result['changed'] = True
    module.exit_json(**result)

def test_main():
    module = DummyModule()
    component = str(sys.argv[2])
    state = str(sys.argv[3])

    do_validations(component, state, module)
    if state in ["start", "stop", "kill"]:
        do_start_stop_gpudb(component, state, module)
    elif state == "restart":
        do_start_stop_gpudb(component, "stop", module)
        do_start_stop_gpudb(component, "start", module)
    

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()
