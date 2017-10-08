% Trying to make some nice plots of local density against local hubness
% Author: Marilyn Y. Vazquez

dim = 60;%[30 60 100];
dr = [2 4];%2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = 10;%[5 10 50];
dcolor = ['k' 'b' 'c' 'r'];
kmarker = ['x' '*' 'o'];

% Gaussians
ld = length(dim);
lr = length(dr);
lk = length(knn);

% % Legends
% lgnd = cell(12);
% count = 1;
% for j=1:lr
% %     for k=1:lk
%         lgnd{count} = ['1000 vs ' num2str(dr(j)) '000'];% '-k' num2str(knn(k))];
%         count = count+1;
% %     end
% end


%%% See change in densities

% Gaussian
count = 1;
for i=1:ld
    for j=1:lr
        for k=1:lk
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            load(['gauss-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            figure(count);
            hold on
%             thr = mean(N_k)+2*std(N_k);
            thr = mean(N_k(1:1000))+2*std(N_k(1:1000));
%             scatter(q,N_k,30,dcolor(j))
            scatter(q(1:1000),N_k(1:1000),30,'c')
            scatter(q(1001:end),N_k(1001:end),30,'m')
            plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-b','LineWidth',2)
            thr = mean(N_k(1001:end))+2*std(N_k(1001:end));
            plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-r','LineWidth',2)
            thr = mean(q(1:1000))+2*std(q(1:1000));
%             thr = mean(q)+2*std(q);
            plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-b','LineWidth',2)
            thr = mean(q(1001:end))+2*std(q(1001:end));
            plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-r','LineWidth',2)
            title(['gauss, dim=' num2str(dim(i)) ', dens=1to' num2str(dr(j)) ', k=' num2str(knn(k))])% ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
            xlabel('Sample Density')
            ylabel('Hubness Score')
            set(gca,'fontsize',20)
            hold off
            count = count+1;
        end
    end
end

% Uniform

for i=1:ld
    for j=1:lr
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            load(['unif-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            figure(count);
            hold on
%             thr = mean(N_k)+2*std(N_k);
            thr = mean(N_k(1:1000))+2*std(N_k(1:1000));
%             scatter(q,N_k,30,dcolor(j))
            scatter(q(1:1000),N_k(1:1000),30,'c')
            scatter(q(1001:end),N_k(1001:end),30,'m')
            plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-b','LineWidth',2)
            thr = mean(N_k(1001:end))+2*std(N_k(1001:end));
            plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-r','LineWidth',2)
            thr = mean(q(1:1000))+2*std(q(1:1000));
%             thr = mean(q)+2*std(q);
            plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-b','LineWidth',2)
            thr = mean(q(1001:end))+2*std(q(1001:end));
            plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-r','LineWidth',2)
            title(['unif, dim=' num2str(dim(i)) ', dens=1to' num2str(dr(j)) ', k=' num2str(knn(k))])% ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
            xlabel('Sample Density')
            ylabel('Hubness Score')
            set(gca,'fontsize',20)
            hold off
            count = count+1;
        end
    end
end
