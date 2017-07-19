% How I calculated density
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
        [~,q,~,d] = KDE(allsamples,allsamples,ka,kL);
        dens_ave = [0 0];
        dens_ave(1)=mean(q(1:1000));
        dens_ave(2)=mean(q(1001:end));
        save(['gauss-density-dim' num2str(dim(i)) '-1k-' num2str(dr(j)) 'k.mat'],'dens_ave','q')
    end
end

% Uniform

for i=1:ld
    for j=1:lr
        load(['uniform-dim' num2str(dim(i)) '-1k-' num2str(dr(j)) 'k.mat'])
        [~,q,~,d] = KDE(X,X,16,500);
        dens_ave = [0 0];
        dens_ave(1)=mean(q(1:1000));
        dens_ave(2)=mean(q(1001:end));
        save(['unif-density-dim' num2str(dim(i)) '-1k-' num2str(dr(j)) 'k.mat'],'dens_ave','q')
%         dens_cave(2)/dens_cave(1)
%         [dim(i),dr(j)]
    end
end

% % If you want to see the data
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
