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




def compute_global_hubnesses(ratio,d,k,datatype="gaussian",
                             data_fileprefix="../../shared_data/",
                             out_fileprefix="",out_filepostfix="_global_hubnesses.mat",
                             print_times=True):
    if print_times:
        print(time.asctime(time.localtime())+" - about to compute global hubnesses for ratio "+
              str(ratio)+", d="+str(d)+", k="+str(k)+", datatype="+datatype+"\n")
    if datatype=="gaussian":
        data_filename = "gaussians_1000_"+str(ratio)+"000_"+str(d)+".mat"
        data_index = "allsamples"
    elif datatype=="uniform":
        data_filename = "unif-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
        data_index = "X"
    else:
        print("You specified "+datatype+", which isn't a datatype I recognize.")
        return None
    samples = scipy.io.loadmat(data_fileprefix+data_filename)
    hubness = dist_nn_hubness(samples[data_index],k)[2]
    out_filename = data_filename[:-4]+out_filepostfix
    scipy.io.savemat(out_filename,{"hubnesses":hubness})
    if print_times:
        print(time.asctime(time.localtime())+" - computed global hubnesses for ratio "+
              str(ratio)+", d="+str(d)+", k="+str(k)+", datatype="+datatype+"\n")

def plot_hubness_vs_density(ratio,d,k,datatype="gaussian",
                            data_fileprefix="../../shared_results/",
                            colorby="class",cmap="winter"):
    if datatype=="gaussian":
        hubness_filename = "gaussian_global_hubnesses.mat"
        hubness_index = "g_1_"+str(ratio)+"_"+str(d)+"_globalhubness_k"+str(k)
        density_filename = "gauss-density-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
        density_index="q"
    elif datatype=="uniform":
        hubness_filename = "uniform_global_hubnesses.mat"
        hubness_index = "u_1_"+str(ratio)+"_"+str(d)+"_globalhubness_k"+str(k)
        density_filename = "unif-density-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
        density_index="q"
    else:
        print("You specified "+datatype+", which isn't a datatype I recognize.")
        return None
    hubness_scores = scipy.io.loadmat(data_fileprefix+hubness_filename)[hubness_index].T
    density_scores = scipy.io.loadmat(data_fileprefix+density_filename)[density_index]
    hubs = above_n_sigmas(hubness_scores,2)
    antihubs = above_n_sigmas(-1*hubness_scores,2)
    if colorby == "class":
        c = 1000*[0]+ratio*1000*[1]
    elif colorby == "hubness":
        c = hubness_scores
    elif colorby == "binary_hubness":
        c = (1000+ratio*1000)*[0]
        for i in range(1000+ratio*1000):
            if i in hubs:
                c[i]=1
            elif i in antihubs:
                c[i]=-1
    else: 
        print("You asked me to color by "+colorby+", which isn't a coloring strategy I recognize, so I'm just going to use one color.")
        c = (1000+ratio*1000)*[0]
    plt.scatter(density_scores,hubness_scores,c=c,cmap=cmap,linewidth=0)
 
from mpl_toolkits.mplot3d import Axes3D

def load_samples(ratio,d,k,datatype="gaussian",data_fileprefix="../../shared_data"):
    if datatype == "uniform":
        data_filename = "unif-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
        data_index="X"
    elif datatype == "gaussian":
        data_filename = "gaussians_1000_"+str(ratio)+"000_"+str(d)+".mat"
        data_index="allsamples"
    else:
        print("You specified "+datatype+", which isn't a datatype I recognize.")
        return None       
    samples = scipy.io.loadmat(data_fileprefix+data_filename)[data_index]
    return samples

def load_hubnesses(ratio,d,k,datatype="gaussian",
                            data_fileprefix="../../shared_results/"):
    if datatype=="gaussian":
        hubness_filename = "gaussian_global_hubnesses.mat"
        hubness_index = "g_1_"+str(ratio)+"_"+str(d)+"_globalhubness_k"+str(k)
    elif datatype=="uniform":
        hubness_filename = "uniform_global_hubnesses.mat"
        hubness_index = "u_1_"+str(ratio)+"_"+str(d)+"_globalhubness_k"+str(k)
    else:
        print("You specified "+datatype+", which isn't a datatype I recognize.")
        return None    
    hubness_scores = scipy.io.loadmat(data_fileprefix+hubness_filename)[hubness_index].T
    return hubness_scores

    
