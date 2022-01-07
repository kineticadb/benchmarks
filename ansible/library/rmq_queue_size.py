#!/usr/bin/env python3
import json
import os.path
import subprocess
import sys
import traceback
import time

if len(sys.argv) < 2 or sys.argv[1] != "--test":
    from ansible.module_utils.basic import AnsibleModule


ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['stableinterface'],
                    'supported_by': 'kinetica'}
DOCUMENTATION = '''
---
module: rmq_queue_size
short_description: Checks RMQ existing queue sizes, allows the user to have the module wait until the queues are empty.
description:
    - returns a list of configured queues with their respective sizes
    - if wait_for_empty_timeout, the module won't return until all queues return 0 or the timeout is reached
versions_added: "0.1"
'''

def get_queue_sizes(module, size_only = False):
    try:
        rmq_queues_out = subprocess.Popen("PATH=/opt/gpudb/ha/erlang/bin:$PATH; /opt/gpudb/ha/rabbitmq-server/sbin/rabbitmqctl list_queues -qs", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        rmq_queues, err = rmq_queues_out.communicate()

        if err != None:
            module.fail_json(msg="Error retrieving rmq list sizes:\n" + traceback.format_exc())

        rmq_queues = rmq_queues.split()

        if size_only == False:
            queues = {}
            queues = {rmq_queues[i]: rmq_queues[i + 1] for i in range(0, len(rmq_queues), 2)}
            return queues
        else:
            sizes = []
            sizes = [rmq_queues[i] for i in range(1, len(rmq_queues), 2)]
            return sizes

    except:
        module.fail_json(msg="Error retrieving rmq list sizes:\n" + traceback.format_exc())    


def wait_for_empty_queues(module, timeout):
    wait_time = time.time() + 60 * timeout
    while True:
        sizes = get_queue_sizes(module, True)
        if all(i == '0' for i in sizes):
            return True
        if time.time() > wait_time:
            print("Error, timeout reached while waiting for queues to drain")
            return False


class DummyModule:
    def fail_json(self, msg):
        print("ERROR: " + msg)


def main():
    '''
        Main entrypoint for the module
    '''
    module_args = dict(
        wait_for_empty_timeout=dict(type='int', required=False)
    )
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=False
    )
    facts = {}
    timeout = None
    
    if module.params["wait_for_empty_timeout"] is not None:
        timeout = module.params["wait_for_empty_timeout"]
        facts["rmq_queue_empty"] = wait_for_empty_queues(module, timeout)
    else:
        facts["rmq_queue_size"] = get_queue_sizes(module, False)
        
    module.exit_json(ansible_facts=facts)


def test_main():
    module = DummyModule()
    wait_for_empty_timeout = None
    if len(sys.argv) == 3:
        wait_for_empty_timeout = int(sys.argv[2])
    facts = {}
    timeout = None

    if wait_for_empty_timeout is not None:
        timeout = wait_for_empty_timeout
        facts["rmq_queue_empty"] = wait_for_empty_queues(module, timeout)
    else:
        facts["rmq_queue_size"] = get_queue_sizes(module, False) 
    print(facts)

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()
