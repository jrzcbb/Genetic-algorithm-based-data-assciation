function [DeleteLoc, DeleteNum]= DubElimination(Chrom,var)
% 消除重复个体
if strcmp(var,'bin')
end
a = size(Chrom,1);
NewChrom = Bin2Dec(Chrom,10);
Temp = 1:a;
DeleteLoc = zeros(1,a);
%% 加入重复删除策略
i = 1;
while i <= size(NewChrom,1)
    Sum = zeros(1,length(i+1:size(NewChrom,1)));
    k = 1;
    for j = i+1:size(NewChrom,1)
        Sum(k) = sum([NewChrom(i,:) - NewChrom(j,:)] == 0);
    end
    loc = find(Sum == 10) + i;
    DeleteLoc(Temp(loc)) = 1;
    NewChrom(loc,:) = [];
    i = i +1;
end
DeleteNum = a - size(NewChrom,1);