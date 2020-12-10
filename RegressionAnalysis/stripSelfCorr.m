function x = stripSelfCorr(infile, outprefix)

maps = load(infile);
[a, b, c] = size(maps.stats);

%stats = zeros(a,b,c);
stats = maps.stats;

for i=1:c
    
    for x=1:a
        
        for y = 1:b
            
            if(x==y)
               stats(x,y,i) = 0; 
            end
        end
               
    end
    
end

  save(strcat(outprefix, '_Stripped_Results.mat'), 'stats', '-v7.3');
  out = stats;

end