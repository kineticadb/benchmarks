#!/usr/bin/env python3

import json
import subprocess
import xml.etree.ElementTree as element_tree
import sys
if len(sys.argv) < 2 or sys.argv[1] != "--test":
    from ansible.module_utils.basic import AnsibleModule


ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['stableinterface'],
                    'supported_by': 'kinetica'}


DOCUMENTATION = '''
---
module: nvidia
short_description: Gathers information about the GPU hardware from nvidia-smi
description:
   - Queries hardware for GPU information
version_added: "0.1"
options:
  enabled:
    description:
      - Gathers facts about NVIDIA GPUs
    required: true
    default: null
    choices: [ "true", "false" ]
'''

EXAMPLES = '''
# Query GPU info
  nvidia:
    enabled: true
'''

class DummyModule:
    def fail_json(self, msg, meta=None):
        print("ERROR: " + msg, meta)

    def exit_json(self, msg, exit_code=None, meta=None, ansible_facts=None):
        print("Error: " + msg, exit_code, meta, ansible_facts)


def extract_field(node, facts, fields, prefix=None):
    '''
        Parameters:
            * node: a parsed XML ElementTree
            * facts: a dict of facts to populate and return
            * fields: a list of tuples containing the element and _type
        Description:
            Finds all elements in the provided tuples and formats,
            coercing them to the provided type,
            and formating with or without a prefix and underscore.
    '''
    for (element, _type) in fields:
        key = "{}_{}".format(prefix, element) if prefix else element
        facts[key] = _type(node.findall("./{}".format(element))[0].text)


def nvidia_facts(facts, module):
    '''
        Main entrypoint for the module
    '''
    
    try:
        nvidia_smi = subprocess.Popen('nvidia-smi --query --xml-format',
                                      shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        output, error = nvidia_smi.communicate()
        nouveau = subprocess.Popen("lsmod | grep 'nouveau' > /dev/null && echo 'true' || echo 'false'",
                                      shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        nouveau_output, nouveau_error = nouveau.communicate()
        facts["nouveau_found"] = nouveau_output.split('\n')[0]
        if nvidia_smi.returncode == 0:
            facts["nvidia_smi_installed"] = True
            root = element_tree.fromstring(output)
            extract_field(
                root, facts, [('driver_version', str), ('attached_gpus', int)], "nvidia")
            gpu_num = 0
            gpus = {}
            while True:
                gpu = root.findall("./gpu[minor_number='{}']".format(gpu_num))
                if gpu:
                    gpu_facts = {}
                    extract_field(gpu[0], gpu_facts, [
                        ('product_name', str),
                        ('product_brand', str),
                        ('persistence_mode', bool),
                        ('minor_number', int)
                    ])
                    gpus[gpu_num] = gpu_facts
                else:
                    break
                gpu_num += 1
            if bool(gpus):
                facts["nvidia_gpus"] = gpus
            module.exit_json(ansible_facts=facts)
        elif nvidia_smi.returncode == 127:
            # Don't fail if nvidia-smi is not installed, just exit gracefully...
            facts["nvidia_smi_installed"] = False
            module.exit_json(msg='nvidia-smi is not installed',
                             exit_code=nvidia_smi.returncode,
                             ansible_facts=facts)
        else: #module.fail_json(msg="Unrecognized error code from nvidia-smi.",
              #                 meta={"error_code": nvidia_smi.returncode, "msg": error})
            facts["nvidia_smi_installed"] = False
            facts["nvidia_err"] = "Unrecognized error code from nvidia-smi. Error Code: " + str(nvidia_smi.returncode)
            module.exit_json(msg="Unrecognized error code from nvidia-smi. Error Code: " + str(nvidia_smi.returncode),
                            exit_code=nvidia_smi.returncode,
                            ansible_facts=facts)

    except ValueError as error:
        module.fail_json(msg="Error executing nvidia-smi.", meta=error)

def main():
    module = AnsibleModule(
        argument_spec=dict(
            enabled=dict(required=True, type='bool'))
    )
    facts = {}
    nvidia_facts(facts, module)


def test_main():
    module = DummyModule()
    facts = {}
    nvidia_facts(facts, module)
    print(json.dumps(facts, indent = 4))


if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()