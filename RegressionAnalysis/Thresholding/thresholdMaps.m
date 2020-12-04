function out = thresholdMaps(mapfile, outprefix, threshold)

maps = load(mapfile);
[a, b, c] = size(maps.stats);

stats = zeros(a,b,c);

for i=2:2:c
    
    for x=1:a
        for y=1:b
            
            %if(abs(maps.stats(x,y,i)) > 0.95)
            if(abs(maps.stats(x,y,i)) < threshold)
               stats(x,y,i) = maps.stats(x,y,i); 
               stats(x,y,i-1) = maps.stats(x,y,i-1);
               %stats(x,y,i) = 1;
               %stats(x,y,i-1) = 1;
            else
               stats(x,y,i) = 0;
               stats(x,y,i-1) = 0;
            end
            
        end
    end
    
end

  save(strcat(outprefix, '_Thresholded-',num2str(threshold),'_Results.mat'), 'stats', '-v7.3');
  out = stats;

end