# -*- coding: utf-8 -*-

import hashlib
import os
import pandas as pd

root = ""
L = []

for root, Dirs, Files in os.walk(root):
    for file in Files:
        with open(os.path.join(root, file),"rb") as f:
            readable_hash = hashlib.sha256(f.read()).hexdigest()
            L.append([os.path.join(root, file), readable_hash])
    
n = len(L)
for i in range(n):
    for j in range(i + 1, n):
        if L[i][1] == L[j][1]:
            print(L[i][0], L[j][0])
            
n = len(L)
for i in range(n):
    for j in range(i + 1, n):
        if L[i][1] == L[j][1]:
            (fileroot, ext) = os.path.splitext(L[i][0])
            k = 0
            newfilename = fileroot + "_" + str(k) + ext
            while os.path.exists(newfilename):
                k += 1
                newfilename = fileroot + "_" + str(k) + ext
            print(L[j][0], newfilename)
            os.rename(L[i][0], newfilename)
            k = 0
            
for i in range(n):
    print(L[i][0])