def illustrate_uniform_data(ratio,d,k):
    data_fileprefix="../../shared_data/"
    data_filename = "unif-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
    print(data_fileprefix+data_filename)
    samples = scipy.io.loadmat(data_fileprefix+data_filename)["X"]
    print(samples.shape)
    print(samples[0].shape)
    fig = plt.figure()
    ax = fig.add_subplot(111,projection='3d')
    ax.scatter(samples.T[0],samples.T[1],samples.T[2])
    plt.show()
        
def illustrate_gaussian_data(ratio,d,k):
    data_fileprefix="../../shared_data/"
    data_filename = "gaussians_1000_"+str(ratio)+"000_"+str(d)+".mat"
    #data_filename = "unif-dim"+str(d)+"-1000-"+str(ratio)+"000.mat"
    print(data_fileprefix+data_filename)
    samples = scipy.io.loadmat(data_fileprefix+data_filename)["allsamples"]
    print(samples.shape)
    print(samples[0].shape)
    fig = plt.figure()
    fig.suptitle("Two spherical Gaussians in "+str(d)+" dimensions, density ratio 1:"+str(ratio))
    ax = fig.add_subplot(111,projection='3d')
    ax.set_xlabel("separating dimension")
    ax.scatter(samples.T[0],samples.T[1],samples.T[2],linewidth=0,c="cadetblue")
    plt.show()

def hubs_per_cluster(ratio,d,k,datatype="gaussian",data_fileprefix="../../shared_data/",
                     results_fileprefix="../../shared_results/"):
    samples = load_samples(ratio,d,k,datatype,data_fileprefix)
    hubnesses = load_hubnesses(ratio,d,k,datatype,results_fileprefix)
    hubs = above_n_sigmas(hubnesses,2)
    hubs0 = len([y for y in hubs if y<1000])
    hubs1 = len([y for y in hubs if y>=1000])
    return np.array([hubs0,hubs1])

def illustrate_priya_data():
    # load Priya's data
    synthetic_data_30_50_overlap30 = scipy.io.loadmat("C://Users//Libby/Hubness/Datasets/synthetic_data_30_50_overlap30.mat")
    overlap_class0 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
                   synthetic_data_30_50_overlap30["ground"]) if y==0])
    overlap_class1 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
                   synthetic_data_30_50_overlap30["ground"]) if y==1])   
    fig = plt.figure()
    fig.suptitle("Two spherical Gaussians in 30 and 50 dimensions, embedded in 100 dimensions")
    ax = fig.add_subplot(111,projection="3d")
    ax.scatter(overlap_class0.T[25],overlap_class0.T[35],overlap_class0.T[60],
               linewidth=0,c="cadetblue")
    ax.scatter(overlap_class1.T[25],overlap_class1.T[35],overlap_class1.T[60],
               linewidth=0,c="sandybrown")
    plt.show()
    
def illustrate_spam_data():
    spam_data = scipy.io.loadmat("C:/Users/Libby/Hubness/Datasets/data_spam.mat")
    spam_class0 = np.array([x for (x,y) in zip(spam_data["data_sample"],
                   spam_data["ground"]) if y==0])
    spam_class1 = np.array([x for (x,y) in zip(spam_data["data_sample"],
                   spam_data["ground"]) if y==1])
    fig = plt.figure()
    fig.suptitle("Spam data")
    ax = fig.add_subplot(111,projection="3d")
    ax.scatter(spam_class0.T[1],spam_class0.T[5],spam_class0.T[2],
               s=40,linewidth=0,c="cadetblue")
    ax.scatter(spam_class1.T[1],spam_class1.T[5],spam_class1.T[2],
               s=40,linewidth=0,c="sandybrown")
    plt.show()