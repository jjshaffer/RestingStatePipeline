function out = combineConnectivityRows(Prefix, n)


if (n >= 1)
    filename = strcat(Prefix, '_row-', num2str(1), '_results.mat');
    %disp(filename);
    
    row=load(filename);
    
    [a, b] = size(row.stats)
    
    stats = zeros(n,a,b);
else
    disp('No rows specified');
    exit;
    
end

for i = 1:n
    filename = strcat(Prefix, '_row-', num2str(i), '_results.mat');
    disp(filename);
    row=load(filename);
    
    stats(i,:,:) = row.stats(:,:);
    
end

save(strcat(Prefix, '_results.mat'), 'stats');

out = stats;
end