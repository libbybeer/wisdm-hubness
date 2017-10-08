%%% Display Hubs per cluster
%%% Author: Marilyn Y. Vazquez

dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = [5 10 50];
lk = length(knn);

% Gaussians
ld = length(dim);
lr = length(dr);
% lk = length(knn);

count = 1;
for i=1:ld
    for j=1:lr
%         for k=1:lk
%             load(['gaussians_1000_' num2str(dr(j)) '000_' num2str(dim(i)) '.mat'])
%             load(['unif-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k)) ',hubs per cluster = ' num2str([sum(hubs(1:1000)) sum(hubs(1001:end))])])
%             disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', average density per cluster = ' num2str(dens_ave)])
%             [N_k,hubs] = KhubScores(allsamples,knn(k));
%             chub_to_thub = [sum(hubs(1:1000)); sum(hubs(1001:end))]./sum(hubs);
%             xdens_yhubs = [dens_ave' chub_to_thub];
%             scatter(dens_ave',chub_to_thub,30,dmarker(j),kcolor(k))
% % % %             save(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'],'N_k','hubs','xdens_yhubs')
%         end
    end
    count = count+1;
end

% Uniform

for i=1:ld
%     figure(count);
%     hold on
    for j=1:lr
        for k=1:1
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             scatter(xdens_yhubs(:,1),xdens_yhubs(:,2),30,kmarker(k),dcolor(j))
            disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k)) ',hubs per cluster = ' num2str([sum(hubs(1:1000)) sum(hubs(1001:end))])])
        end
    end
%     legend('k=5','k=10','k=50','Location','northwest');
%     title(['unif, dim=' num2str(dim(i)) ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
%     xlabel('Average Density per cluster')
%     ylabel('Fraction of hubs per cluster')
%     hold off
%     count = count+1;
end
