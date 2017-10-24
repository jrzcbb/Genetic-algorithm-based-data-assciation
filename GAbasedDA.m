clc
clear
close all

M = 10;
N = 10;
K = 10; %Murty生成假设数量
CostMat = rand(M,N);
%% Murty算法测试
tic
% [assgmt, cost] = Hungarian(CostMat);
[solution,cost] = Murty(CostMat, K);
timaMurty = toc;
CheckSolution = solution{1}{1}';
CheckSolution(logical(CheckSolution == 10)) = 0;
CheckSolution = reshape(Dec2Bin(CheckSolution,M,N),10,10);
figure(1),subplot(133),spy(CheckSolution');
CostMat = reshape(CostMat,1,size(CostMat,1)*size(CostMat,2));
cost = sum(CostMat(logical(CheckSolution')));
avrcost = 0;
for i = 1:K
    CheckSolution = solution{i}{1}';
    CheckSolution(logical(CheckSolution == 10)) = 0;
    CheckSolution = reshape(Dec2Bin(CheckSolution,M,N),10,10);
    avrcost = avrcost + sum(CostMat(logical(CheckSolution')))/K;
end
disp(['Murty Cost = ' num2str(cost) ',平均Cost = ' num2str(avrcost) ',耗时 = ' num2str(timaMurty)]);

%% 定义遗传算法参数
NIND=20;        %个体数目
MAXGEN=300;      %最大遗传代数
PRECI=M*N;       %变量的二进制位数
GGAP=0.5;      %代沟,存活概率
px=0.7;         %交叉概率
pm=0.01;        %变异概率
trace1=zeros(1,MAXGEN);                        %寻优结果的初始值
trace2=zeros(MAXGEN,PRECI);
[ChromDetail, Chrom]= InitHypothesisChrom(NIND,M,N);
% forTest;
%% 优化
gen = 0;
ObjV = zeros(NIND,1);
for i = 1:NIND
    ObjV(i,1) = sum(CostMat(logical(Chrom(i,:))));
end
tic
while gen<MAXGEN
    FitnV = ranking(ObjV);
    SelCh = select('sus',Chrom,FitnV,GGAP);
    NewChrom = Crossover(SelCh,N,px);
%     forTest
    DeleteNum1 = NIND*GGAP - size(NewChrom,1);
    [DeleteLoc, DeleteNum2] = DubElimination(Chrom,'bin');
    Chrom(logical(DeleteLoc),:) = [];
    [~, InsertChrom]= InitHypothesisChrom(ceil(NIND * (1-GGAP)+ DeleteNum1 + DeleteNum2) ,M,N);%
    NewChrom = Dec2Bin(NewChrom,M,N);
    NewChrom = [NewChrom;InsertChrom];
    AllChrom = [NewChrom;Chrom];
    for i = 1:2*NIND
        ObjVAll(i,1) = sum(CostMat(logical(AllChrom(i,:))));
    end
    FitnV = ranking(ObjVAll);
    Chrom = select('sus',AllChrom,FitnV,0.5);
    for i = 1:NIND
        ObjV(i,1) = sum(CostMat(logical(Chrom(i,:))));
    end
    
    gen = gen + 1;
    [a,b] = min(ObjV);
    trace1(gen) = min(ObjV);
    trace2(gen,:) = Chrom(b,:);
end
timeGA = toc;
%% 结果分析
figure(1);
a = sort(ObjV,'ascend');
disp(['GA    Cost = ' num2str(trace1(end)) ',平均Cost = ' num2str(mean(a(1:20))) ',耗时 = ' num2str(timeGA)]);
MinCostAssignment = reshape(trace2(end,:),M,N);
subplot(131),plot(1:MAXGEN,trace1);title('迭代次数与Cost'),xlabel('迭代次数'),ylabel('Cost');
subplot(132),spy(MinCostAssignment);title('最优分配');

