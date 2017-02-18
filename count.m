function [cnt, max, nonzero] = count(ALM)
cnt = 0;
max = 0;
nonzero=0;
s = size(ALM);
for k = 1:s(2)
    x = size(ALM{k}); 
    if x(1) ~= 0
        nonzero = k;
        cnt=cnt+1;
        if x(1) > max
            max = x(1);
        end
    end
end
end