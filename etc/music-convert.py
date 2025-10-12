#!/usr/bin/env python

import os
import subprocess

lst = [
    "/home/user/Music/Slipknot",
    "/home/user/Music/Nirvana"
]

for fld in lst:
    for t in os.walk(fld):
        for f in t[2]:
            if f.endswith('.flac'):
                file = t[0] + "/" + f
                d = t[0] + ' (mp3)'
                try:
                    os.mkdir(d)
                except FileExistsError:
                    pass
                out = d + "/" + f.rsplit(".", 1)[0] + ".mp3"
                subprocess.run(["ffmpeg", "-i", file, "-c:a", "libmp3lame", "-b:a", "320k", out, '-y'])
            if f.endswith('.jpg') or f.endswith('.jpeg'):
                file = t[0] + "/" + f
                d = t[0] + ' (mp3)'
                try:
                    subprocess.run(["cp", file, d + "/" + f])
                except:
                    pass