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
    input_file = os.environ["mapreduce_map_input_file"]
    ifList = input_file.split('/')
    if not ifList[-1].startswith("Event"):
        print "/".join(ifList[-2:]),"\t",str(words)
    else:
        ifList[-1] = words[0]+".csv"
        print "/".join(ifList[-2:]),"\t",str(words)