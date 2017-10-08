function [purity] = clusterPurity(trueClass,predictedCluster)

% clusterPurity calculates the purity measure of a predicted cluster 
% labeling given true class labels
%
% INPUTS:
%       trueClass        - N by 1 array of true class labels
%       predictedCluster - N by 1 array of predicted cluster labels
%
% OUTPUTS:
%       purity - number between 0 and 1 that gives the purity measure
%       defined to be: (1/N)*\sum_i (\max_j(|cluster_i \intersect class_j|))
%
% Author: Marilyn Y. Vazquez


if sum(size(trueClass)== size(predictedCluster))~=2
    error('Both inputs need to be arrays of size (number of points) by (1)')
end

N = length(trueClass);
n1 = min(trueClass);
n2 = max(trueClass);
n = n2 - n1 +1;
m1 = min(predictedCluster);
m2 = max(predictedCluster);
purity = 0;

for i=m1:m2
    fi = zeros(n,1);
    clusi = (predictedCluster==i);
    for j=n1:n2
        classj = (trueClass == j);
        fi(j-n1+1) = sum(clusi.*classj);
    end
    purity = purity + max(fi);
end

purity = purity/N;