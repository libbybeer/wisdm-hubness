function [inds,isRkNN] = reverseKNNv2(Qinds,Rpts,k)

% reverseKNNv2 returns the indices of the reference points that are the 
% reverse k-nearest neighbors of the query points, which are assumed to be 
% a subset of the reference points. 
%
% INPUTS:
%       Qinds - qm by 1 binary vector of where are the query points in 
%               reference list
%       Rpts  - rm by n matrix of rm many query points in n dimensions
%       k     - integer number to determine k nearest neighbors
%
% OUTPUTS:
%       inds   - qm by k matrix of indices of Rpts i.e. inds(i,j) is the
%                index of Rpts that is the ith nearest neighbor to the jth 
%                point
%       isRkNN - rm by 1 logical array that indicates if the point in Rpts
%                was one of the k-nearest neighbors of Qpts
%
% Author: Marilyn Y. Vazquez

isRkNN = zeros(size(Rpts,1),1);
[~,inds] = pdist2(Rpts,Rpts,'euclidean','Smallest',k+1);
inds = inds(2:end,:)';
mask = zeros(size(isRkNN));
mask(unique(inds))=1;
isRkNN= mask & Qinds;