# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 14:09:14 2017

@author: Libby
"""
execfile("icerm_functions.py")

np.random.seed(2017) # set seed for reproducible results

# test data set for checking hubness-computing functions
# (small enough to do things manually for learning purposes)
testdata = np.array([[0,2],[1,0],[1,4],[2,2],[3,0],[3,4],[4,2],
                     [10,2],[12,0],[12,2],[12,4],[14,1],[14,3]])
            # top hubs should be [2,2], [12,2]

# load Priya's data
synthetic_data_30_50_overlap30 = scipy.io.loadmat("C://Users//Libby/Hubness/Datasets/synthetic_data_30_50_overlap30.mat")
overlap_class0 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
                   synthetic_data_30_50_overlap30["ground"]) if y==0])
overlap_class1 = np.array([x for (x,y) in zip(synthetic_data_30_50_overlap30["samples"],
                   synthetic_data_30_50_overlap30["ground"]) if y==1])    

overlap_class0_stats_k5 = dist_nn_hubness(overlap_class0,5)
overlap_class1_stats_k5 = dist_nn_hubness(overlap_class1,5)
overlap_global_stats_k5 = dist_nn_hubness(synthetic_data_30_50_overlap30["samples"],5)


samples_30_50 = scipy.io.loadmat("C://Users/Libby/Hubness/Datasets/samples_30_50.mat")
no_overlap_class0 = samples_30_50["samples"][:2500]
no_overlap_class1 = samples_30_50["samples"][2500:]
no_overlap_class0_stats_k5 = dist_nn_hubness(no_overlap_class0,30)
no_overlap_class1_stats_k5 = dist_nn_hubness(no_overlap_class1,30)
no_overlap_global_stats_k5 = dist_nn_hubness(np.concatenate((no_overlap_class0,no_overlap_class1)),30)




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
scipy.io.savemat("gaussians_1000_2000_30.mat",{"class0":gaussians_1000_2000_30[:1000],"class1":gaussians_1000_2000_30[1000:]})
scipy.io.savemat("gaussians_1000_3000_30.mat",{"class0":gaussians_1000_3000_30[:1000],"class1":gaussians_1000_3000_30[1000:]})
scipy.io.savemat("gaussians_1000_4000_30.mat",{"class0":gaussians_1000_4000_30[:1000],"class1":gaussians_1000_4000_30[1000:]})
scipy.io.savemat("gaussians_1000_5000_30.mat",{"class0":gaussians_1000_5000_30[:1000],"class1":gaussians_1000_5000_30[1000:]})
scipy.io.savemat("gaussians_1000_2000_60.mat",{"class0":gaussians_1000_2000_60[:1000],"class1":gaussians_1000_2000_60[1000:]})
scipy.io.savemat("gaussians_1000_3000_60.mat",{"class0":gaussians_1000_3000_60[:1000],"class1":gaussians_1000_3000_60[1000:]})
scipy.io.savemat("gaussians_1000_4000_60.mat",{"class0":gaussians_1000_4000_60[:1000],"class1":gaussians_1000_4000_60[1000:]})
scipy.io.savemat("gaussians_1000_5000_60.mat",{"class0":gaussians_1000_5000_60[:1000],"class1":gaussians_1000_5000_60[1000:]})
scipy.io.savemat("gaussians_1000_2000_100.mat",{"class0":gaussians_1000_2000_100[:1000],"class1":gaussians_1000_2000_100[1000:]})
scipy.io.savemat("gaussians_1000_3000_100.mat",{"class0":gaussians_1000_3000_100[:1000],"class1":gaussians_1000_3000_100[1000:]})
scipy.io.savemat("gaussians_1000_4000_100.mat",{"class0":gaussians_1000_4000_100[:1000],"class1":gaussians_1000_4000_100[1000:]})
scipy.io.savemat("gaussians_1000_5000_100.mat",{"class0":gaussians_1000_5000_100[:1000],"class1":gaussians_1000_5000_100[1000:]})
