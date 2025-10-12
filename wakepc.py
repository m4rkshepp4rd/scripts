#!/usr/bin/env python

import os
import os.path
import sys
import subprocess
import yaml

HW_INFO = f"{os.environ['MS_HWINFO']}"

assert os.path.exists(HW_INFO)

with open(HW_INFO, 'r', encoding='utf-8') as f:
    try:
        hw_info = yaml.safe_load(f)
    except yaml.YAMLError as e:
        print(e)

try:
    pc_name = sys.argv[1]
    pc_ip = hw_info[pc_name]['ip']
    pc_mac = hw_info[pc_name]['mac']
    print(subprocess.check_output(f'wol -p 9 -i {pc_ip} {pc_mac}', shell=True).decode())
except IndexError:
    print('(wakepc) Enter pc name')
except KeyError:
    print(f'(wakepc) No pc {pc_name} in config {HW_INFO}')
except subprocess.CalledProcessError:
    print('(wakepc) Package wol not installed')

