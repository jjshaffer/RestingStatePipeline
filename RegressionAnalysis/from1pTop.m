function x = from1pTop(mapfile, outprefix)

maps = load(mapfile);
[a, b, c] = size(maps.stats);

%stats = zeros(a,b,c);
stats = maps.stats;

for i=2:2:c

    for j = 1:a
        for k = 1:b
        stats(j,k,i) = abs(stats(j,k,i) - 1);
        end
    end
    
end
outfile = strcat(outprefix, '_p_results.mat');
save(outfile, 'stats');
x = stats;
end