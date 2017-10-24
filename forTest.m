
for i = 1:38
    CheckChrom = Dec2Bin(NewChrom(i,:),M,N);
    spy(reshape(CheckChrom,10,10));pause
end
