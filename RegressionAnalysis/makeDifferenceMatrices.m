function out = makeDifferenceMatrices()

SUBJECTS = {'CMB0001'; 'CMB0011'; 'CMB0021'; 'CMB0031'};
TYPES = {'pre'; 'post'}

[a,b] = size(SUBJECTS);
[c,d] = size(TYPES);

for i = 1:a
    for j = 1:c
    
    filename = strcat(TYPES(j), '_', SUBJECTS(i), '.mat');
    filename = char(filename);
    data = load(filename);   
    
    if j==1
       a = data.matrix; 
    else
        b = data.matrix;    
    end
    
    end
    
    matrix = (b - a)./a .*100;
    
    prefix = strcat('DIFFERENCE_', SUBJECTS(i), '.mat');
    prefix = char(prefix);
    
    save(prefix, 'matrix', '-v7.3');
end

end