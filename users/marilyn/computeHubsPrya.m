function [thresh_indices] = computeHubsPrya(samples)
% Find Hubness score of data points
neigh = 10; % neighborhood size
numPts = size(samples,1);
hubness = zeros(numPts,1);


for i = 1:size(samples,1)
    if size(samples,2) > 0
        temp = repmat(samples(i,:),numPts,1);
        temp = temp - samples;
        distance = sqrt(diag(temp* (transpose(temp))));
        [sorted,index] = sort(transpose(distance)); % sort each row
        for j = 1:min(neigh+1,size(samples,1))
            if i ~= index(j)
                hubness(index(j)) = hubness(index(j)) + 1;
            end
        end
    end
end

[val,indices] = sort(hubness,'descend'); % val = hubness score

% Find hubs within mean+2.sigma
mean_hubness = mean(hubness);
sigma_hubness = std(hubness);
thresh = mean_hubness + 2*sigma_hubness;
thresh_indices = indices(find(val>=thresh));
