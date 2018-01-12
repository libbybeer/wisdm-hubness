# Author: Jesse Metcalf-Burton (datasciencejess@gmail.com)
# Code written for WiSDM at ICERM, July 2017
# Originally run on the Oscar cluster at Brown University

setwd('/home/jesse/hubness/wisdm-hubness/users/jesse/')
source('hubness.R')

# This is where my data lives
dir='/home/jesse/hubness/wisdm-hubness/shared_data/'
filelist = list.files(dir)[-1] # skip the first file, which is a .py script

gaussfiles = filelist[grepl('gaussians', filelist)]
uniformfiles = filelist[grepl('unif', filelist)]

# For each file, generate the ranked distance matrix and save it.
outputdir = '/home/jesse/hubness/wisdm-hubness/users/jesse/rankeddistances/'
for (filename in gaussfiles) {
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
  rankedmatdata = rankdist(mydist)
  write.table(rankedmatdata, file=paste0(outputdir, filename,'.ranked'),
              col.names=FALSE, row.names=FALSE)
}

# Write out ranked distance matrices for uniform data
for (filename in uniformfiles) {
  mydata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')[[1]]
  # put together the cluster labels for ground truth
  # Have 1000 data points in 0 class, the rest are class 1
  n=dim(mydata)[1]
  ground = c(rep(0,1000), 
             rep(1, (n-1000)))
  # Check what we have
  n
  table(ground)
  # Get the hubness scores
  mydist = as.matrix(dist(mydata, method='euclidean'))
  rankedmatdata = rankdist(mydist)
  write.table(rankedmatdata, file=paste0(outputdir, filename,'.ranked'),
              col.names=FALSE, row.names=FALSE)
}

# For each file, get the ranked distance data 
# and compute hubness and draw pretty pictures
for (filename in gaussfiles){
  for (k in c(5,10,50) ) {
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
             filename, '.',k,'.png')
  png(outfile, width=8, height=8, units="in", res=300)
  par(mfrow=c(2, 2),  mar=c(5.1, 5.1, 4.1, 2.1),
      oma = c(0,0,3,0))
  xlimits = c(min(mydist[mydist!=0]), max(mydist))
  hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
       main="(a) Distances between (all) points", xlab="Distance between points",
       xlim=xlimits) 
  abline(v=intermean+2, col='orange', lwd=2)
  abline(v=intramean+2, col='orange', lwd=2)
  mtext(paste0(k,"-Hubness on ", filename), 
        side=3, line=1, cex=1.5, adj=.5, outer = TRUE)
  hubdist=c(mydist[highhubidx0, highhubidx0],mydist[highhubidx1, highhubidx1])
  hist(hubdist[hubdist!=0],
    main="(c) IntrA-cluster distances", freq=FALSE,
    xlab="Distance between same-cluster hubs",
    xlim=xlimits, col='blue', breaks=100)
  abline(v=intermean, col='orange', lwd=2)
  abline(v=intramean, col='orange', lwd=2)
  hubdist=mydist[highhubidx, highhubidx]
  hist(hubdist[hubdist!=0] ,col='blue', breaks=100, freq=FALSE,
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
}
}
  
## And now for the uniform files, which have a slightly different format
for (filename in uniformfiles){
  for (k in c(5,10,50) ) {
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
                    filename, '.',k,'.png')
    png(outfile)
    par(mfrow=c(2, 2), oma = c(0,0,3,0))
    xlimits=c(min(mydist),max(mydist))
    hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
         main="(a) Distances between (all) points", xlab="Distance between points",
         xlim=xlimits) 
    abline(v=intermean+.5, col='orange', lwd=2)
    abline(v=intramean+.5, col='orange', lwd=2)
    mtext(paste0(k,"-Hubness on ", filename), 
          side=3, line=1, cex=1.5, adj=.5, outer = TRUE)
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
  }
}
  

# Pony now applying one trick to Priya's 30/50 data
# Write out ranked distance matrices
dir = '/users/guest427/wisdm-hubness/priya_data/'
filelist = list.files(dir)
priyafiles = filelist[grepl('30_50', filelist)][-1]
for (filename in priyafiles) {
  matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
  mydata=matdata$samples
  # put together the cluster labels for ground truth
  # Have 1000 data points in 0 class, the rest are class 1
  n=dim(mydata)[1]
  ground = matdata$ground
  # Check what we have
  n
  table(ground)
  # Get the hubness scores
  mydist = as.matrix(dist(mydata, method='euclidean'))
  rankedmatdata = rankdist(mydist)
  write.table(rankedmatdata, file=paste0(outputdir, filename,'.ranked'),
              col.names=FALSE, row.names=FALSE)
}

# Draw pictures
for (filename in priyafiles){
  for (k in c(5,10,50) ) {
    matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
    # put together the cluster labels for ground truth
    mydata=matdata$samples
    n=dim(mydata)[1]
    ground = matdata$ground
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
    
    outfile =paste0("/users/guest427/wisdm-hubness//users/jesse//graphs/", 
                    filename, '.',k,'.png')
    png(outfile)
    par(mfrow=c(2, 2))
    hist(mydist ,col='blue', breaks=100, freq=FALSE,
         main="Distances between (all) points", xlab="Distance between points",
         xlim=c(0, max(mydist))) 
    mtext(outfile, side=3, line=3)
#    hist(c(mydist[highhubidx0, highhubidx0]),
#         main="IntrA-cluster distances (cluster 0)", freq=FALSE,
#         xlab="Distance between cluster-0 hubs",
#         xlim=c(0, max(mydist)), col='blue', breaks=100)
    hist(c(mydist[highhubidx0, highhubidx0],
          mydist[highhubidx1, highhubidx1]),
         main="IntrA-cluster distances", freq=FALSE,
         xlab="Distance between same-cluster hubs",
         xlim=c(0, max(mydist)), col='blue', breaks=100)
    hist(mydist[highhubidx, highhubidx] ,col='blue', breaks=100, freq=FALSE,
         main="Distances between hubs", xlab="Distance between hubs",
         xlim=c(0,max(mydist)))
#    hist(c(mydist[highhubidx1, highhubidx1]),
#         main="IntrA-cluster distances (cluster 1)", freq=FALSE,
#         xlab="Distance between cluster-1 hubs",
#         xlim=c(0, max(mydist)), col='blue', breaks=100)

    hist(c(mydist[highhubidx0, highhubidx1],mydist[highhubidx1, highhubidx0]),
         main="IntER-cluster distances", freq=FALSE,
         xlab="Distance between diff-cluster hubs",
         xlim=c(0, max(mydist)), col='blue', breaks=100)
    #abline(v=intermean, col='orange', lwd=2)
    #abline(v=intramean, col='orange', lwd=2)
    
    dev.off()
  }
}

