#!/usr/bin/env python3
import os.path
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
module: volume_mappings
short_description: Gathers information about rank_volumes when ranks are split into multiple volumes
description:
    - Runs volume_mapping
    - Generates facts for each component
versions_added: "0.1"
'''

def get_ranks_volumes(facts, module):
    '''
    Using grep, create a dictionary that maps the directory where each rank is storing its data, including graph
    '''
    try:
        rank_volumes = subprocess.Popen('grep -E "^tier\.persist\.(rank.*|graph.*)\.path[ \t]*=" /opt/gpudb/core/etc/gpudb.conf 2>/dev/null || echo false', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        rank_volumes_out, rank_volumes_error = rank_volumes.communicate()
        rank_vols = {}
        if rank_volumes.returncode == 0:
            rank_volumes = rank_volumes_out.split('\n')
            if rank_volumes[0] != 'false':
                for rank in rank_volumes:
                    if rank != '':
                        print(rank.split('.')[2] +": " + rank.split()[2])
                        _rank_no = rank.split('.')[2]
                        if "graph" in rank.split('.')[2]:
                            rank_vols['-'.join([_rank_no[:5], _rank_no[5:]])] = rank.split()[2]
                        elif "rank" in rank.split('.')[2]:
                            rank_vols['-'.join([_rank_no[:4], _rank_no[4:]])] = rank.split()[2]
        facts['rank_volume_mappings'] = rank_vols
        return facts
    except:
        #print("ERROR" + traceback.format_exc())
        module.fail_json(msg="could not retrieve number of ranks:\n" + traceback.format_exc())


def get_ranks_volumes_host(facts, module):
    '''
    Using grep, create a dictionary that maps the directory where each rank is storing its data, including graph
    '''
    try:

        host_address = subprocess.Popen('grep -E "^host.*\.address[ \t]*=" /opt/gpudb/core/etc/gpudb.conf 2>/dev/null || echo false', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        host_address_out, host_address_out_error = host_address.communicate()
        
        rank_host = subprocess.Popen('grep -E "^rank.*\.host[ \t]*=" /opt/gpudb/core/etc/gpudb.conf 2>/dev/null || echo false', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        rank_host_out, rank_host_out_error = rank_host.communicate()
        
        rank_volumes = subprocess.Popen('grep -E "^tier\.persist\.(rank.*|graph.*)\.path[ \t]*=" /opt/gpudb/core/etc/gpudb.conf 2>/dev/null || echo false', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        rank_volumes_out, rank_volumes_error = rank_volumes.communicate()

        graph_address = subprocess.Popen('grep -E "^graph_server_ip_address[ \t]*=" /opt/gpudb/core/etc/gpudb.conf 2>/dev/null || echo false', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        graph_address_out, graph_address_out_error = graph_address.communicate()

        ranks_vols_hosts = {}
                
        if host_address.returncode == 0 and rank_host.returncode == 0 and rank_volumes.returncode == 0 and graph_address.returncode == 0:
            host_address = host_address_out.split('\n')
            rank_host = rank_host_out.split('\n')
            rank_volumes = rank_volumes_out.split('\n')
            graph_address = graph_address_out.split('\n')
        
        else:
            module.fail_json(msg="could not retrieve host information about volumes:\n" + traceback.format_exc())

        if host_address[0]!= 'false' and rank_host[0]!= 'false' and rank_volumes[0]!= 'false':
            
            ### For future multi graph servers...
            #for address in host_address:
            #    if address != '':
            #        #print("host: " + address.split('.')[0] +" IP: " + address.split()[2])
            #        ranks_vols_hosts[address.split('.')[0]] = {}
            #        ranks_vols_hosts[address.split('.')[0]]['address'] = address.split()[2]
            #        ranks_vols_hosts[address.split('.')[0]]['volumes'] = {}
            #        for rank in rank_host:
            #            if rank != '' and rank.split()[2] == address.split('.')[0]:
            #                #print("host: " + address.split('.')[0] + " rank: " + rank.split('.')[0])
            #                for volume in rank_volumes:
            #                    if volume != '' and volume.split('.')[2] == rank.split('.')[0]:
            #                        #print("rank: " + rank.split('.')[0] + " volume: " + volume.split()[2])
            #                        ranks_vols_hosts[address.split('.')[0]]['volumes'][rank.split('.')[0]] = volume.split()[2]
            #                        #print(ranks_vols_hosts)
            #        for graph in graph_address:
            #            if graph != "" and graph.split()[2] == address.split()[2]:
            #                for volume in rank_volumes:
            #                    if volume != '' and volume.split('.')[2] == "graph0":
            #                        ranks_vols_hosts[address.split('.')[0]]['volumes']['graph0'] = volume.split()[2]
            #
            #            elif graph != "" and graph.split()[2] == '${gaia.host0.address}':
            #                for volume in rank_volumes:
            #                    if volume != '' and volume.split('.')[2] == "graph0":
            #                        ranks_vols_hosts['host0']['volumes']['graph0'] = volume.split()[2]
            
            ip_ranks_dict = {}
            for address in host_address:
                if address != '':
                    #print("host: " + address.split('.')[0] +" IP: " + address.split()[2])
                    ip_ranks_dict[address.split()[2]] = {}
                    for rank in rank_host:
                        if rank != '' and rank.split()[2] == address.split('.')[0]:
                            #print("host: " + address.split('.')[0] + " rank: " + rank.split('.')[0])
                            for volume in rank_volumes:
                                if volume != '' and volume.split('.')[2] == rank.split('.')[0]:
                                    #print("rank: " + rank.split('.')[0] + " volume: " + volume.split()[2])
                                    ip_ranks_dict[address.split()[2]][rank.split('.')[0]] = volume.split()[2]
                                    #print(ranks_vols_hosts)

            facts['ip_rank_information'] = ip_ranks_dict
            #facts['full_volume_information'] = ranks_vols_hosts
        
        else:
            facts['ip_rank_information'] = {}
            #module.fail_json(msg="could not retrieve host information about volumes:\n" + traceback.format_exc())

    except:
        module.fail_json(msg="could not retrieve the volumes assigned to each rank:\n" + traceback.format_exc())


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
    get_ranks_volumes(facts, module)
    get_ranks_volumes_host(facts, module)
    module.exit_json(ansible_facts=facts)

def test_main():
    module = DummyModule()
    facts = {}
    get_ranks_volumes(facts, module)
    get_ranks_volumes_host(facts, module)
    print(json.dumps(facts, indent = 4))

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_main()
    else:
        main()