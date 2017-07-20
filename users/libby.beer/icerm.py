# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 16:14:38 2017

@author: Libby
"""

#import time
#start = time.time()
#
#import numpy as np
#import matplotlib.pyplot as plt
#import scipy.io

exec(open("icerm_functions.py").read()) # python 3 (on laptop)
#execfile("icerm_functions.py") # python 2 (on oscar)
start = time.time()
np.random.seed(2017) # set seed for reproducible results

##N = 1000 # number of data points
##d = 10 # number of dimensions
##
##xmean = np.zeros(d)
##ymean = 10*np.ones(d)
##allx = np.array([np.random.normal(xmean) for j in range(N)])
##ally = np.array([np.random.normal(ymean) for j in range(N)])
##alldata10 = np.concatenate((allx,ally))
##
##N = 1000 # number of data points per cluster
##d = 100 # number of dimensions
##
##xmean = np.zeros(d)
##ymean = 10*np.ones(d)
##allx = np.array([np.random.normal(xmean) for j in range(N)])
##ally = np.array([np.random.normal(ymean) for j in range(N)])
##alldata100 = np.concatenate((allx,ally))
##
#
#testdata = np.array([[0,2],[1,0],[1,4],[2,2],[3,0],[3,4],[4,2],
#                     [10,2],[12,0],[12,2],[12,4],[14,1],[14,3]])
#            # top hubs should be [2,2], [12,2]
#test_distances = np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in testdata] for x in testdata])
#test_euc_nearest_neighbors = test_distances.argsort()
##plt.scatter(testdata.T[0],testdata.T[1],c=[hubness(i,testdata,3) for i in range(13)],
##            cmap="copper",s=100)
#
#
#def distances(allx):
#    return np.array([[np.sqrt(np.sum((x-y)*(x-y))) for y in allx] for x in allx])
#
#def nearest_neighbors(distance_matrix):
#    return distance_matrix.argsort()
#
#def hubness(i,nearest_neighbors,k):
#    #i = np.where(allx==x)
#    return len(np.where(nearest_neighbors.T[1:(k+1)]==i)[0])
#
#def dist_nn_hubness(allx,k):
#    d = distances(allx)
#    nn = nearest_neighbors(d)
#    h = np.array([hubness(i,nn,k) for i in range(len(allx))])
#    return [d,nn,h]
#    
#
##dist10 = distances(alldata10)
##nn10 = nearest_neighbors(dist10)
##hubness10 = [hubness(i,nn10,3) for i in range(len(alldata10))]
##[dist10,nn10,hubness10] = dist_nn_hubness(alldata10,3)
#
#
#def plot_by_hubness(pts, h):
#    horder = list(h.argsort())
#    plt.scatter(pts.T[0][horder], pts.T[1][horder],
#                c = h[horder], cmap="copper", s=60, linewidth=0)
#
#
#
#plt.interactive(True)
#
##plt.figure(0)
###plt.scatter(alldata10.T[0][list(hubness10.argsort())],
###            alldata10.T[1][list(hubness10.argsort())],
###            c=hubness10[hubness10.argsort()], cmap="copper",s=60,linewidth=0)
##plot_by_hubness(alldata10,hubness10)
##
##plt.figure(1)
##plt.hist(hubness10)
##
###dist100 = distances(alldata100)
###nn100 = nearest_neighbors(dist100)
###hubness100 = [hubness(i,nn100,3) for i in range(len(alldata100))]
##[dist100,nn100,hubness100] = dist_nn_hubness(alldata100,3)
##plt.figure(2)
##plt.hist(hubness100)
#
##plt.figure(3)
###plt.scatter(alldata100.T[0][list(hubness100.argsort())],
###            alldata100.T[1][list(hubness100.argsort())],
###            c=hubness100[hubness100.argsort()], cmap="copper",s=60,linewidth=0)
##plot_by_hubness(alldata100,hubness100)
#
#
#
#
## load Priya's data
#synthetic_data_30_50_overlap30 = scipy.io.loadmat("C://Users//Libby/Hubness/Datasets/synthetic_data_30_50_overlap30.mat")
#overlap_class0 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
#                   synthetic_data_30_50_overlap30["ground"]) if y==0])
#overlap_class1 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
#                   synthetic_data_30_50_overlap30["ground"]) if y==1])    
#
#overlap_class0_stats_k5 = dist_nn_hubness(overlap_class0,5)
#overlap_class1_stats_k5 = dist_nn_hubness(overlap_class1,5)
#overlap_global_stats_k5 = dist_nn_hubness(synthetic_data_30_50_overlap30["samples"],5)
#
#
#samples_30_50 = scipy.io.loadmat("C://Users/Libby/Hubness/Datasets/samples_30_50.mat")
#no_overlap_class0 = samples_30_50["samples"][:2500]
#no_overlap_class1 = samples_30_50["samples"][2500:]
#no_overlap_class0_stats_k5 = dist_nn_hubness(no_overlap_class0,30)
#no_overlap_class1_stats_k5 = dist_nn_hubness(no_overlap_class1,30)
#no_overlap_global_stats_k5 = dist_nn_hubness(np.concatenate((no_overlap_class0,no_overlap_class1)),30)
#plt.figure(4)
##plt.plot(class0hubness == bothhubness[:2500])
##plt.plot(class1hubness == bothhubness[2500:])
#
##
##
##plt.figure(5)
##plot_by_hubness(class0,class0hubness)
##plot_by_hubness(class1,class1hubness)
##
##plt.figure(6)
##plot_by_hubness(synthetic_data_30_50_overlap30["samples"].T[40:42].T,bothhubness)
#
#def random_spherical_separated_clusters(Ns,d,n,sep=10,dims_of_sep=1):
#    #N = 1000 # number of data points
#    #d = 10 # number of dimensions
#    #n = 2 # number of clusters
#    
#    alldata = np.zeros((sum(Ns),d))
#    running_N = 0
#    dim_sep = np.sqrt(sep*sep/dims_of_sep)
#    
#    for i in range(n):
#        N = Ns[i]
#        cmean = np.array([dim_sep*i]*dims_of_sep + [0]*(d-dims_of_sep))
#        #cmean = dim_sep*i*np.ones(d)
#        allc = np.array([np.random.normal(cmean) for j in range(N)])
#        alldata[running_N:(running_N+N)] = allc
#        running_N += N
#        
#    return alldata
#
#np.random.seed(2017)
#gaussians_1000_2000_30 = random_spherical_separated_clusters([1000,2000],30,2,10,1)
#gaussians_1000_3000_30 = random_spherical_separated_clusters([1000,3000],30,2,10,1)
#gaussians_1000_4000_30 = random_spherical_separated_clusters([1000,4000],30,2,10,1)
#gaussians_1000_5000_30 = random_spherical_separated_clusters([1000,5000],30,2,10,1)
#gaussians_1000_2000_60 = random_spherical_separated_clusters([1000,2000],60,2,10,1)
#gaussians_1000_3000_60 = random_spherical_separated_clusters([1000,3000],60,2,10,1)
#gaussians_1000_4000_60 = random_spherical_separated_clusters([1000,4000],60,2,10,1)
#gaussians_1000_5000_60 = random_spherical_separated_clusters([1000,5000],60,2,10,1)
#gaussians_1000_2000_100 = random_spherical_separated_clusters([1000,2000],100,2,10,1)
#gaussians_1000_3000_100 = random_spherical_separated_clusters([1000,3000],100,2,10,1)
#gaussians_1000_4000_100 = random_spherical_separated_clusters([1000,4000],100,2,10,1)
#gaussians_1000_5000_100 = random_spherical_separated_clusters([1000,5000],100,2,10,1)
#scipy.io.savemat("gaussians_1000_2000_30.mat",{"class0":gaussians_1000_2000_30[:1000],"class1":gaussians_1000_2000_30[1000:],"allsamples":gaussians_1000_2000_30,"class_indices":1000*[0]+2000*[1]})
#scipy.io.savemat("gaussians_1000_3000_30.mat",{"class0":gaussians_1000_3000_30[:1000],"class1":gaussians_1000_3000_30[1000:],"allsamples":gaussians_1000_3000_30,"class_indices":1000*[0]+3000*[1]}})
#scipy.io.savemat("gaussians_1000_4000_30.mat",{"class0":gaussians_1000_4000_30[:1000],"class1":gaussians_1000_4000_30[1000:],"allsamples":gaussians_1000_4000_30,"class_indices":1000*[0]+4000*[1]}})
#scipy.io.savemat("gaussians_1000_5000_30.mat",{"class0":gaussians_1000_5000_30[:1000],"class1":gaussians_1000_5000_30[1000:],"allsamples":gaussians_1000_5000_30,"class_indices":1000*[0]+5000*[1]}})
#scipy.io.savemat("gaussians_1000_2000_60.mat",{"class0":gaussians_1000_2000_60[:1000],"class1":gaussians_1000_2000_60[1000:],"allsamples":gaussians_1000_2000_60,"class_indices":1000*[0]+2000*[1]}})
#scipy.io.savemat("gaussians_1000_3000_60.mat",{"class0":gaussians_1000_3000_60[:1000],"class1":gaussians_1000_3000_60[1000:],"allsamples":gaussians_1000_3000_60,"class_indices":1000*[0]+3000*[1]}})
#scipy.io.savemat("gaussians_1000_4000_60.mat",{"class0":gaussians_1000_4000_60[:1000],"class1":gaussians_1000_4000_60[1000:],"allsamples":gaussians_1000_4000_60,"class_indices":1000*[0]+4000*[1]}})
#scipy.io.savemat("gaussians_1000_5000_60.mat",{"class0":gaussians_1000_5000_60[:1000],"class1":gaussians_1000_5000_60[1000:],"allsamples":gaussians_1000_5000_60,"class_indices":1000*[0]+5000*[1]}})
#scipy.io.savemat("gaussians_1000_2000_100.mat",{"class0":gaussians_1000_2000_100[:1000],"class1":gaussians_1000_2000_100[1000:],"allsamples":gaussians_1000_2000_100,"class_indices":1000*[0]+2000*[1]}})
#scipy.io.savemat("gaussians_1000_3000_100.mat",{"class0":gaussians_1000_3000_100[:1000],"class1":gaussians_1000_3000_100[1000:],"allsamples":gaussians_1000_3000_100,"class_indices":1000*[0]+3000*[1]}})
#scipy.io.savemat("gaussians_1000_4000_100.mat",{"class0":gaussians_1000_4000_100[:1000],"class1":gaussians_1000_4000_100[1000:],"allsamples":gaussians_1000_4000_100,"class_indices":1000*[0]+4000*[1]}})
#scipy.io.savemat("gaussians_1000_5000_100.mat",{"class0":gaussians_1000_5000_100[:1000],"class1":gaussians_1000_5000_100[1000:],"allsamples":gaussians_1000_5000_100,"class_indices":1000*[0]+5000*[1]}})
#


#start=time.time()
#N = 100
#d = 40
#n = 10
#sep = 3
#k = 5
#
#clust10 = random_spherical_separated_clusters(N,d,n,sep)
#local_stats_clust10 = [[]]*n
#for i in range(10):
#    locdata = clust10[(i*N):((i+1)*N)]
#    local_stats_clust10[i] = dist_nn_hubness(locdata,k)
#
#global_stats_clust10 = dist_nn_hubness(clust10,k)
#global_hubnesses = global_stats_clust10[2]
#local_hubnesses = np.concatenate([np.array(local_stats_clust10[i][2]) for i in range(10)])

#def above_n_sigmas(x,n):
#    m = np.mean(x)
#    s = np.std(x)
#    return [i for i in range(len(x)) if x[i] > m+n*s]
#
#opt = scipy.io.loadmat("C:/Users/Libby/Hubness/Datasets/data_opt.mat")
#start = time.time(); opt_global_stats = dist_nn_hubness(opt["data_sample"],5); end = time.time(); print(end-start)
#

#g_1_2_30 = scipy.io.loadmat("C:/Users/Libby/Documents/GitHub/wisdm-hubness/shared_data/gaussians_1000_2000_30.mat")
#g_1_2_30 = scipy.io.loadmat("../../shared_data/gaussians_1000_2000_30.mat")
#g_1_3_30 = scipy.io.loadmat("../../shared_data/gaussians_1000_3000_30.mat")
#g_1_4_30 = scipy.io.loadmat("../../shared_data/gaussians_1000_4000_30.mat")
#g_1_5_30 = scipy.io.loadmat("../../shared_data/gaussians_1000_5000_30.mat")
#g_1_2_60 = scipy.io.loadmat("../../shared_data/gaussians_1000_2000_60.mat")
#g_1_3_60 = scipy.io.loadmat("../../shared_data/gaussians_1000_3000_60.mat")
#g_1_4_60 = scipy.io.loadmat("../../shared_data/gaussians_1000_4000_60.mat")
#g_1_5_60 = scipy.io.loadmat("../../shared_data/gaussians_1000_5000_60.mat")
#g_1_2_100 = scipy.io.loadmat("../../shared_data/gaussians_1000_2000_100.mat")
#g_1_3_100 = scipy.io.loadmat("../../shared_data/gaussians_1000_3000_100.mat")
#g_1_4_100 = scipy.io.loadmat("../../shared_data/gaussians_1000_4000_100.mat")
#g_1_5_100 = scipy.io.loadmat("../../shared_data/gaussians_1000_5000_100.mat")
#u_1_2_30 = scipy.io.loadmat("../../shared_data/unif-dim30-1000-2000.mat")
#u_1_3_30 = scipy.io.loadmat("../../shared_data/unif-dim30-1000-3000.mat")
#u_1_4_30 = scipy.io.loadmat("../../shared_data/unif-dim30-1000-4000.mat")
#u_1_5_30 = scipy.io.loadmat("../../shared_data/unif-dim30-1000-5000.mat")
#u_1_2_60 = scipy.io.loadmat("../../shared_data/unif-dim60-1000-2000.mat")
#u_1_3_60 = scipy.io.loadmat("../../shared_data/unif-dim60-1000-3000.mat")
#u_1_4_60 = scipy.io.loadmat("../../shared_data/unif-dim60-1000-4000.mat")
#u_1_5_60 = scipy.io.loadmat("../../shared_data/unif-dim60-1000-5000.mat")
#u_1_2_100 = scipy.io.loadmat("../../shared_data/unif-dim100-1000-2000.mat")
#u_1_3_100 = scipy.io.loadmat("../../shared_data/unif-dim100-1000-3000.mat")
#u_1_4_100 = scipy.io.loadmat("../../shared_data/unif-dim100-1000-4000.mat")
#u_1_5_100 = scipy.io.loadmat("../../shared_data/unif-dim100-1000-5000.mat")

#global_stats_dict = {}
#global_stats_dict["g_1_2_30_globalhubness_k5"] = dist_nn_hubness(g_1_2_30["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_30_globalhubness_k5"] = dist_nn_hubness(g_1_3_30["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_30_globalhubness_k5"] = dist_nn_hubness(g_1_4_30["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_30_globalhubness_k5"] = dist_nn_hubness(g_1_5_30["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_60_globalhubness_k5"] = dist_nn_hubness(g_1_2_60["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_60_globalhubness_k5"] = dist_nn_hubness(g_1_3_60["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_60_globalhubness_k5"] = dist_nn_hubness(g_1_4_60["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_60_globalhubness_k5"] = dist_nn_hubness(g_1_5_60["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_100_globalhubness_k5"] = dist_nn_hubness(g_1_2_100["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_100_globalhubness_k5"] = dist_nn_hubness(g_1_3_100["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_100_globalhubness_k5"] = dist_nn_hubness(g_1_4_100["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_100_globalhubness_k5"] = dist_nn_hubness(g_1_5_100["allsamples"],5)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_30_globalhubness_k10"] = dist_nn_hubness(g_1_2_30["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_30_globalhubness_k10"] = dist_nn_hubness(g_1_3_30["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_30_globalhubness_k10"] = dist_nn_hubness(g_1_4_30["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_30_globalhubness_k10"] = dist_nn_hubness(g_1_5_30["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_60_globalhubness_k10"] = dist_nn_hubness(g_1_2_60["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_60_globalhubness_k10"] = dist_nn_hubness(g_1_3_60["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_60_globalhubness_k10"] = dist_nn_hubness(g_1_4_60["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_60_globalhubness_k10"] = dist_nn_hubness(g_1_5_60["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_100_globalhubness_k10"] = dist_nn_hubness(g_1_2_100["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_100_globalhubness_k10"] = dist_nn_hubness(g_1_3_100["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_100_globalhubness_k10"] = dist_nn_hubness(g_1_4_100["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_100_globalhubness_k10"] = dist_nn_hubness(g_1_5_100["allsamples"],10)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_30_globalhubness_k50"] = dist_nn_hubness(g_1_2_30["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_30_globalhubness_k50"] = dist_nn_hubness(g_1_3_30["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_30_globalhubness_k50"] = dist_nn_hubness(g_1_4_30["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_30_globalhubness_k50"] = dist_nn_hubness(g_1_5_30["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_60_globalhubness_k50"] = dist_nn_hubness(g_1_2_60["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_60_globalhubness_k50"] = dist_nn_hubness(g_1_3_60["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_60_globalhubness_k50"] = dist_nn_hubness(g_1_4_60["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_60_globalhubness_k50"] = dist_nn_hubness(g_1_5_60["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_2_100_globalhubness_k50"] = dist_nn_hubness(g_1_2_100["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_3_100_globalhubness_k50"] = dist_nn_hubness(g_1_3_100["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_4_100_globalhubness_k50"] = dist_nn_hubness(g_1_4_100["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
#global_stats_dict["g_1_5_100_globalhubness_k50"] = dist_nn_hubness(g_1_5_100["allsamples"],50)[2]
#scipy.io.savemat("global_stats.mat",global_stats_dict)
global_stats_dict["u_1_2_30_globalhubness_k5"] = dist_nn_hubness(u_1_2_30["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,30,k5\n")
global_stats_dict["u_1_3_30_globalhubness_k5"] = dist_nn_hubness(u_1_3_30["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,30,k5\n")
global_stats_dict["u_1_4_30_globalhubness_k5"] = dist_nn_hubness(u_1_4_30["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,30,k5\n")
global_stats_dict["u_1_5_30_globalhubness_k5"] = dist_nn_hubness(u_1_5_30["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,30,k5\n")
global_stats_dict["u_1_2_60_globalhubness_k5"] = dist_nn_hubness(u_1_2_60["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,60,k5\n")
global_stats_dict["u_1_3_60_globalhubness_k5"] = dist_nn_hubness(u_1_3_60["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,60,k5\n")
global_stats_dict["u_1_4_60_globalhubness_k5"] = dist_nn_hubness(u_1_4_60["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,60,k5\n")
global_stats_dict["u_1_5_60_globalhubness_k5"] = dist_nn_hubness(u_1_5_60["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,60,k5\n")
global_stats_dict["u_1_2_100_globalhubness_k5"] = dist_nn_hubness(u_1_2_100["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,100,k5\n")
global_stats_dict["u_1_3_100_globalhubness_k5"] = dist_nn_hubness(u_1_3_100["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,100,k5\n")
global_stats_dict["u_1_4_100_globalhubness_k5"] = dist_nn_hubness(u_1_4_100["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,100,k5\n")
global_stats_dict["u_1_5_100_globalhubness_k5"] = dist_nn_hubness(u_1_5_100["X"],5)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,100,k5\n")
global_stats_dict["u_1_2_30_globalhubness_k10"] = dist_nn_hubness(u_1_2_30["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,30,k10\n")
global_stats_dict["u_1_3_30_globalhubness_k10"] = dist_nn_hubness(u_1_3_30["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,30,k10\n")
global_stats_dict["u_1_4_30_globalhubness_k10"] = dist_nn_hubness(u_1_4_30["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,30,k10\n")
global_stats_dict["u_1_5_30_globalhubness_k10"] = dist_nn_hubness(u_1_5_30["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,30,k10\n")
global_stats_dict["u_1_2_60_globalhubness_k10"] = dist_nn_hubness(u_1_2_60["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,60,k10\n")
global_stats_dict["u_1_3_60_globalhubness_k10"] = dist_nn_hubness(u_1_3_60["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,60,k10\n")
global_stats_dict["u_1_4_60_globalhubness_k10"] = dist_nn_hubness(u_1_4_60["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,60,k10\n")
global_stats_dict["u_1_5_60_globalhubness_k10"] = dist_nn_hubness(u_1_5_60["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,60,k10\n")
global_stats_dict["u_1_2_100_globalhubness_k10"] = dist_nn_hubness(u_1_2_100["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,100,k10\n")
global_stats_dict["u_1_3_100_globalhubness_k10"] = dist_nn_hubness(u_1_3_100["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,100,k10\n")
global_stats_dict["u_1_4_100_globalhubness_k10"] = dist_nn_hubness(u_1_4_100["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,100,k10\n")
global_stats_dict["u_1_5_100_globalhubness_k10"] = dist_nn_hubness(u_1_5_100["X"],10)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,100,k10\n")
global_stats_dict["u_1_2_30_globalhubness_k50"] = dist_nn_hubness(u_1_2_30["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,30,k50\n")
global_stats_dict["u_1_3_30_globalhubness_k50"] = dist_nn_hubness(u_1_3_30["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,30,k50\n")
global_stats_dict["u_1_4_30_globalhubness_k50"] = dist_nn_hubness(u_1_4_30["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,4,30,k50\n")
global_stats_dict["u_1_5_30_globalhubness_k50"] = dist_nn_hubness(u_1_5_30["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,5,30,k50\n")
global_stats_dict["u_1_2_60_globalhubness_k50"] = dist_nn_hubness(u_1_2_60["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,2,60,k50\n")
global_stats_dict["u_1_3_60_globalhubness_k50"] = dist_nn_hubness(u_1_3_60["X"],50)[2]
scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
print(time.asctime(time.localtime())+" u 1,3,60,k50\n")


#global_stats_dict["u_1_4_60_globalhubness_k50"] = dist_nn_hubness(u_1_4_60["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,4,60,k50\n")
#global_stats_dict["u_1_5_60_globalhubness_k50"] = dist_nn_hubness(u_1_5_60["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,5,60,k50\n")
#global_stats_dict["u_1_2_100_globalhubness_k50"] = dist_nn_hubness(u_1_2_100["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,2,100,k50\n")
#global_stats_dict["u_1_3_100_globalhubness_k50"] = dist_nn_hubness(u_1_3_100["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,3,100,k50\n")
#global_stats_dict["u_1_4_100_globalhubness_k50"] = dist_nn_hubness(u_1_4_100["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,4,100,k50\n")
#global_stats_dict["u_1_5_100_globalhubness_k50"] = dist_nn_hubness(u_1_5_100["X"],50)[2]
#scipy.io.savemat("global_stats_uniform.mat",global_stats_dict)
#print(time.asctime(time.localtime())+" u 1,5,100,k50\n")

end = time.time()
print(start)
print(end)
print(end-start)
