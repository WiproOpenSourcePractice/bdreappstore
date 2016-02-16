#!/usr/bin/env python

import sys
import os
os.environ['MPLCONFIGDIR'] = "/tmp/"
import pandas as pd
import numpy as np
import commands 
import csv

from sklearn import svm
from sklearn.cross_validation import StratifiedKFold
from sklearn import preprocessing
from sklearn.externals import joblib

current_key = None
key = None
dayList = []


def qt_rmvd( string ):
    string = string.strip()
    if string.startswith("'") and string.endswith("'"):
        string = string[1:-1]
    return string


for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # parse the input we got from mapper.py
    key, values = line.split('\t', 1)
    values = values[1:-1]
    values = values.split(",")
    day = qt_rmvd(values[0])
    values = values[1:]
    #print line, key, day ,values
    #print key
    #continue
    if current_key is None:
        current_key = key
    if current_key == key:
        dayList.append([day,qt_rmvd(values[0])])
    else:
        dayList.sort(key= lambda x: int(x[0].split("_")[-1]))
        fname = "Event_DailyRecord_"+current_key.strip()+".csv"
        f = open(fname,"wt")
        w = csv.writer(f)
        w.writerow(("Day","Event"))
        for elem in dayList:
            w.writerow((elem[0],elem[1]))
        f.close()
        #print commands.getoutput("ls")
        #print commands.getoutput("hadoop fs -rm /user/dropuser/schlumberger-result/"+fname)
        print commands.getoutput("hadoop fs -put "+fname+" /user/dropuser/schlumberger-result/")
        dayList = []
        current_key = key
        dayList.append([day,qt_rmvd(values[0])])
        
if len(dayList) > 0:
    dayList.sort(key= lambda x: int(x[0].split("_")[-1]))
    fname = "Event_DailyRecord_"+current_key.strip()+".csv"
    f = open(fname,"wt")
    w = csv.writer(f)
    w.writerow(("Day","Event"))
    for elem in dayList:
        w.writerow((elem[0],elem[1]))
    f.close()
    #print commands.getoutput("ls")
    #print commands.getoutput("hadoop fs -rm /user/dropuser/schlumberger-result/"+fname)
    print commands.getoutput("hadoop fs -put "+fname+" /user/dropuser/schlumberger-result/")
