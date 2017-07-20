% How I calculated hubness
dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = [5 10 50];
kcolor = ['m' 'b' 'c'];
dmarker = ['*' 'o' 'x' 'd'];

% Gaussians
ld = length(dim);
lr = length(dr);
lk = length(knn);


% count = 1;
for i=1:ld
%     figure(count);
%     hold on
    for j=1:lr
        for k=1:lk
            load(['gaussians_1000_' num2str(dr(j)) '000_' num2str(dim(i)) '.mat'])
            load(['gauss-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            [N_k,hubs] = KhubScores(allsamples,knn(k));
            chub_to_thub = [sum(hubs(1:1000)); sum(hubs(1001:end))]./sum(hubs);
            xdens_yhubs = [dens_ave' chub_to_thub];
%             scatter(dens_ave',chub_to_thub,30,dmarker(j),kcolor(k))
            save(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'],'N_k','hubs','xdens_yhubs')
        end
    end
%     title(['gauss, dim=' num2str(dim(i))])
%     hold off
%     count = count+1;
end

% Uniform

% count = 1;
for i=1:ld
    for j=1:lr
%         figure(count);
%         hold on
        for k=1:lk
            load(['unif-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            load(['unif-density-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
            [N_k,hubs] = KhubScores(X,knn(k));
            chub_to_thub = [sum(hubs(1:1000)); sum(hubs(1001:end))]./sum(hubs);
            xdens_yhubs = [dens_ave' chub_to_thub];
%             scatter(dens_ave',chub_to_thub,30,dmarker(j),kcolor(k))
            save(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'],'N_k','hubs','xdens_yhubs')
        end
%         title(['unif,dim=' num2str(dim(i))])
%         hold off
%         count = count+1;
    end
end
