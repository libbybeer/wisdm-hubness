function [Nd,q,inds,d] = KDE(Rpts,Epts,ka,kL)

% SCLOCKERN calculates the Local Density for Spectral Clustering algorithm.
%
% INPUT:
%       Rpts  - nn by d vector containing the coordinates of all the 
%               reference points
%       Epts  - nn by d vector containing the coordinates of all the 
%               evaluation (query) points
%       kL     - Number of nearest neighbors (4\leq k \geq 64)
% OUTPUT:
%       Nd    - nn by kL matrix containing the point-wise distance
%               i.e. Xdis(i,j) = distance from point i to point j
%       q     - nn by 1 vector containing the local density for each point
%       ind   - the indices for the kL nearest neighboors distance
%       d     - Calculated dimension

[nn,~] = size(Rpts);% nn - # of points, td - dimension of points
% [mm,~] = size(Epts);
[Nd,inds] = knnCPU(Rpts,Epts,kL,1);
[Nd2,inds2] = knnCPU(Rpts,Rpts,kL,1);
% Xdis = zeros(mm,nn);
% Xd = zeros(mm,mm);
% 
% for i=1:mm
%     Xdis(i,inds(i,:))=Nd(i,:);
%     temp1 = Xdis(i,:);
%     Xd(i,:) = temp1(temp1~=0);
% end
phi = sqrt(sum(Nd(:,1:ka).^2,2));
phi2 = sqrt(sum(Nd2(:,1:ka).^2,2));

l = -30:0.1:10; %(2b)
del = 2.^l;
del = del';
nl = length(l);

% Calculating dimension
T= zeros(nl,1);
% tic
temp = -Nd.^2./repmat(phi,1,kL)./phi2(inds);
temp2 = -Nd2.^2./repmat(phi2,1,kL)./phi2(inds2);
for ll=1:nl
    T(ll) = sum(sum(exp(temp2/(4*del(ll)^2))));
end
% tm = toc;

al = diff(log(T))./diff(log(del));
[d,ind] = max(al);%(2e)
ndel = del(ind+1);%(2e)

% Local density
q = sum(exp(temp/(4*ndel^2)),2)./(nn*pi^(d/2)*(2*phi*ndel).^d);