library(R.matlab) # to read in .mat data files
library(doParallel) # to paralellize computations
cl <- makeCluster(1)  
registerDoParallel(cl)  

# This function we call once per data set, 
# then we can compute all hubnesses from the resulting matrix
rankdist <- function(x){  
  n = dim(x)[1]
  foreach(i=1:n, .combine=rbind) %dopar% {
    # replace distances with their rank
    # (ie for each point, say which position nearest-neighbor it is from i)    # say a point is rank 0 from itself (I am not my own neighbor)
    rank(x[i,], ties.method='first')-1
  }
}

hubness <- function(i,k, rankeddist) {
  # Given i and k, return N_k(i)
  # a point is not his own neighbor
  return(sum(rankeddist[,i] <= k & rankeddist[,i]!=0))
}

# Get the hubness for all points
all_hubness <- function(k, rankeddist) {
  n = dim(rankeddist)[1]
  sapply(1:n, hubness, k=k, rankeddist=rankeddist)
}