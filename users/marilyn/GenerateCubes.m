% How I generated the uniform cubes
dim = [30 60 100];
dr = 2:5;
bpts = 1000;
k = [4 10 50];

% tot = length(dim)*length(dr)*length(k);
ld = length(dim);
lr = length(dr);
lk = length(k);

for i=1:ld
    for j=1:lr
        X = [rand(bpts,1)-2,rand(bpts,dim(i)-1);rand(dr(j)*bpts,1)+1,rand(dr(j)*bpts,dim(i)-1)];
        save(['uniform-dim' num2str(dim(i)) '-1k-' num2str(dr(j)) 'k.mat'],'X')
    end
end