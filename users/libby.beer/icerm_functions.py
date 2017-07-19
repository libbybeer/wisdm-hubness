# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 14:09:01 2017

@author: Libby
"""

import time
start = time.time()

import numpy as np
import matplotlib.pyplot as plt
import scipy.io

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
    
def plot_by_hubness(pts, h):
    horder = list(h.argsort())
    plt.scatter(pts.T[0][horder], pts.T[1][horder],
                c = h[horder], cmap="copper", s=60, linewidth=0)

def random_spherical_separated_clusters(Ns,d,n,sep=10,dims_of_sep=1):
    #N = 1000 # number of data points
    #d = 10 # number of dimensions
    #n = 2 # number of clusters
    
    alldata = np.zeros((sum(Ns),d))
    running_N = 0
    dim_sep = np.sqrt(sep*sep/dims_of_sep)
    
    for i in range(n):
        N = Ns[i]
        cmean = np.array([dim_sep*i]*dims_of_sep + [0]*(d-dims_of_sep))
        #cmean = dim_sep*i*np.ones(d)
        allc = np.array([np.random.normal(cmean) for j in range(N)])
        alldata[running_N:(running_N+N)] = allc
        running_N += N
        
    return alldata

def above_n_sigmas(x,n):
    m = np.mean(x)
    s = np.std(x)
    return [i for i in range(len(x)) if x[i] > m+n*s]
