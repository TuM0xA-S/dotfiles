#! /usr/bin/python
import subprocess as sp
import re
import os

windows = sp.run(
    ["wmctrl", "-l"], capture_output=True, text=True).stdout

line = re.compile(r"^(\w+) +(\d) \w+ (.*)$", re.M)

matches = line.findall(windows)
if not len(matches):
    exit()

choices = {f"[{int(m[1])+1}] {m[2]}.{int(m[0], 16)}\n": m[0] for m in matches}

r, w = os.pipe()
for ch in choices:
    os.write(w, ch.encode())

os.close(w)

choice = sp.run(
    ["fzf-dmenu"], capture_output=True, text=True, stdin=r).stdout
if not choice:
    exit()

window_id = choices[choice]
sp.run(["wmctrl", "-ia", window_id])
