function [inds,isRkNN] = reverseKNN(Qpts,Rpts,k)

% reverseKNN returns the indices of the reference points that are the 
% reverse k-nearest neighbors of the query points. 
%
% INPUTS:
%       Qpts - qm by n matrix of qm many query points in n dimensions
%       Rpts - rm by n matrix of rm many query points in n dimensions
%       k    - integer number to determine k nearest neighbors
%
% OUTPUTS:
%       inds   - qm by k matrix of indices of Rpts i.e. inds(i,j) is the
%                index of Rpts that is the ith nearest neighbor to the jth 
%                point in Qpts
%       isRkNN - rm by 1 logical array that indicates if the point in Rpts
%                was one of the k-nearest neighbors of Qpts
%
% Author: Marilyn Y. Vazquez

isRkNN = zeros(size(Rpts,1),1);
[~,inds] = pdist2(Rpts,Qpts,'euclidean','Smallest',k+1);
inds = inds(2:end,:)';
di= unique(inds);
isRkNN(di)=1;
isRkNN = logical(isRkNN);