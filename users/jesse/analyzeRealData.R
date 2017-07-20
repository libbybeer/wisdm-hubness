# Author: Jesse Metcalf-Burton (datasciencejess@gmail.com)
# Code written for WiSDM at ICERM, July 2017
# Originally run on the Oscar cluster at Brown University

setwd('/users/guest427/wisdm-hubness/users/jesse/')
source('hubness.R')

# This is where my data lives
dir='/users/guest427/wisdm-hubness/priya_data/'
filelist = list.files(dir)
realfiles = filelist[grepl('^data_', filelist)][-1] # leave out newsgroups, big.
# For each file, generate the ranked distance matrix and save it.
outputdir = '/users/guest427/wisdm-hubness/users//jesse/rankeddistances/'
for (filename in realfiles) {
  matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
  # put together the cluster labels for ground truth
  ground = matdata$ground
  n = length(ground)
  # Put together the data points
  mydata = matdata$data.sample
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
for (filename in realfiles){
  for (k in c(5,10,50) ) {
    matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
    # put together the cluster labels for ground truth
    ground = matdata$ground
    n = length(ground)
    # Put together the data points
    mydata = matdata$data.sample
  # Check what we have
  n
  myclasses = as.data.frame(table(ground))$ground
  # Get the hubness scores

  mydist = as.matrix(dist(mydata, method='euclidean'))
  rankedmatdata = read.table(paste0(outputdir, filename, '.ranked'))
  hubscores = all_hubness(k, rankedmatdata)
  
  # Find my "hubs"
  highhubidx = which(hubscores > mean(hubscores) + 2*sd(hubscores))
  
  intradist = c()
  interdist = c()
  for (c in myclasses){
    intraidx = intersect(highhubidx, which(ground==c))
    intradist = c(intradist, 
                  mydist[intraidx, intraidx])
    for (d in as.numeric(setdiff(myclasses, c))){
      intraidx2 = intersect(highhubidx, which(ground==d))
      interdist = c(interdist,
                    mydist[intraidx, intraidx2],
                    mydist[intraidx2, intraidx])
    }
  }
  
  # Look at them in all the ways
  # How many hubs per cluster?
  hubperclust = table(ground[highhubidx])
  hubperclust
  # what percent of points in the cluster are hubs?
  hubperclust / table(ground)
  # Look at distances between points, and distances between hubs
  intramean = mean(intradist)
  intermean = mean(interdist)
  
  outfile =paste0("/users/guest427/wisdm-hubness//users/jesse//graphs/", 
             filename, '.',k,'.png')
  png(outfile)
  par(mfrow=c(2, 2))
  hist(mydist ,col='blue', breaks=100, freq=FALSE,
       main="Distances between (all) points", xlab="Distance between points",
       xlim=c(0, max(mydist))) 
  mtext(outfile, side=3, line=3)  
  hist(intradist,
    main="IntrA-cluster distances", freq=FALSE,
    xlab="Distance between same-cluster hubs",
    xlim=c(0, max(mydist)), col='blue', breaks=60)
  hist(mydist[highhubidx, highhubidx] ,col='blue', breaks=100, freq=FALSE,
       main="Distances between hubs", xlab="Distance between hubs",
       xlim=c(0,max(mydist)))
  hist(interdist,
       main="IntER-cluster distances", freq=FALSE,
       xlab="Distance between diff-cluster hubs",
       xlim=c(0, max(mydist)), col='blue', breaks=100)
  dev.off()
}
}
  
