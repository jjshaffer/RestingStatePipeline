function out = combineSlices(prefix)

h = load_nii('anatomical2.nii.gz');
m = load('BOLDMask.mat');
xdim =256;
ydim=256;
zdim=256;
vars = 10;

stats = zeros(xdim, ydim, zdim, vars);

for i = 1:xdim
   filename = strcat(prefix, 'output', num2str(i), '.mat');
   disp(filename);
   
   slice = load(filename);
   
   stats(i,:,:,:) = slice.stats(:,:,:);
    
end

matrix = stats(:,:,:,1);
filename = strcat(prefix, '_Effect_t.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);

matrix = stats(:,:,:,2);
filename = strcat(prefix, '_Effect_p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Effect_p.mat');
save(filename, 'matrix', '-v7.3');

for i = 1:xdim
    for j = 1:ydim
        for k = 1:zdim
            if(m.mask(i,j,k) == 1)
                matrix(i,j,k) = 1-matrix(i,j,k);
            else
                matrix(i,j,k) = 0;
            end
        end
    end
end
filename = strcat(prefix, '_Effect_1-p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Effect_1-p.mat');
save(filename, 'matrix', '-v7.3');



matrix = stats(:,:,:,3);
filename = strcat(prefix, '_Sex_t.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Sex_t.mat');
save(filename, 'matrix', '-v7.3');

matrix = stats(:,:,:,4);
filename = strcat(prefix, '_Sex_p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Sex_p.mat');
save(filename, 'matrix', '-v7.3');

for i = 1:xdim
    for j = 1:ydim
        for k = 1:zdim
            if(m.mask(i,j,k) == 1)
                matrix(i,j,k) = 1-matrix(i,j,k);
            else
                matrix(i,j,k) = 0;
            end
        end
    end
end
filename = strcat(prefix, '_Sex_1-p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Sex_1-p.mat');
save(filename, 'matrix', '-v7.3');


matrix = stats(:,:,:,5);
filename = strcat(prefix, '_Age_t.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Age_t.mat');
save(filename, 'matrix', '-v7.3');

matrix = stats(:,:,:,6);
filename = strcat(prefix, '_Age_p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Age_p.mat');
save(filename, 'matrix', '-v7.3');

for i = 1:xdim
    for j = 1:ydim
        for k = 1:zdim
            if(m.mask(i,j,k) == 1)
                matrix(i,j,k) = 1-matrix(i,j,k);
            else
                matrix(i,j,k) = 0;
            end
        end
    end
end
filename = strcat(prefix, '_Age_1-p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_Age_1-p.mat');
save(filename, 'matrix', '-v7.3');

matrix = stats(:,:,:,7);
filename = strcat(prefix, '_MADRSST_t.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_MADRSST_t.mat');
save(filename, 'matrix', '-v7.3');


matrix = stats(:,:,:,8);
filename = strcat(prefix, '_MADRSST_p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_MADRSST_p.mat');
save(filename, 'matrix', '-v7.3');

for i = 1:xdim
    for j = 1:ydim
        for k = 1:zdim
            if(m.mask(i,j,k) == 1)
                matrix(i,j,k) = 1-matrix(i,j,k);
            else
                matrix(i,j,k) = 0;
            end
        end
    end
end
filename = strcat(prefix, '_MADRSST_1-p.nii.gz');
disp(filename);
x = make_nii(matrix);
x.hdr.hist = h.hdr.hist;
save_nii(x, filename);
filename = strcat(prefix, '_MADRSST_1-p.mat');
save(filename, 'matrix', '-v7.3');

out = stats;
end