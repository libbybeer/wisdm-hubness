% SQmoons: measures
% Author: Marilyn Y. Vazquez

% SQmoons: Density

allsamples = load('SQmoons-dim60-6000.txt');
lbls = load('SQmoonsLbls-dim60-6000.txt');
c1 = lbls==0;
c2 = lbls==1;
[dis,~] = pdist2(allsamples,allsamples,'euclidean','Smallest',16);
q = 1./dis(end,:)';
% [~,q,~,d] = KDE(allsamples,allsamples,ka,kL);
dens_ave = [mean(q(c1)) mean(q(c2))];
save('SQmoons-density-dim60-6000.mat','dens_ave','q')

% SQmoons: hubness
knn = [5 10 50];
lk = length(knn);

for k=1:lk
    [N_k,hubs] = KhubScores(allsamples,knn(k));
    chub_to_thub = [sum(hubs(c1)); sum(hubs(c2))]./sum(hubs);
    xdens_yhubs = [dens_ave' chub_to_thub];
    %             scatter(dens_ave',chub_to_thub,30,dmarker(j),kcolor(k))
    save(['SQmoons-hubness-dim60-6000-k' num2str(knn(k)) '.mat'],'N_k','hubs','xdens_yhubs')
end