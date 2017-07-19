function [N_k,hubs] = KhubScores(X,k)

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
