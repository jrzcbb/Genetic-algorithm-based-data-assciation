function Chrom = Bin2Dec (Chrom,N)
[M1,~]  = size(Chrom);
NewChrom = zeros(M1,N);
for i= 1:M1
    NewChrom(i,:) = mod(find(Chrom(i,:)),10);
end
Chrom = NewChrom;