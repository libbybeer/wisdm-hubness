# Author: Jesse Metcalf-Burton (datasciencejess@gmail.com)
# Code written for WiSDM at ICERM, July 2017
# Originally run on the Oscar cluster at Brown University

setwd('/home/jesse/hubness/wisdm-hubness/users/jesse/')
source('hubness.R')

# This is where my data lives
dir='/home/jesse/hubness/wisdm-hubness/priya_data/'
filelist = list.files(dir)
realfiles = filelist[grepl('^data_', filelist)][-1] # leave out newsgroups, big.
# For each file, generate the ranked distance matrix and save it.
outputdir='/home/jesse/hubness/wisdm-hubness/users/jesse/rankeddistances/'
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
  
  outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
             filename, '.',k,'.png')
  png(outfile)
  par(mfrow=c(2, 2), oma=c(0,0,3,0))
  hist(mydist ,col='blue', breaks=100, freq=FALSE,
       main="(a) Distances between (all) points", xlab="Distance between points",
       xlim=c(0, max(mydist))) 
  mtext(paste0(k,"-Hubness on ", filename), side=3, line=1, outer=TRUE, cex=1.5, adj=.5)
  hist(intradist,
    main="(c) IntrA-cluster distances", freq=FALSE,
    xlab="Distance between same-cluster hubs",
    xlim=c(0, max(mydist)), col='blue', breaks=60)
  hist(mydist[highhubidx, highhubidx] ,col='blue', breaks=100, freq=FALSE,
       main="(b) Distances between hubs", xlab="Distance between hubs",
       xlim=c(0,max(mydist)))
  hist(interdist,
       main="(d) IntER-cluster distances", freq=FALSE,
       xlab="Distance between diff-cluster hubs",
       xlim=c(0, max(mydist)), col='blue', breaks=100)
  dev.off()
}
}
  

filenamesDF=data.frame(files=sort(realfiles), names=c("OCR", "Sonar", "Spam"))
getfname = function(f) {idx=which(filenamesDF$files==f); return(filenamesDF$names[idx])}

# For each file, get the ranked distance data 
# and compute hubness and draw pretty pictures
# WITHOUT knowledge of clusters for this one
outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
        'allfiles','.png')
png(outfile, width = 11, height=8.5, units="in", res=300)
par(mfcol=c(2, 3), mar=c(5.1,5.1,4.1,2.1), oma=c(0,0,3,0), 
    cex.lab=2, cex.main=2, cex.axis=2)
k=10
for (filename in realfiles){
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
    
    hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
         main=paste0(getfname(filename)," (points)"), xlab="Distance between points",
         xlim=c(0, max(mydist))) 
   
    hubdist=mydist[highhubidx, highhubidx]
    hist(hubdist[hubdist!=0] ,col='blue', breaks=100, freq=FALSE,
         main=paste0(getfname(filename)," (hubs, k=10)"), xlab="Distance between hubs",
         xlim=c(0,max(mydist)))
}
mtext(paste0("Distances Between Points in Real Data "), 
      side=3, line=1, outer=TRUE, cex=1.5, adj=.5,font=2)
dev.off()



# For each file, get the ranked distance data 
# and compute hubness and draw pretty pictures
# WITHOUT knowledge of clusters for this one
# WITHOUT limiting x axis
for (filename in realfiles){
  
  outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
                  filename,'allk.png')
  png(outfile, width = 11, height=8.5, units="in", res=300)
  par(mfcol=c(1, 3), mar=c(5.1,5.1,4.1,2.1),oma=c(0,0,3,0), 
      cex.lab=2, cex.main=2, cex.axis=2)

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
  
  for (k in c(5,10,50) ) {
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
    
    hubdist=mydist[highhubidx, highhubidx]
    hist(hubdist[hubdist!=0] ,col='blue', breaks=100, freq=FALSE,
         main=paste0("k=",k), xlab="Distance between hubs")
         #xlim=c(0,max(mydist)))
  }
  mtext(paste0("Distances Between Hubs on ", getfname(filename), " Data"), 
        side=3, line=1, outer=TRUE, cex=1.5, adj=.5, font=2)
  dev.off()
}

# plot distance between points for real data files
outfile =paste0("/home/jesse/hubness/wisdm-hubness/users/jesse/graphs/", 
                'realdatadist.png')
png(outfile, width = 11, height=8.5, units="in", res=300)
par(mfcol=c(1, 3), oma=c(0,0,3,0))
for (filename in realfiles){
    matdata = readMat(paste0(dir,filename), sparseMatrixClass='matrix')
    mydata = matdata$data.sample
    mydist = as.matrix(dist(mydata, method='euclidean'))
 
    hist(mydist[mydist!=0] ,col='blue', breaks=100, freq=FALSE,
         main=paste0(filename), xlab="Distance between points",
         xlim=c(0, max(mydist)), cex.lab=1.5, cex.main=1.5) 

  mtext(paste0("Distances Between Points in Real Data Sets"), 
        side=3, line=1, outer=TRUE, cex=1.5, adj=.5)
}
dev.off()
