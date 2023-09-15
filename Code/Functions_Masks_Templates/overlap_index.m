function oi = overlap_index(map1, map2)

n = length(map1);
overlap = 0;
for i = 1:n
    if map1(i) == map2(i)
        overlap = overlap + 1;
    end
end
oi = overlap / n;
end