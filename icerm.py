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

N = 1000 # number of data points
d = 10 # number of dimensions

xmean = np.zeros(d)
ymean = 10*np.ones(d)
allx = np.array([np.random.normal(xmean) for j in range(N)])
ally = np.array([np.random.normal(ymean) for j in range(N)])
alldata10 = np.concatenate((allx,ally))

N = 1000 # number of data points per cluster
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

def dist_nn_hubness(allx,k):
    d = distances(allx)
    nn = nearest_neighbors(d)
    h = np.array([hubness(i,nn,k) for i in range(len(allx))])
    return [d,nn,h]
    

#dist10 = distances(alldata10)
#nn10 = nearest_neighbors(dist10)
#hubness10 = [hubness(i,nn10,3) for i in range(len(alldata10))]
[dist10,nn10,hubness10] = dist_nn_hubness(alldata10,3)

plt.interactive(True)

plt.figure(0)
plt.scatter(alldata10.T[0][list(hubness10.argsort())],
            alldata10.T[1][list(hubness10.argsort())],
            c=hubness10[hubness10.argsort()], cmap="copper",s=60,linewidth=0)

plt.figure(1)
plt.hist(hubness10)

#dist100 = distances(alldata100)
#nn100 = nearest_neighbors(dist100)
#hubness100 = [hubness(i,nn100,3) for i in range(len(alldata100))]
[dist100,nn100,hubness100] = dist_nn_hubness(alldata100,3)
plt.figure(2)
plt.hist(hubness100)

plt.figure(3)
plt.scatter(alldata100.T[0][list(hubness100.argsort())],
            alldata100.T[1][list(hubness100.argsort())],
            c=hubness100[hubness100.argsort()], cmap="copper",s=60,linewidth=0)


end = time.time()
print(start)
print(end)
print(end-start)