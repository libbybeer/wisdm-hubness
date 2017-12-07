% Trying to make some nice plots of the rKNN
% Author: Marilyn Y. Vazquez

dim = 60;%[30 60 100];
dr = [2 4];%2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = 10;%[5 10 50];
dcolor = ['k' 'b' 'c' 'r'];
kmarker = ['x' '*' 'o'];

ld = length(dim);
lr = length(dr);
lk = length(knn);

% Gaussian
count = 1;
for i=1:ld
    for j=1:lr
        load(['gaussians_1000_' num2str(dr(j)) '000_' num2str(dim(i)) '.mat'])
        for k=1:lk
            load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            % Cluster 1: Reverse kNN
            hubs1 = logical([hubs(1:1000); zeros(size(hubs(1001:end)))]);
            [~,inds1] = reverseKNNv2(hubs1,allsamples,knn(k));
            % Plot
            figure(count);
            hold on
            scatter(allsamples(logical(hubs),1),allsamples(logical(hubs),2),10,'y')
            scatter(allsamples(inds1,1),allsamples(inds1,2),10,'r')
            % Cluster 2: Reverse kNN
            hubs2 = logical([zeros(1000,1);hubs(1001:end)]);
            [~,inds2] = reverseKNNv2(hubs2,allsamples,knn(k));
            % Plot
            scatter(allsamples(inds2,1),allsamples(inds2,2),10,'k')
            title(['gauss, dim=' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', k=' num2str(knn(k)) ])
            count = count +1;
            hold off
        end
    end
end

clear hubs hubs1 hubs2 inds1 inds2 allsamples
% Uniform

disp('top left, top right,, bottom left, bottom right')
for i=1:ld
    for j=1:lr
        load(['unif-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            allsamples = X;
            clear X
            % Cluster 1: Reverse kNN
            hubs1 = logical([hubs(1:1000); zeros(size(hubs(1001:end)))]);
            [~,inds1] = reverseKNNv2(hubs1,allsamples,knn(k));
            % Plot
            figure(count);
            hold on
            scatter(allsamples(logical(hubs),1),allsamples(logical(hubs),2),10,'y')
            scatter(allsamples(inds1,1),allsamples(inds1,2),10,'r')
            % Cluster 2: Reverse kNN
            hubs2 = logical([zeros(1000,1);hubs(1001:end)]);
            [~,inds2] = reverseKNNv2(hubs2,allsamples,knn(k));
            % Plot
            scatter(allsamples(inds2,1),allsamples(inds2,2),10,'k')
            title(['unif, dim=' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', k=' num2str(knn(k)) ])
            count = count +1;
            hold off
        end
    end
end
