function NewChrom = Dec2Bin(Chrom,M,N)
[M1,M2] = size(Chrom);
NewChrom = zeros(M1,M*N);
for i = 1:M1
    for j = 1:M2
        loc = Chrom(i,j) + (j-1)*10;
        if mod(loc,10) ~= 0
            NewChrom(i,Chrom(i,j) + (j-1)*10) = 1;
        else
            NewChrom(i,10 + (j-1)*10) = 1;
        end
    end
end