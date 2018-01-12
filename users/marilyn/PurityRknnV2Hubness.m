% Purity measures for rKNN's of points with hubness scores greater than thr
% Author: Marilyn Y. Vazquez

%%%%%%% Things that I am interested in knowing: (1) when does it drop to

dim = [30,60,100];
knn = [5 10 50];
dr = 2:5;

% % Gaussian
% for i=dim
%     for j=dr
%         load(['gaussians_1000_' num2str(j) '000_' num2str(i) '.mat'])
%         data = allsamples;
%         lbl = double(class_indices)';
%         N = length(lbl);
%         lr = double(max(lbl)-min(lbl)+1);
%         clear class0 class1 allsamples
%         
%         for k=knn
%             load(['gauss-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k) '.mat'])
%             clear hubs xdens_yhubs
%             
%             mnnk = min(N_k);
%             mxnk = max(N_k);
%             a = std(N_k);
%             if (i==100) && (j==4) && (k==50)
%                 s=sqrt(65);
%             else
%                 s = 2;
%             end
%             
%             stp = ceil(a/s);
%             trng = (mnnk+stp):stp:(mxnk-stp);
%             %             lnk = ceil((mxnk - mnnk - 2*stp +1)/stp);
%             lnk = length(trng);
%             
%             %     tally = zeros(N,lr);
%             purity = zeros(lnk,1);
%             count = 1;
%             for thr = trng
%                 inds1 = zeros(size(N_k));
%                 inds2 = inds1;
%                 inds1(1:1000) = N_k(1:1000) > thr;
%                 inds2(1001:end) = N_k(1001:end) > thr;
%                 [~,rkNN1] = reverseKNNv2(inds1,data,k);
%                 [~,rkNN2] = reverseKNNv2(inds2,data,k);
%                 trueClass = zeros(size(rkNN1));
%                 trueClass(rkNN1) = lbl(rkNN1)+1;
%                 trueClass(rkNN2) = lbl(rkNN2)+1;
%                 %                 clus1 = lbl(logical(inds1));
%                 %                 if min(clus1) ~= max(clus1)
%                 %                     error('The hubs are not all in the same cluster')
%                 %                 end
%                 %                 clus2 = lbl(logical(inds2));
%                 %                 if min(clus2) ~= max(clus2)
%                 %                     error('The hubs are not all in the same cluster')
%                 %                 end
%                 predictedCluster = double(rkNN1)+2*double(rkNN2);
%                 temp = predictedCluster==3;
%                 predictedCluster(temp) = round(rand(sum(temp),1))+1;
%                 
%                 if isequal(find(trueClass==0),find(predictedCluster==0))==0
%                     disp('Error: Something going on')
%                 end
%                 purity(count) = clusterPurity(trueClass(:),predictedCluster(:));
%                 count = count +1;
%             end
%             if sum(purity==1)~=lnk
%                 figure, plot(trng,purity,'LineWidth',2)
%                 hold on
%                 prn = min(purity)-0.000001:(max(purity)-min(purity)+0.000002)/2:max(purity)+0.000001;
%                 plot((mean(N_k)+2*a)*ones(length(prn),1),prn','k','LineWidth',2);set(gca,'fontsize',20)
%                 hold off
%                 xlabel('Threshold of N_k')
%                 ylabel('Purity')
%                 title(['gauss-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k)])
%                 for i1 = 1:length(trng)
%                     ulbl = unique(lbl(N_k>trng(i1)));
%                     if length(ulbl)==1
%                         disp(['gauss-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k)])
%                         disp(['\Sigma above mean and value of first all in one cluster: ' num2str((trng(i1)-mean(N_k))/a) ', ' num2str(trng(i1))])
%                         break;
%                     end
%                 end
%                 
%                 clear ulbl
%                 
%                 for i2 = i1:length(trng)
%                     ulbl = lbl(N_k>trng(i2));
%                     if sum(ulbl)==1
%                         disp(['\Sigma above mean and value of first one point: ' num2str((trng(i2)-mean(N_k))/a) ', ' num2str(trng(i2))])
%                         break;
%                     end
%                 end
%                 
%                 [mp,ip]=max(purity(1:i1));
%                 disp(['Peak value and \Sigma above mean and threshold: ' num2str(mp) ', ' num2str((trng(ip)-mean(N_k))/a) ', ' num2str(trng(ip))])
%             end
%         end
%     end
% end

% % Uniform load([60-1000-' num2str(j) '000.mat'])
% for i=dim
%     for j=dr
%         load(['unif-dim' num2str(i) '-1000-' num2str(j) '000.mat'])
%         data = X;
%         clear X
%         lbl = [zeros(1000,1);ones(j*1000,1)];
%         N = length(lbl);
%         lr = double(max(lbl)-min(lbl)+1);
% 
%         for k=knn
%             load(['unif-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k) '.mat'])
%             clear hubs xdens_yhubs
% 
%             mnnk = min(N_k);
%             mxnk = max(N_k);
%             a = std(N_k);
%             s=2;
% 
%             stp = ceil(a/s);
%             trng = (mnnk+stp):stp:(mxnk-stp);
% %             lnk = ceil((mxnk - mnnk - 2*stp +1)/stp);
%             lnk = length(trng);
% 
%             %     tally = zeros(N,lr);
%             purity = zeros(lnk,1);
%             count = 1;
%             for thr = trng
%                 inds1 = zeros(size(N_k));
%                 inds2 = inds1;
%                 inds1(1:1000) = N_k(1:1000) > thr;
%                 inds2(1001:end) = N_k(1001:end) > thr;
%                 [~,rkNN1] = reverseKNNv2(inds1,data,k);
%                 [~,rkNN2] = reverseKNNv2(inds2,data,k);
%                 trueClass = zeros(size(rkNN1));
%                 trueClass(rkNN1) = lbl(rkNN1)+1;
%                 trueClass(rkNN2) = lbl(rkNN2)+1;
%                 %                 clus1 = lbl(logical(inds1));
%                 %                 if min(clus1) ~= max(clus1)
%                 %                     error('The hubs are not all in the same cluster')
%                 %                 end
%                 %                 clus2 = lbl(logical(inds2));
%                 %                 if min(clus2) ~= max(clus2)
%                 %                     error('The hubs are not all in the same cluster')
%                 %                 end
%                 predictedCluster = double(rkNN1)+2*double(rkNN2);
%                 temp = predictedCluster==3;
%                 predictedCluster(temp) = round(rand(sum(temp),1))+1;
%                 
%                 if isequal(find(trueClass==0),find(predictedCluster==0))==0
%                     disp('Error: Something going on')
%                 end
%                 purity(count) = clusterPurity(trueClass(:),predictedCluster(:));
%                 count = count +1;
%             end
%             if sum(purity==1)~=lnk
%                 figure, plot(trng,purity,'LineWidth',2)
%                 hold on
%                 prn = min(purity)-0.000001:(max(purity)-min(purity)+0.000002)/2:max(purity)+0.000001;
%                 plot((mean(N_k)+2*a)*ones(length(prn),1),prn','k','LineWidth',2);set(gca,'fontsize',20)
%                 hold off
%                 xlabel('Threshold of N_k')
%                 ylabel('Purity')
%                 title(['unif-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k)])
%                 for i1 = 1:length(trng)
%                     ulbl = unique(lbl(N_k>trng(i1)));
%                     if length(ulbl)==1
%                         disp(['unif-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k)])
%                         disp(['\Sigma above mean and value of first all in one cluster: ' num2str((trng(i1)-mean(N_k))/a) ', ' num2str(trng(i1))])
%                         break;
%                     end
%                 end
%                 
%                 clear ulbl
%                 
%                 for i2 = i1:length(trng)
%                     ulbl = lbl(N_k>trng(i2));
%                     if sum(ulbl)==1
%                         disp(['\Sigma above mean and value of first one point: ' num2str((trng(i2)-mean(N_k))/a) ', ' num2str(trng(i2))])
%                         break;
%                     end
%                 end
%                 
%                 [mp,ip]=max(purity(1:i1));
%                 disp(['Peak value and \Sigma above mean and threshold: ' num2str(mp) ', ' num2str((trng(ip)-mean(N_k))/a) ', ' num2str(trng(ip))])
%             end
%         end
%     end
% end

%SQmoons

data = load('SQmoons-dim60-6000.txt');
lbl = load('SQmoonsLbls-dim60-6000.txt');
N = length(lbl);
lr = double(max(lbl)-min(lbl)+1);
clear class0 class1 allsamples

for k=knn
    load(['SQmoons-hubness-dim60-6000-k' num2str(k) '.mat'])
    clear hubs xdens_yhubs
    
    mnnk = min(N_k);
    mxnk = max(N_k);
    a = std(N_k);
    s=2;
    stp = ceil(a/s);
    trng = (mnnk+stp):stp:(mxnk-stp);
    lnk = length(trng);
    
    %     tally = zeros(N,lr);
    purity = zeros(lnk,1);
    count = 1;
    for thr = trng
        inds1 = zeros(size(N_k));
        inds2 = inds1;
        inds1(1:1000) = N_k(1:1000) > thr;
        inds2(1001:end) = N_k(1001:end) > thr;
        [~,rkNN1] = reverseKNNv2(inds1,data,k);
        [~,rkNN2] = reverseKNNv2(inds2,data,k);
        trueClass = zeros(size(rkNN1));
        trueClass(rkNN1) = lbl(rkNN1)+1;
        trueClass(rkNN2) = lbl(rkNN2)+1;
        %                 clus1 = lbl(logical(inds1));
        %                 if min(clus1) ~= max(clus1)
        %                     error('The hubs are not all in the same cluster')
        %                 end
        %                 clus2 = lbl(logical(inds2));
        %                 if min(clus2) ~= max(clus2)
        %                     error('The hubs are not all in the same cluster')
        %                 end
        predictedCluster = double(rkNN1)+2*double(rkNN2);
        temp = predictedCluster==3;
        predictedCluster(temp) = round(rand(sum(temp),1))+1;
        purity(count) = clusterPurity(trueClass(:),predictedCluster(:));
        count = count+1;
    end
    figure, plot(trng,purity,'LineWidth',2)
    hold on
    prn = min(purity)-0.01:(max(purity)-min(purity)+0.02)/9:max(purity)+0.01;
    plot((mean(N_k)+2*a)*ones(length(prn),1),prn','k','LineWidth',2);set(gca,'fontsize',20)
    hold off
    xlabel('Threshold of N_k')
    ylabel('Purity')
    title(['SQmoons-hubness60-1000-5000-k' num2str(k)])
    %     if k==10
    %         tind = find(purity==max(purity),2,'first');
    %         (trng(tind(end))-mean(N_k))/a
    %     else
    %         tind = find(purity==max(purity),1,'first');
    %         (trng(tind(1))-mean(N_k))/a
    %     end
    for i1 = 1:length(trng)
        ulbl = unique(lbl(N_k>trng(i1)));
        if length(ulbl)==1
            disp(['SQmoons-hubness' num2str(i) '-1000-' num2str(j) '000-k' num2str(k)])
            disp(['\Sigma above mean and value of first all in one cluster: ' num2str((trng(i1)-mean(N_k))/a) ', ' num2str(trng(i1))])
            break;
        end
    end
    
    clear ulbl
    
    for i2 = i1:length(trng)
        ulbl = lbl(N_k>trng(i2));
        if sum(ulbl)==1
            disp(['\Sigma above mean and value of first one point: ' num2str((trng(i2)-mean(N_k))/a) ', ' num2str(trng(i2))])
            break;
        end
    end
    
    [mp,ip]=max(purity(1:i1));
    disp(['Peak value and \Sigma above mean and threshold: ' num2str(mp) ', ' num2str((trng(ip)-mean(N_k))/a) ', ' num2str(trng(ip))])
    
end
