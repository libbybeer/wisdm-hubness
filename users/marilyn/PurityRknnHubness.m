% Purity measures for rKNN's of points with hubness scores greater than thr
% Author: Marilyn Y. Vazquez

knn = [5 10 50];
lk = length(knn);

% Gaussian

load('gaussians_1000_2000_60.mat')
data = allsamples;
lbl = class_indices;
for k=1:lk
    load(['gauss-hubness60-1000-5000-k' num2str(knn(k)) '.mat'])
    mn = min(N_k);
    mx = max(N_k);
    rn = mx-mn;
    NkP = zeros(rn,1);
    nlbl = zeros(length(lbl),1);
    for j=mn:mx-1
        inds = N_k >j;
        lbl1 = lbl(inds);
        [rkNN,~] = reverseKNN(data(inds,:),data,knn(k));
        
    end
end




% load('unif-hubness60-1000-5000-k50.mat')
% data2 = allsamples;
% lbl2 = class_indices;
% N_k2 = N_k;
%
% data3 = load('SQmoons-hubness-dim60-6000-k50.txt');
% lbl3 = load('SQmoonsLbls-dim60-6000.txt');
% N_k3 = N_k;

