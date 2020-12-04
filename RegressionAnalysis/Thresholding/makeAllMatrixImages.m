function out = makeAllMatrixImages()
out = 1;
SUBJECTS = {'CMB0001'; 'CMB0011'; 'CMB0021'; 'CMB0031'};
TYPES = {'pre'; 'post'; 'DIFFERENCE'}

[a,b] = size(SUBJECTS);
[c,d] = size(TYPES);

for i = 1:a
    for j = 1:c
    prefix = strcat(TYPES(j), '_', SUBJECTS(i));
    filename = strcat(prefix, '.mat');
    prefix = char(prefix);
    filename = char(filename);
    
    data = load(filename);
    if j==3
        out = makeAALMatrix(data.matrix, prefix, -100, 100); 
    else
        out = makeAALMatrix(data.matrix, prefix, -1, 1); 
    end
    end
end
%data = load(filename);

%[a, b, c] = size(data.stats);

%typeLabels = {'Pain', 'Urgency', 'PainXTime', 'UrgencyXTime'};
%typeLabels = {'HCvFDR-pd', 'HCvSDR-pd', 'SDRvFDR-pd'};
%typeLabels = {'SIPSDIS', 'SIPSNEG', 'SIPSPOS', 'SIPSGEN', 'HCvFDR-pd', 'HCvSDR-pd', 'SDRvFDR-pd'};
%runLabels = {'Score', '', '', '', ''};

%out = makeAALMatrix(data.matrix, prefix, -1, 1);


%for i = 1:c
%    j = ceil(i./2);
%    if(~strcmp(runLabels(1,j),''))
%        disp(char(runLabels{1,j}));
        
%        if(mod(i,2)==0)
%           t = makeAALMatrix(data.stats(:,:,i), strcat(prefix,'_',runLabels{1,j}, '_1-p'), -1, 1);
%        else
%           t = makeAALMatrix(data.stats(:,:,i), strcat(prefix,'_',runLabels{1,j}, '_t'), -5, 5);
%        end
%        
%    end

%out = runLabels;
end