function [ChromDetail, Chrom]= InitHypothesisChrom(NIND,M,N)
ChromDetail = cell(1,NIND);
Chrom = zeros(NIND,M*N);
LengthofChorm = M*N;
if M > N,NumofHypothesis = factorial(M)/factorial(M - N);else...
        NumofHypothesis = factorial(N)/factorial(N - M);end 
for i = 1:NIND
    [k,CostCode] = GetOneHypothesis(M,N,NumofHypothesis);
    CheckCode(i,:) = CostCode(1,:);  %%%%%%%%%%%%%%for test
    ChromDetail{i}{1} = k;
    ChromDetail{i}{2} = zeros(1,LengthofChorm);
    offset = 1:N;
    for j = 1:N
        ChromDetail{i}{2}((j-1)*N + offset(CostCode(1,j))) = 1;
        CheckCodeDec(i,j) = (j-1)*N + offset(CostCode(1,j));
        offset(CostCode(1,j)) = [];
    end
    Chrom(i,:) = ChromDetail{i}{2};
end