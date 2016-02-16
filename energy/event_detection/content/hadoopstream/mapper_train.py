#!/usr/bin/env python

import sys
import os
# input comes from STDIN (standard input)
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # split the line into words
    words = line.split(',')
    # increase counters
    if words[-1] != "None":
        print "/".join(words[:2]),"\t",words[2:]