#!/usr/bin/env python

import os
import subprocess

lst = [
    "/home/user/Music"
]

for fld in lst:
    for t in os.walk(fld):
        if t[0].endswith(' (mp3)'):
            subprocess.run(["rm", "-rf", t[0]])