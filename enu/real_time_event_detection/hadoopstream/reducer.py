#!/usr/bin/env python

from operator import itemgetter
import sys
import os
os.environ['MPLCONFIGDIR'] = "/tmp/"
import pandas as pd
current_key = None
current_count = 0
key = None
variable_list = []
header = None
peClass = None
def qt_rmvd( string ):
    string = string.strip()
    if string.startswith("'") and string.endswith("'"):
        string = string[1:-1]
    return string

def print_row(key,pec, *dframes):
    day = key.split('/')[-1].split(".")[0]
    well = key.split('/')[-2]
    key = [well,day]
    if not day.startswith("Event"):
        text = []
        for var in ["Variable3","Variable7","Variable11","Variable14","Variable15"]:
            for df in dframes:
                text.append(df[var])
        #if pec != None:
        text.append(pec)
        print ",".join(key)+","+",".join([str(t) for t in text])
        #print '%s\t%s' % (key,text)
        #print '%s\t%s' % (key,["%0.2f" % i for i in values])
# input comes from STDIN

for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # parse the input we got from mapper.py
    key, values = line.split('\t', 1)
    values = values[1:-1]
    fields = values.split(',')
    if current_key is None:
		current_key = key
    if current_key == key:
        try:
            x = float(qt_rmvd(fields[0]))
            var = [float(qt_rmvd(x)) for x in fields[1:]]
            variable_list.append(var)
        except ValueError:
            if not qt_rmvd(fields[0]).startswith("Day") :
                header = [qt_rmvd(x) for x in fields[1:]]
                #print key
            else:
                peClass = qt_rmvd(fields[1])
                #print key, fields, peClass  
    elif len(variable_list) > 1:
        #print current_key
        df = pd.DataFrame(variable_list,columns=header)
        print_row(current_key,peClass,df.mean(),df.std(),df.min(),df.max(),df.quantile(.95),df.quantile(.05),df.quantile(),df.skew(),df.kurt())
        variable_list = []
        header = []
        peClass = None
        current_key = key
        try:
            x = float(qt_rmvd(fields[0]))
            var = [float(qt_rmvd(x)) for x in fields[1:]]
            variable_list.append(var)
        except ValueError:
            if not qt_rmvd(fields[0]).startswith("Day") :
                header = [qt_rmvd(x) for x in fields[1:]]
                #print key 
            else:
                peClass = qt_rmvd(fields[1])
                #print key, fields, peClass
    else:
        variable_list = []
        header = []
        peClass = None
        current_key = key
        try:
            x = float(qt_rmvd(fields[0]))
            var = [float(qt_rmvd(x)) for x in fields[1:]]
            variable_list.append(var)
        except ValueError:
            if not qt_rmvd(fields[0]).startswith("Day") :
                header = [qt_rmvd(x) for x in fields[1:]]
                #print key
            else:
                peClass = qt_rmvd(fields[1])
                #print key, fields, peClass
                
                
#print current_key
if len(variable_list) > 1:
    df = pd.DataFrame(variable_list,columns=header)
    print_row(current_key,peClass,df.mean(),df.std(),df.min(),df.max(),df.quantile(.95),df.quantile(.05),df.quantile(),df.skew(),df.kurt())
