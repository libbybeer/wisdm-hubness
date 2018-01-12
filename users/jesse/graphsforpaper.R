setwd('/home/jesse/hubness/wisdm-hubness/users/jesse/')
source('hubness.R')

# This is where my data lives
dir='/home/jesse/hubness/wisdm-hubness/shared_data/'
filelist = list.files(dir)[-1] # skip the first file, which is a .py script


###### Gaussian ##########
filename="gaussians_1000_3000_100.mat"
k=10
matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
# put together the cluster labels for ground truth
ground = c(rep(0,dim(matdata$class0)[1]),
           rep(1, dim(matdata$class1)[1]))
n = length(ground)
# Put together the data points
mydata = rbind(matdata$class0, matdata$class1)
# Check what we have
n
table(ground)
# Get the hubness scores

mydist = as.matrix(dist(mydata, method='euclidean'))
rankedmatdata = read.table(paste0(outputdir, filename, '.ranked'))
hubscores = all_hubness(k, rankedmatdata)

# Find my "hubs"
highhubidx = which(hubscores > mean(hubscores) + 2*sd(hubscores))
highhubidx0 = intersect(highhubidx, which(ground==0))
highhubidx1 = intersect(highhubidx, which(ground==1))

# Look at them in all the ways
# How many hubs per cluster?
hubperclust = table(ground[highhubidx])
hubperclust
# what percent of points in the cluster are hubs?
hubperclust / table(ground)
# Look at distances between points, and distances between hubs
intramean = mean(c(mydist[highhubidx0, highhubidx0], mydist[highhubidx1, highhubidx1]))
intermean = mean(c(mydist[highhubidx0, highhubidx1], mydist[highhubidx1, highhubidx0]))

outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
                "gaussian", '.forpaper.',k,'.png')
png(outfile, width=8, height=8, units="in", res=300)
par(mfrow=c(2, 2),  mar=c(5.1, 4.1, 4.1, 2.1),
    oma = c(0,0,3,0), cex.lab=1.5, cex.main=1.5, cex.axis=1.5)
xlimits=c(min(mydist[mydist!=0]),max(mydist))
hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
     main="(a) Distances between (all) points", xlab="Distance between points",
     xlim=xlimits) 
abline(v=intermean+2, col='orange', lwd=2)
abline(v=intramean+2, col='orange', lwd=2)
mtext(paste0("G_100_3000, k=10"), 
      side=3, line=1, cex=1.5, adj=.5, outer = TRUE, font=2)
hubdist=c(mydist[highhubidx0, highhubidx0],mydist[highhubidx1, highhubidx1])
hist(hubdist[hubdist!=0],
     main="(c) IntrA-cluster distances", freq=FALSE,
     xlab="Distance between same-cluster hubs",
     xlim=xlimits, col='blue', breaks=100)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)
hubdist=mydist[highhubidx, highhubidx] 
hist(hubdist[hubdist!=0],col='blue', breaks=100, freq=FALSE,
     main="(b) Distances between hubs", xlab="Distance between hubs",
     xlim=xlimits)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)
hubdist=c(mydist[highhubidx0, highhubidx1],mydist[highhubidx1, highhubidx0])
hist(hubdist[hubdist!=0],
     main="(d) IntER-cluster distances", freq=FALSE,
     xlab="Distance between diff-cluster hubs",
     xlim=xlimits, col='blue', breaks=100)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)

dev.off()


############### Uniform ############
filename="unif-dim100-1000-3000.mat"   
mydata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')[[1]]
# put together the cluster labels for ground truth
n=dim(mydata)[1]
ground = c(rep(0,1000), 
           rep(1, (n-1000)))
# Check what we have
n
table(ground)
# Get the hubness scores

mydist = as.matrix(dist(mydata, method='euclidean'))
rankedmatdata = read.table(paste0(outputdir, filename, '.ranked'))
hubscores = all_hubness(k, rankedmatdata)

# Find my "hubs"
highhubidx = which(hubscores > mean(hubscores) + 2*sd(hubscores))
highhubidx0 = intersect(highhubidx, which(ground==0))
highhubidx1 = intersect(highhubidx, which(ground==1))

# Look at them in all the ways
# How many hubs per cluster?
hubperclust = table(ground[highhubidx])
hubperclust
# what percent of points in the cluster are hubs?
hubperclust / table(ground)
# Look at distances between points, and distances between hubs
intramean = mean(c(mydist[highhubidx0, highhubidx0], mydist[highhubidx1, highhubidx1]))
intermean = mean(c(mydist[highhubidx0, highhubidx1], mydist[highhubidx1, highhubidx0]))

outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
                "uniform", '.forpaper.',k,'.png')
png(outfile, height=8, width=8, units="in", res=300)
par(mfrow=c(2, 2), oma = c(0,0,3,0), cex.lab=1.5, cex.main=1.5, cex.axis=1.5)
xlimits=c(min(mydist[mydist!=0]),max(mydist))
hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
     main="(a) Distances between (all) points", xlab="Distance between points",
     xlim=xlimits) 
abline(v=intermean+.5, col='orange', lwd=2)
abline(v=intramean+.5, col='orange', lwd=2)
mtext(paste0("U_100_3000, k=10"), 
      side=3, line=1, cex=1.5, adj=.5, outer = TRUE, font=2)
hubdist=c(mydist[highhubidx0, highhubidx0],mydist[highhubidx1, highhubidx1])
hist(hubdist[hubdist!=0],
     main="(c) IntrA-cluster distances", freq=FALSE,
     xlab="Distance between same-cluster hubs",
     xlim=xlimits, col='blue', breaks=100)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)
hubdist=mydist[highhubidx, highhubidx] 
hist(hubdist[hubdist!=0],col='blue', breaks=100, freq=FALSE,
     main="(b) Distances between hubs", xlab="Distance between hubs",
     xlim=xlimits)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)
hubdist=c(mydist[highhubidx0, highhubidx1],mydist[highhubidx1, highhubidx0])
hist(hubdist[hubdist!=0],
     main="(d) IntER-cluster distances", freq=FALSE,
     xlab="Distance between diff-cluster hubs",
     xlim=xlimits, col='blue', breaks=100)
abline(v=intermean, col='orange', lwd=2)
abline(v=intramean, col='orange', lwd=2)

dev.off()

############## Real Data #############

