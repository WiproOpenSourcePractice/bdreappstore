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
classList = []


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
    vec = [float(qt_rmvd(x)) for x in values[:-1]]
    c = int(qt_rmvd(values[-1])) 
    vecList.append(vec)
    classList.append(c)
#print c,'\n',vecList
vecList = np.asarray(vecList)
classList = np.asarray(classList)
min_max_scaler = preprocessing.MinMaxScaler()
vecList = min_max_scaler.fit_transform(vecList)
clf = svm.SVC(kernel='rbf', C = 1)
clf.fit(vecList,classList)
l = joblib.dump(clf, 'Schlumberger-SVM.pkl')
'''s = p.dumps(clf)
#print s
f = open("svm.model","w")
f.write(s)
f.close()'''
#print commands.getoutput("ls")
print commands.getoutput("hadoop fs -rm  /user/dropuser/schlumberger-model/*")
for s in l:
    print commands.getoutput("hadoop fs -put "+ s +" /user/dropuser/schlumberger-model")
print commands.getoutput("hadoop fs -ls /user/dropuser/schlumberger-model/")

