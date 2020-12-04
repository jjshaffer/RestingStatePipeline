function x = maskImage(maskfile, mapfile, outprefix)

maps = load(mapfile);
mask = load(maskfile);
[a, b, c] = size(maps.stats);

stats = zeros(a,b,c);

for i=2:2:c
    
    for x=1:a
        for y=1:b
            
               stats(x,y,i) = mask.mask(x,y) * maps.stats(x,y,i); 
               stats(x,y,i-1) = mask.mask(x,y) * maps.stats(x,y,i-1);
            end
            
        end
end

filename = strcat(outprefix, '_Masked.mat');
save(filename, 'stats');

end