function out = read_netcc(DATA_DIR,subjID, session)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

infile = strcat(DATA_DIR,'sub-', subjID, '_ses-', session, '/corr_test_sub-', subjID, '_ses-', session, '_000.netcc');
disp(infile);
fileID = fopen(infile,'r');

A = fgetl(fileID);
A = strtrim(strsplit(A, '#'));

netsize=str2num(A{2});
%disp(num2str(netsize));

out = zeros(netsize, netsize);

for i = 1:5
A = fgetl(fileID);
%disp(A);
end

for i = 1:netsize
   B = fgetl(fileID);
   %disp(B);
   
    C = strtrim(strsplit(B, '\t'));
    for j = 1:netsize
       out(i,j) = str2num(C{j}); 
    end
end
fclose(fileID);
%out = C;

matrix = out;

save(strcat(DATA_DIR,'sub-', subjID, '_ses-', session, '/corr_test_sub-', subjID, '_ses-', session, '.mat'), 'matrix');
end

