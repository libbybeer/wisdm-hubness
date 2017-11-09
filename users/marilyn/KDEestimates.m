% How I calculated density
% Author: Marilyn Y. Vazquez

dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;

% Gaussians
ld = length(dim);
lr = length(dr);

for i=1:ld
    for j=1:lr
        load(['gaussians_1000_' num2str(dr(j)) '000_' num2str(dim(i)) '.mat'])
%         [dis,~] = pdist2(allsamples,allsamples,'euclidean','Smallest',16);
        [~,q,~,d] = KDE(allsamples,allsamples,ka,kL);
        dens_ave = [0 0];
        dens_ave(1)=mean(q(1:1000));
        dens_ave(2)=mean(q(1001:end));
%         disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', average density per cluster = ' num2str(dens_ave)])
        save(['gauss-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'],'dens_ave','q')
    end
end

% Uniform

for i=1:ld
    for j=1:lr
        load(['unif-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
%         [dis,~] = pdist2(X,X,'euclidean','Smallest',16);
        [~,q,~,d] = KDE(X,X,ka,kL);
        dens_ave = [0 0];
        dens_ave(1)=mean(q(1:1000));
        dens_ave(2)=mean(q(1001:end));
%         disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', average density per cluster = ' num2str(dens_ave)])
        save(['unif-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'],'dens_ave','q')
    end
end

% % If you want to see the data, you can use something like this
% count = 1;
% for i=1:ld
%     for j=1:lr
%         load(['uniform-dim' num2str(dim(i)) '-1k-' num2str(dr(j)) 'k.mat'])
%         figure(count);
%         scatter3(X(:,1),X(:,2),X(:,3));
%         title(['dim=' num2str(dim(i)) ',1k-' num2str(dr(j)) 'k'])
%         count = count+1;
%     end
% end
