# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 14:09:14 2017

@author: Libby
"""



import numpy as np
import scipy.io


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

np.random.seed(2017)
gaussians_1000_2000_30 = random_spherical_separated_clusters([1000,2000],30,2,10,1)
gaussians_1000_3000_30 = random_spherical_separated_clusters([1000,3000],30,2,10,1)
gaussians_1000_4000_30 = random_spherical_separated_clusters([1000,4000],30,2,10,1)
gaussians_1000_5000_30 = random_spherical_separated_clusters([1000,5000],30,2,10,1)
gaussians_1000_2000_60 = random_spherical_separated_clusters([1000,2000],60,2,10,1)
gaussians_1000_3000_60 = random_spherical_separated_clusters([1000,3000],60,2,10,1)
gaussians_1000_4000_60 = random_spherical_separated_clusters([1000,4000],60,2,10,1)
gaussians_1000_5000_60 = random_spherical_separated_clusters([1000,5000],60,2,10,1)
gaussians_1000_2000_100 = random_spherical_separated_clusters([1000,2000],100,2,10,1)
gaussians_1000_3000_100 = random_spherical_separated_clusters([1000,3000],100,2,10,1)
gaussians_1000_4000_100 = random_spherical_separated_clusters([1000,4000],100,2,10,1)
gaussians_1000_5000_100 = random_spherical_separated_clusters([1000,5000],100,2,10,1)
scipy.io.savemat("gaussians_1000_2000_30.mat",{"class0":gaussians_1000_2000_30[:1000],"class1":gaussians_1000_2000_30[1000:],"allsamples":gaussians_1000_2000_30,"class_indices":np.array(1000*[0]+2000*[1])})
scipy.io.savemat("gaussians_1000_3000_30.mat",{"class0":gaussians_1000_3000_30[:1000],"class1":gaussians_1000_3000_30[1000:],"allsamples":gaussians_1000_3000_30,"class_indices":np.array(1000*[0]+3000*[1])})
scipy.io.savemat("gaussians_1000_4000_30.mat",{"class0":gaussians_1000_4000_30[:1000],"class1":gaussians_1000_4000_30[1000:],"allsamples":gaussians_1000_4000_30,"class_indices":np.array(1000*[0]+4000*[1])})
scipy.io.savemat("gaussians_1000_5000_30.mat",{"class0":gaussians_1000_5000_30[:1000],"class1":gaussians_1000_5000_30[1000:],"allsamples":gaussians_1000_5000_30,"class_indices":np.array(1000*[0]+5000*[1])})
scipy.io.savemat("gaussians_1000_2000_60.mat",{"class0":gaussians_1000_2000_60[:1000],"class1":gaussians_1000_2000_60[1000:],"allsamples":gaussians_1000_2000_60,"class_indices":np.array(1000*[0]+2000*[1])})
scipy.io.savemat("gaussians_1000_3000_60.mat",{"class0":gaussians_1000_3000_60[:1000],"class1":gaussians_1000_3000_60[1000:],"allsamples":gaussians_1000_3000_60,"class_indices":np.array(1000*[0]+3000*[1])})
scipy.io.savemat("gaussians_1000_4000_60.mat",{"class0":gaussians_1000_4000_60[:1000],"class1":gaussians_1000_4000_60[1000:],"allsamples":gaussians_1000_4000_60,"class_indices":np.array(1000*[0]+4000*[1])})
scipy.io.savemat("gaussians_1000_5000_60.mat",{"class0":gaussians_1000_5000_60[:1000],"class1":gaussians_1000_5000_60[1000:],"allsamples":gaussians_1000_5000_60,"class_indices":np.array(1000*[0]+5000*[1])})
scipy.io.savemat("gaussians_1000_2000_100.mat",{"class0":gaussians_1000_2000_100[:1000],"class1":gaussians_1000_2000_100[1000:],"allsamples":gaussians_1000_2000_100,"class_indices":np.array(1000*[0]+2000*[1])})
scipy.io.savemat("gaussians_1000_3000_100.mat",{"class0":gaussians_1000_3000_100[:1000],"class1":gaussians_1000_3000_100[1000:],"allsamples":gaussians_1000_3000_100,"class_indices":np.array(1000*[0]+3000*[1])})
scipy.io.savemat("gaussians_1000_4000_100.mat",{"class0":gaussians_1000_4000_100[:1000],"class1":gaussians_1000_4000_100[1000:],"allsamples":gaussians_1000_4000_100,"class_indices":np.array(1000*[0]+4000*[1])})
scipy.io.savemat("gaussians_1000_5000_100.mat",{"class0":gaussians_1000_5000_100[:1000],"class1":gaussians_1000_5000_100[1000:],"allsamples":gaussians_1000_5000_100,"class_indices":np.array(1000*[0]+5000*[1])})

