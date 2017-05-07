function mid = getStructure(parts, num_p)
mid = [ ];
centers = zeros(num_p, 2);
for i = 1: num_p
    centers(i, 1) = (parts{i}(1)+parts{i}(2))/2;
    centers(i, 2) = (parts{i}(3)+parts{i}(4))/2;
end

for i = 1: num_p
    for j = i+1: num_p
        if i ~= j
            mid = [mid, norm(centers(i, :)-centers(j, :))];
        end
    end
end
mid = mid / sqrt(sum(mid.*mid));


