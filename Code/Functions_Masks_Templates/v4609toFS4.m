function [out] = v4609toFS4(in_data)

load('v4609tov5124.mat')
Ind = find(v4609tov5124>0);

out = zeros(5124,1);

for i = 1:4609
    out(Ind(i)) = in_data(i);
end

