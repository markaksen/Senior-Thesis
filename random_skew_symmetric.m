function A  = random_skew_symmetric(n)

if n > 1
    m = nchoosek(n,2);
else 
    m = 1;
end

A = zeros(n);

for i = 1:n-1
    for j = i+1:n
        A(i,j) = randn(1,1); A(j,i) = -A(i,j);
    end
end
    


end
