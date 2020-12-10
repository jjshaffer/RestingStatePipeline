function x = runFDRCorrection(mapfile, outprefix)

%Load statistical map & identify its size
maps = load(mapfile);
[a, b, c] = size(maps.stats);

%Create vector for storing p-values
pColumn = zeros((a*(b-1)/2),1);

%Create variable for storing statistical input values
stats = maps.stats;

%Set c=2 to only correct experimental variable p-value matrix.
%Comment this line out to use thresholding on a per-variable basis where
%odd indices are t-statistic maps and even indices are p-value maps
c = 2;
for i=2:2:c
    %Initialize iterator variable for providing vector indice
    count = 1;
    
    %Loop through one side of y=x line in the matrix, fill in vector
    for j = 1:a
        for k = j+1:b
            
            %set vector index = to appropriate matrix element
            pColumn(count) = maps.stats(j,k,i);
            %add to vector index
            count = count+1;
        end
    end
    %disp(num2str(count));
    %x = pColumn;
    %length(pColumn)
    
    [FDR, Q, pi0] = mafdr(pColumn, 'showplot', true);
  
    count = 1;
    for j = 1:a
        for k = j+1:b
        
            stats(j,k,i) = Q(count);
            stats(k,j,i) = Q(count);
            count = count+1;
        end
    end
    x = stats;
end

filename = strcat(outprefix, '_FDRadjusted_Results.mat');
save(filename, 'stats');
end