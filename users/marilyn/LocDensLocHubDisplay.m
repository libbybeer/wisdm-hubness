% Trying to display the four quadrants of low/high density and low/high hubness
% Author: Marilyn Y. Vazquez

dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = [5 10 50];
dcolor = ['k' 'b' 'c' 'r'];
kmarker = ['x' '*' 'o'];

ld = length(dim);
lr = length(dr);
lk = length(knn);


% Gaussian
grid_valsg1 = zeros(ld*lr*lk,4);
grid_valsg2 = zeros(ld*lr*lk,4);
names_grids1 = cell(ld*lr*lk,1);
count = 1;
disp('top left, top right,, bottom left, bottom right')
for i=1:ld
    for j=1:lr
        for k=1:lk
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             load(['gauss-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            load(['gauss-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])

%             hubs = logical(hubs);
            hubs1 = logical(hubs(1:1000));
            hubs2 = logical(hubs(1001:end));
            nothubs1 = ~hubs1;
            nothubs2 = ~hubs2;
%             thr = mean(q)+2*std(q);
            thr1 = mean(q(1:1000))+2*std(q(1:1000));
            thr2 = mean(q(1001:end))+2*std(q(1001:end));
%             dense = q>= thr;
%             notdense = q< thr;
            dense1 = q(1:1000)>= thr1;
            notdense1 = q(1:1000)< thr1;
            dense2 = q(1001:end)>= thr2;
            notdense2 = q(1001:end)< thr2;
            tl1 = sum(hubs1.*notdense1);
            tr1 = sum(hubs1.*dense1);
            bl1 = sum(nothubs1.*notdense1);
            br1 = sum(nothubs1.*dense1);
            tl2 = sum(hubs2.*notdense2);
            tr2 = sum(hubs2.*dense2);
            bl2 = sum(nothubs2.*notdense2);
            br2 = sum(nothubs2.*dense2);
%             disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k))])
%             grid_vals = 100*[tl tr bl br]./size(q,1);
%             grid_vals = 100*[tl tr bl br]./size(q(1:1000),1)
%             grid_vals(count,:) = 100*[tl tr bl br]./size(q(1001:end),1);
            grid_valsg1(count,:) = 100*[tl1, tr1 bl1 br1]./1000;
            grid_valsg2(count,:) = 100*[tl2, tr2 bl2 br2]./length(q(1001:end));
            count = count+1;
        end
    end
end

% Uniform
grid_valsu1 = zeros(ld*lr*lk,4);
grid_valsu2 = zeros(ld*lr*lk,4);
names_grids2 = cell(ld*lr*lk,1);
count = 1;
disp('top left, top right,, bottom left, bottom right')
for i=1:ld
    for j=1:lr
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             load(['unif-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            load(['unif-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])

%             hubs = logical(hubs);
            hubs1 = logical(hubs(1:1000));
            hubs2 = logical(hubs(1001:end));
            nothubs1 = ~hubs1;
            nothubs2 = ~hubs2;
%             thr = mean(q)+2*std(q);
            thr1 = mean(q(1:1000))+2*std(q(1:1000));
            thr2 = mean(q(1001:end))+2*std(q(1001:end));
%             dense = q>= thr;
%             notdense = q< thr;
            dense1 = q(1:1000)>= thr1;
            notdense1 = q(1:1000)< thr1;
            dense2 = q(1001:end)>= thr2;
            notdense2 = q(1001:end)< thr2;
            tl1 = sum(hubs1.*notdense1);
            tr1 = sum(hubs1.*dense1);
            bl1 = sum(nothubs1.*notdense1);
            br1 = sum(nothubs1.*dense1);
            tl2 = sum(hubs2.*notdense2);
            tr2 = sum(hubs2.*dense2);
            bl2 = sum(nothubs2.*notdense2);
            br2 = sum(nothubs2.*dense2);
%             disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k))])
%             grid_vals = 100*[tl tr bl br]./size(q,1);
%             grid_vals = 100*[tl tr bl br]./size(q(1:1000),1)
%             grid_vals(count,:) = 100*[tl tr bl br]./size(q(1001:end),1);
            grid_valsu1(count,:) = 100*[tl1, tr1 bl1 br1]./1000;
            grid_valsu2(count,:) = 100*[tl2, tr2 bl2 br2]./(length(q)-1000);
%             100*[tl tr]./(tl+tr);
            count = count+1;
        end
    end
end

ave_top_ratio = mean([grid_valsg1(:,2);grid_valsg2(:,2);grid_valsu1(:,2);grid_valsu2(:,2)]./sum([grid_valsg1(:,1:2);grid_valsg2(:,1:2);grid_valsu1(:,1:2);grid_valsu2(:,1:2)],2))
ave_right_ratio = mean([grid_valsg1(:,2);grid_valsg2(:,2);grid_valsu1(:,2);grid_valsu2(:,2)]./sum([grid_valsg1(:,[2,4]);grid_valsg2(:,[2,4]);grid_valsu1(:,[2,4]);grid_valsu2(:,[2,4])],2))