# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 16:14:38 2017

@author: Libby
"""

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2017) # set seed for reproducible results

N = 100 # number of data points
d = 10 # number of dimensions

xmean = np.zeros(d)
ymean = 10*np.ones(d)
allx = np.array([np.random.normal(xmean) for j in range(N)])
ally = np.array([np.random.normal(ymean) for j in range(N)])
alldata = np.concatenate((allx,ally))




testdata = np.array([[0,2],[1,0],[1,4],[2,2],[3,0],[3,4],[4,2],
                     [10,2],[12,0],[12,2],[12,4],[14,1],[14,3]])
            # top hubs should be [2,2], [12,2]
test_distances = np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in testdata] for x in testdata])
test_euc_nearest_neighbors = test_distances.argsort()
#plt.scatter(testdata.T[0],testdata.T[1],c=[hubness(i,testdata,3) for i in range(13)],
#            cmap="copper",s=100)



def hubness(i,allx,k):
    #i = np.where(allx==x)
    distances = np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in allx] for x in allx])
    euc_nearest_neighbors = distances.argsort()
    return len(np.where(euc_nearest_neighbors.T[1:(k+1)]==i)[0])

plt.scatter(alldata.T[0],alldata.T[1],c=[hubness(i,alldata,3) for i in range(len(alldata))],
            cmap="copper",s=60)