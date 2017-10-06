% Trying to make some nice plots
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


%%% See change in densities

% Gaussian
count = 1;
for i=1:ld
    for j=1:lr
        figure(count);
        hold on;
        for k=1:lk
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            load(['gauss-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            thr = mean(N_k)+2*std(N_k);
            scatter(knn(k),sum(N_k > thr),90,'filled')
%             disp(['Gauss, Dim = ' num2str(dim(i)) ', dens. ratio = 1:' num2str(dr(j)) ', k = ' num2str(knn(k)) ', passed thr = ' num2str(sum(N_k > thr))])
        end
        xlabel('k')
        ylabel('# of hubs')
        title(['Gauss, Dim = ' num2str(dim(i)) ', dens. ratio = 1:' num2str(dr(j))])
        hold off
        set(gca,'fontsize',20)
        count = count+1;
    end
end

% Uniform

for i=1:ld
    for j=1:lr
        figure(count);
        hold on;
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            load(['unif-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            thr = mean(N_k)+2*std(N_k);
            scatter(knn(k),sum(N_k > thr),90,'filled')
%             disp(['Unif, Dim = ' num2str(dim(i)) ', dens. ratio = 1:' num2str(dr(j)) ', k = ' num2str(knn(k)) ', passed thr = ' num2str(sum(N_k > thr))])
        end
        xlabel('k')
        ylabel('# of hubs')
        title(['Unif, Dim = ' num2str(dim(i)) ', dens. ratio = 1:' num2str(dr(j))])
        hold off
        set(gca,'fontsize',20)
        count = count+1;
    end
end
