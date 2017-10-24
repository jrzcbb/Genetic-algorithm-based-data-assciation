function NewChrom = Crossover(Chrom,N,px) 
% 思路是找到每一列中相同的值，构造一个矩阵
% 因为分配矩阵的几个假设，这种编码跟一般的
% 遗传算法编码的交叉算法有很大的不同
% 为了简化程序设计过程，将染色体交叉分为两种
% 1.染色体自交叉（大概率）
% 2.染色体互交叉（小概率）
% 用自交叉代替变异
% 并加入重复淘汰策略
Pc = px;                   %默认交叉概率为0.7
[M1,M2] = size(Chrom);
NewChrom = zeros(M1,N);
for i= 1:M1
    NewChrom(i,:) = mod(find(Chrom(i,:)),10);
%     subplot(121),spy(reshape(Chrom(i,:),10,10)); %%%%%froTest
    nRand = rand;
    if nRand < Pc                  %自交叉
        nRand = ceil(nRand*10);
        for j = 1:nRand
            a = floor(rand*10)+1;
            b = floor(rand*10)+1;
            Temp = NewChrom(i,a);
            NewChrom(i,a) = NewChrom(i,b);
            NewChrom(i,b) = Temp;
        end
    end
%     CheckChrom = Dec2Bin(NewChrom(i,:),10,10);
%     subplot(122),spy(reshape(CheckChrom,10,10));pause
end

%% 加入重复删除策略
i = 1;
while i <= size(NewChrom,1)
    Sum = zeros(1,length(i+1:size(NewChrom,1)));
    k = 1;
    for j = i+1:size(NewChrom,1)
        Sum(k) = sum([NewChrom(i,:) - NewChrom(j,:)] == 0);
    end
    loc = find(Sum == 10) + i;
    NewChrom(loc,:) = [];
    i = i +1;
end

a=0;


