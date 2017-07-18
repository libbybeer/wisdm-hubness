# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 16:14:38 2017

@author: Libby
"""

import time
start = time.time()

import numpy as np
import matplotlib.pyplot as plt

np.random.seed(2017) # set seed for reproducible results

N = 100 # number of data points
d = 10 # number of dimensions

xmean = np.zeros(d)
ymean = 10*np.ones(d)
allx = np.array([np.random.normal(xmean) for j in range(N)])
ally = np.array([np.random.normal(ymean) for j in range(N)])
alldata10 = np.concatenate((allx,ally))

N = 100 # number of data points per cluster
d = 100 # number of dimensions

xmean = np.zeros(d)
ymean = 10*np.ones(d)
allx = np.array([np.random.normal(xmean) for j in range(N)])
ally = np.array([np.random.normal(ymean) for j in range(N)])
alldata100 = np.concatenate((allx,ally))


testdata = np.array([[0,2],[1,0],[1,4],[2,2],[3,0],[3,4],[4,2],
                     [10,2],[12,0],[12,2],[12,4],[14,1],[14,3]])
            # top hubs should be [2,2], [12,2]
test_distances = np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in testdata] for x in testdata])
test_euc_nearest_neighbors = test_distances.argsort()
#plt.scatter(testdata.T[0],testdata.T[1],c=[hubness(i,testdata,3) for i in range(13)],
#            cmap="copper",s=100)


def distances(allx):
    return np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in allx] for x in allx])

def nearest_neighbors(distance_matrix):
    return distance_matrix.argsort()

def hubness(i,nearest_neighbors,k):
    #i = np.where(allx==x)
    return len(np.where(nearest_neighbors.T[1:(k+1)]==i)[0])

dist10 = distances(alldata10)
nn10 = nearest_neighbors(dist10)
hubness10 = [hubness(i,nn10,3) for i in range(len(alldata10))]


plt.figure(0)
plt.scatter(alldata10.T[0],alldata10.T[1],
            c=hubness10,
            cmap="copper",s=60)

plt.figure(1)
plt.hist(hubness10)

dist100 = distances(alldata100)
nn100 = nearest_neighbors(dist100)
hubness100 = [hubness(i,nn100,3) for i in range(len(alldata100))]
plt.figure(2)
plt.hist(hubness100)

plt.figure(3)
plt.scatter(alldata100.T[0],alldata100.T[1],
            c=hubness100,
            cmap="copper",s=60)


end = time.time()
print(start)
print(end)
print(end-start)