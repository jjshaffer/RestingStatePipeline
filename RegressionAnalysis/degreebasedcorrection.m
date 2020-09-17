function out = degreebasedcorrection(mapfile, outprefix, threshold, degree)

maps = load(mapfile);
[a, b, c] = size(maps.stats);

stats = zeros(a,b,c);
c=2;
for i=2:2:c
   
    for x=1:a
         count = 0;
        for y=1:b
         if(abs(maps.stats(x,y,i)) < threshold)
         
         count = count + 1;
         end
        end
        
        %disp(strcat('Row:', num2str(x), '- Degree:', num2str(count)));
        if(count >= degree)
        
            stats(x,:,i) = maps.stats(x,:,i);
            stats(x,:,i-1) = maps.stats(x,:,i-1);
            
            stats(:,x,i) = maps.stats(:,x,i);
            stats(:,x,i-1) = maps.stats(:,x,i-1);
        end
    end
    
   
end

filename = strcat(outprefix, '_degreeCorrected_Results.mat');
save(filename, 'stats');
out = stats;
end