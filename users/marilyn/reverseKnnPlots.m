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
            hubs1 = logical(hubs(1:1000));
            hpoints1 = allsamples(hubs1,:);
            [~,inds1] = reverseKNN(hpoints1,allsamples,knn(k));
            % Plot
            figure(count);
            hold on
            scatter(allsamples(:,1),allsamples(:,2),10,'y')
            scatter(allsamples(inds1,1),allsamples(inds1,2),10,'r')
            % Cluster 2: Reverse kNN
            hubs2 = logical([zeros(1000,1);hubs(1001:end)]);
            hpoints2 = allsamples(hubs2,:);
            [~,inds2] = reverseKNN(hpoints2,allsamples,knn(k));
            % Plot
            scatter(hpoints2(:,1),hpoints2(:,2),10,'k')
            title(['gauss, dim=' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', k=' num2str(knn(k)) ])
            count = count +1;
            hold off
        end
    end
end

% Uniform

disp('top left, top right,, bottom left, bottom right')
for i=1:ld
    for j=1:lr
        load(['unif-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            % Cluster 1: Reverse kNN
            hubs1 = logical(hubs(1:1000));
            hpoints1 = allsamples(hubs1,:);
            [~,inds1] = reverseKNN(hpoints1,allsamples,knn(k));
            % Plot
            figure(count);
            hold on
            scatter(allsamples(:,1),allsamples(:,2),10,'y')
            scatter(allsamples(inds1,1),allsamples(inds1,2),10,'r')
            % Cluster 2: Reverse kNN
            hubs2 = logical([zeros(1000,1);hubs(1001:end)]);
            hpoints2 = allsamples(hubs2,:);
            [~,inds2] = reverseKNN(hpoints2,allsamples,knn(k));
            % Plot
            scatter(hpoints2(:,1),hpoints2(:,2),10,'k')
            title(['unif, dim=' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ', k=' num2str(knn(k)) ])
            count = count +1;
            hold off
        end
    end
end
