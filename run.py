#! /usr/local/bin/python3.10

import os
import sys

year = sys.argv[1]
day = sys.argv[2]

os.system(f"{sys.executable} {year}/{day}/main.py")
