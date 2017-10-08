% Generating the Moon-like Sets ('SQmoons' files)
% Author: Marilyn Y. Vazquez

N = 8900;
n = 6000;
d = 60;
a = 1;
b = 5/64;

top_square = 2*a*rand(N,d)-a;
bottom_square = [2*a*rand(N,1) 2*a*rand(N,d-1)-a*(1-b)];

top = top_square(top_square(:,2)>(-1/(2*a))*top_square(:,1).^2+(a/2),:);
bottom = bottom_square(bottom_square(:,2)<(1/(2*a))*(bottom_square(:,1)-a).^2-(a*b),:);

data = [top;bottom];
lbls = [zeros(size(top,1),1);ones(size(bottom,1),1)];

if size(top,1)+size(bottom,1)>=n
    p = randperm(size(top,1)+size(bottom,1));
    p = p(1:n);
    data = data(p,:);
    lbls = lbls(p,:);
    figure, scatter3(data(:,1),data(:,2),data(:,3),10,lbls)
    save SQmoons-dim60-6000.txt data -ascii
    save SQmoonsLbls-dim60-6000.txt lbls -ascii
end