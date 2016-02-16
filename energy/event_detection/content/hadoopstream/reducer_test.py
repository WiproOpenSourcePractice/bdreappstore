#!/usr/bin/env python

import sys
import os
os.environ['MPLCONFIGDIR'] = "/tmp/"
import pandas as pd
import numpy as np
import commands 
import pickle as p

from sklearn import svm
from sklearn.cross_validation import StratifiedKFold
from sklearn import preprocessing
from sklearn.externals import joblib

current_key = None
key = None
vecList = []
nameList = []
#classList = []


def qt_rmvd( string ):
    string = string.strip()
    if string.startswith("'") and string.endswith("'"):
        string = string[1:-1]
    return string


#commands.getoutput("rm Schlumberger-SVM*")
commands.getoutput("hadoop fs -get /user/dropuser/schlumberger-model/* ./")
clf = joblib.load("Schlumberger-SVM.pkl")

for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # parse the input we got from mapper.py
    key, values = line.split('\t', 1)
    values = values[1:-1]
    values = values.split(",")
    day = qt_rmvd(values[0])
    values = values[1:]
    if current_key is None:
        current_key = key
    if current_key == key:
        vec = [float(qt_rmvd(x)) for x in values[:-1]]
        vecList.append(vec)
        nameList.append([key,day])
    else:
        vecList = np.asarray(vecList)
        min_max_scaler = preprocessing.MinMaxScaler()
        vecList = min_max_scaler.fit_transform(vecList)
        pred = clf.predict(vecList)
        for i in range(len(pred)):
            print str(nameList[i][0]).strip()+","+str(nameList[i][1])+","+str(pred[i])
        vecList = []
        nameList = []
        current_key = key
        vec = [float(qt_rmvd(x)) for x in values[:-1]]
        vecList.append(vec)
        nameList.append([key,day])

if len(vecList) > 0:    
    vecList = np.asarray(vecList)
    min_max_scaler = preprocessing.MinMaxScaler()
    vecList = min_max_scaler.fit_transform(vecList)
    pred = clf.predict(vecList)
    for i in range(len(pred)):
        print str(nameList[i][0]).strip()+","+str(nameList[i][1])+","+str(pred[i])
op = commands.getoutput("hadoop fs -rm /user/dropuser/schlumberger-result/*")