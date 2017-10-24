function [k,CostCode] = GetOneHypothesis(M,N,NumofHypothesis)
k = fix(unifrnd(0,NumofHypothesis));
loc = zeros(2,N);
loc(1,1) = floor(k/factorial(N - 1)) + 1;
loc(2,1) = mod(k,factorial(N - 1));
for i = 2:N
    loc(1,i) = floor(loc(2,i-1)/factorial(N - i)) + 1;
    loc(2,i) = mod  (loc(2,i-1),factorial(N - i));
    if loc(2,i) == 0 
        loc(1,i) = loc(1,i) - 1;
        for j = i+1:N
            loc(1,j) = N - j + 1;
        end
        break;
    end
end
CostCode = loc;
