%Function for generating a p map from a 1-p-value map.
%Author: Joe Shaffer
%Date: June 2017

function x = from1pTop(mapfile, outprefix)

maps = load(mapfile);
[a, b, c] = size(maps.stats);

%stats = zeros(a,b,c);
stats = maps.stats;

%Loop through statistical maps in mapfile
for i=2:2:c

    for j = 1:a
        for k = 1:b
               stats(j,k,i) = abs(stats(j,k,i) - 1);
        end
    end
    
end
%Save output
outfile = strcat(outprefix, '_p_results.mat');
save(outfile, 'stats');
x = stats;
end
