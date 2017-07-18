# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 16:14:38 2017

@author: Libby
"""

import time
start = time.time()

import numpy as np
import matplotlib.pyplot as plt
import scipy.io

np.random.seed(2017) # set seed for reproducible results

#N = 1000 # number of data points
#d = 10 # number of dimensions
#
#xmean = np.zeros(d)
#ymean = 10*np.ones(d)
#allx = np.array([np.random.normal(xmean) for j in range(N)])
#ally = np.array([np.random.normal(ymean) for j in range(N)])
#alldata10 = np.concatenate((allx,ally))
#
#N = 1000 # number of data points per cluster
#d = 100 # number of dimensions
#
#xmean = np.zeros(d)
#ymean = 10*np.ones(d)
#allx = np.array([np.random.normal(xmean) for j in range(N)])
#ally = np.array([np.random.normal(ymean) for j in range(N)])
#alldata100 = np.concatenate((allx,ally))
#

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
#[dist10,nn10,hubness10] = dist_nn_hubness(alldata10,3)


def plot_by_hubness(pts, h):
    horder = list(h.argsort())
    plt.scatter(pts.T[0][horder], pts.T[1][horder],
                c = h[horder], cmap="copper", s=60, linewidth=0)



plt.interactive(True)

#plt.figure(0)
##plt.scatter(alldata10.T[0][list(hubness10.argsort())],
##            alldata10.T[1][list(hubness10.argsort())],
##            c=hubness10[hubness10.argsort()], cmap="copper",s=60,linewidth=0)
#plot_by_hubness(alldata10,hubness10)
#
#plt.figure(1)
#plt.hist(hubness10)
#
##dist100 = distances(alldata100)
##nn100 = nearest_neighbors(dist100)
##hubness100 = [hubness(i,nn100,3) for i in range(len(alldata100))]
#[dist100,nn100,hubness100] = dist_nn_hubness(alldata100,3)
#plt.figure(2)
#plt.hist(hubness100)

#plt.figure(3)
##plt.scatter(alldata100.T[0][list(hubness100.argsort())],
##            alldata100.T[1][list(hubness100.argsort())],
##            c=hubness100[hubness100.argsort()], cmap="copper",s=60,linewidth=0)
#plot_by_hubness(alldata100,hubness100)




## load Priya's data
#synthetic_data_30_50_overlap30 = scipy.io.loadmat("C://Users//Libby/Hubness/Datasets/synthetic_data_30_50_overlap30.mat")
#class0 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
#                   synthetic_data_30_50_overlap30["ground"]) if y==0])
#class1 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
#                   synthetic_data_30_50_overlap30["ground"]) if y==1])    
#
#[class0dist,class0nn,class0hubness] = dist_nn_hubness(class0,3)
#[class1dist,class1nn,class1hubness] = dist_nn_hubness(class1,3)
#[bothdist,bothnn,bothhubness] = dist_nn_hubness(synthetic_data_30_50_overlap30["samples"],3)
#

#samples_30_50 = scipy.io.loadmat("C://Users/Libby/Hubness/Datasets/samples_30_50.mat")
#class0 = samples_30_50["samples"][:2500]
#class1 = samples_30_50["samples"][2500:]
#[class0dist,class0nn,class0hubness] = dist_nn_hubness(class0,30)
#[class1dist,class1nn,class1hubness] = dist_nn_hubness(class1,30)
#[bothdist,bothnn,bothhubness] = dist_nn_hubness(np.concatenate((class0,class1)),30)
#plt.figure(4)
#plt.plot(class0hubness == bothhubness[:2500])
#plt.plot(class1hubness == bothhubness[2500:])
#
#
#
#plt.figure(5)
#plot_by_hubness(class0,class0hubness)
#plot_by_hubness(class1,class1hubness)
#
#plt.figure(6)
#plot_by_hubness(synthetic_data_30_50_overlap30["samples"].T[40:42].T,bothhubness)

def random_spherical_separated_clusters(N,d,n):
    #N = 1000 # number of data points
    #d = 10 # number of dimensions
    #n = 2 # number of clusters
    
    alldata = np.zeros((N*n,d))
    
    for i in range(n):
        cmean = 10*i*np.ones(d)
        allc = np.array([np.random.normal(cmean) for j in range(N)])
        alldata[(i*N):((i+1)*N)] = allc
        
    return alldata

N = 500
d = 2
n = 10

clust10 = random_spherical_separated_clusters(N,d,n)
local_stats_clust10 = [[]]*n
for i in range(10):
    locdata = clust10[(i*N):((i+1)*N)]
    local_stats_clust10[i] = dist_nn_hubness(locdata,6)

global_stats_clust10 = dist_nn_hubness(clust10,6)



end = time.time()
print(start)
print(end)
print(end-start)