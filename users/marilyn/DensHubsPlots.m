% Trying to make some nice plots of average density against fraction of
% hubs per cluster
% Author: Marilyn Y. Vazquez

dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = [5 10 50];
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
    figure(count);
    hold on
    for j=1:lr
        for k=1:lk
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            scatter(xdens_yhubs(:,1),xdens_yhubs(:,2),30,kmarker(k),dcolor(j))
        end
    end
    legend('k=5','k=10','k=50','Location','northwest');
    title(['gauss, dim=' num2str(dim(i)) ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
    xlabel('Average Density per cluster')
    ylabel('Fraction of hubs per cluster')
    hold off
    count = count+1;
end

% Uniform

for i=1:ld
    figure(count);
    hold on
    for j=1:lr
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            scatter(xdens_yhubs(:,1),xdens_yhubs(:,2),30,kmarker(k),dcolor(j))
        end
    end
    legend('k=5','k=10','k=50','Location','northwest');
    title(['unif, dim=' num2str(dim(i)) ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
    xlabel('Average Density per cluster')
    ylabel('Fraction of hubs per cluster')
    hold off
    count = count+1;
end

% %%% See change in dimension
% 
% % Gaussian
% count = 1;
% for j=1:lr
%     figure(count);
%     hold on
%     for k=1:lk
%         for i=1:ld
%             load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             scatter(xdens_yhubs(:,1),xdens_yhubs(:,2),30,kmarker(j),dcolor(k))
%         end
%     end
%     legend('1to2','1to3','1to4','1to5');
%     title(['gauss, dim=' num2str(dim(i)) ', magenta=k5,blue=k10,cyan=k50'])
%     xlabel('Average Density per cluster')
%     ylabel('Fraction of hubs per cluster')
%     hold off
%     count = count+1;
% end
% 
% % Uniform
% 
% 
% for k=1:lk
%     figure(count);
%     hold on
%     for i=1:ld
%         for j=1:lr
%             load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             scatter(xdens_yhubs(:,1),xdens_yhubs(:,2),30,kmarker(j),dcolor(k))
%         end
%     end
%     legend('1to2','1to3','1to4','1to5');
%     title(['unif, dim=' num2str(dim(i)) ', magenta=k5,blue=k10,cyan=k50'])
%     xlabel('Average Density per cluster')
%     ylabel('Fraction of hubs per cluster')
%     hold off
%     count = count+1;
% end
