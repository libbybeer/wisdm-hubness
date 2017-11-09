% Trying to display the four quadrants (globally) of low/high density
% against low/high hubness
% Author: Marilyn Y. Vazquez

dim = [30 60 100];
dr = 2:5;
bpts = 1000;
ka = 16;
kL = 100;
knn = [5 10 50];
dcolor = ['k' 'b' 'c' 'r'];
kmarker = ['x' '*' 'o'];

ld = length(dim);
lr = length(dr);
lk = length(knn);


% % Gaussian
% count = 1;
% disp('top left, top right, bottom left, bottom right')
% for i=1:ld
%     for j=1:lr
%         for k=1:lk
%             load(['gauss-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
%             load(['gauss-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
% %             figure(count);
% %             hold on
%             hubs = logical(hubs);
%             nothubs = ~hubs;
% %             thr = mean(N_k)+2*std(N_k);
% %             scatter(q(1:1000),N_k(1:1000),30,'b')
% %             scatter(q(1001:end),N_k(1001:end),30,'r')
% %             plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-k')
%             thr = mean(q)+2*std(q);
%             dense = q>= thr;
%             notdense = q< thr;
% %             scatter(q(dense),N_k(dense),30,'b')
% %             scatter(q(notdense),N_k(notdense),30,'r')
% %             plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-k')
%             tl = sum(hubs.*notdense);
%             tr = sum(hubs.*dense);
%             bl = sum(nothubs.*notdense);
%             br = sum(nothubs.*dense);
%             disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k))])
%             grid_vals = 100*[tl tr bl br]./size(q,1)
% %             100*[tl tr]./(tl+tr)
% %             pos = [(max(q)-min(q))/4 3*(max(N_k)-min(N_k))/4;3*(max(q)-min(q))/4 3*(max(N_k)-min(N_k))/4;(max(q)-min(q))/4 (max(N_k)-min(N_k))/4;3*(max(q)-min(q))/4 (max(N_k)-min(N_k))/4];
% %             pos = [.105,210;.1305,210;.105,25;.1305,25];
% %             for it=1:4
% %                 text(pos(it,1),pos(it,2),[num2str(grid_vals(it)) '%'],'fontsize',20)
% %             end
% %             title(['gauss, dim=' num2str(dim(i)) ', dens=1to' num2str(dr(j)) ', k=' num2str(knn(k))])% ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
% %             xlabel('Sample Density')
% %             ylabel('Hubness Score')
% %             hold off
% %             count = count+1;
%         end
%     end
% end

% Uniform

disp('top left, top right, bottom left, bottom right')
for i=1:ld
    for j=1:lr
        for k=1:lk
            load(['unif-hubness' num2str(dim(i)) '-1000-' num2str(dr(j)) '000-k' num2str(knn(k)) '.mat'])
            load(['unif-KDE-dim' num2str(dim(i)) '-1000-' num2str(dr(j)) '000.mat'])
%             figure(count);
%             hold on
            hubs = logical(hubs);
            nothubs = ~hubs;
%             thr = mean(N_k)+2*std(N_k);
%             scatter(q(1:1000),N_k(1:1000),30,'b')
%             scatter(q(1001:end),N_k(1001:end),30,'r')
%             plot(min(q):(max(q)-min(q))/9:max(q),thr*ones(1,10),'-k')
            thr = mean(q)+2*std(q);
            dense = q>= thr;
            notdense = q< thr;
%             scatter(q(dense),N_k(dense),30,'b')
%             scatter(q(notdense),N_k(notdense),30,'r')
%             plot(thr*ones(1,10),min(N_k):(max(N_k)-min(N_k))/9:max(N_k),'-k')
            tl = sum(hubs.*notdense);
            tr = sum(hubs.*dense);
            bl = sum(nothubs.*notdense);
            br = sum(nothubs.*dense);
            disp(['dim= ' num2str(dim(i)) ', 1 to ' num2str(dr(j)) ',k = ' num2str(knn(k))])
            grid_vals = 100*[tl tr bl br]./size(q,1)
%             100*[tl tr]./(tl+tr)
%             pos = [(max(q)-min(q))/4 3*(max(N_k)-min(N_k))/4;3*(max(q)-min(q))/4 3*(max(N_k)-min(N_k))/4;(max(q)-min(q))/4 (max(N_k)-min(N_k))/4;3*(max(q)-min(q))/4 (max(N_k)-min(N_k))/4];
%             pos = [.105,210;.1305,210;.105,25;.1305,25];
%             for it=1:4
%                 text(pos(it,1),pos(it,2),[num2str(grid_vals(it)) '%'],'fontsize',20)
%             end
%             title(['gauss, dim=' num2str(dim(i)) ', dens=1to' num2str(dr(j)) ', k=' num2str(knn(k))])% ', black to red = increasing density'])% ', magenta=k5,blue=k10,cyan=k50'])
%             xlabel('Sample Density')
%             ylabel('Hubness Score')
%             hold off
%             count = count+1;
        end
    end
end
