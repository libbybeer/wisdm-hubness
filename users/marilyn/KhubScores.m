function [N_k,hubs] = KhubScores(X,k)

% KhubScores calculates the hubness scores given a k
%
% INPUTS:
%       X - N by d matrix of points
%       k - integer number indicating up to which k-nearest neighbor to
%           count 
%
% OUTPUTS:
%       N_k - N by 1 array of hubness scores for each point in X
%       hubs- N by 1 logical array of points that are considered hubs
%
% Author: Marilyn Y. Vazquez

%%% Set up
[M,~] = size(X);% number of points
N_k = zeros(M,1);% hubness score
hubs = zeros(M,1);% which are hubs

%%% Indices of k-nearest neighbors
[~,inds] = pdist2(X,X,'euclidean','Smallest',k+1);
inds = inds(2:end,:)';

%%% Calculate hubs score
for i=1:M
    N_k(inds(i,:)) = N_k(inds(i,:)) +1;
end

%%% Binary: 1= hubs
ub = mean(N_k) + 2*std(N_k);
hubs(N_k> ub)=1;
