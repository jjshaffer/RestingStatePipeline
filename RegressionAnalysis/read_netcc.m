function out = read_netcc(DATA_DIR,subjID, session)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

infile = strcat(DATA_DIR,filesep,'sub-', subjID, '_ses-', session, filesep,'corr_test_sub-', subjID, '_ses-', session, '_000.netcc');
infile = char(infile);
disp(infile);

fileID = fopen(infile,'r');

A = fgetl(fileID);
A = strtrim(strsplit(A, '#'));

netsize=str2num(A{2});
%disp(num2str(netsize));

%out = zeros(netsize, netsize);
out = zeros(116, 116);

for i = 1:3
A = fgetl(fileID);
%disp(A);
end

A = fgetl(fileID);
%disp(A);
D = strsplit(A, '\t');

for i = 1:netsize
   temp = str2num(strtrim(D{i})); 
   %disp(num2str(temp));
end

A = fgetl(fileID);

for i = 1:netsize
   %disp(strcat(num2str(i), ':', strtrim(D{i})));
   B = fgetl(fileID);
   %disp(B);
   
    C = strtrim(strsplit(B, '\t'));
    for j = 1:netsize
       out(str2num(strtrim(D{i})),str2num(strtrim(D{j}))) = str2num(C{j}); 
    end
end
fclose(fileID);
%out = C;

matrix = out;

%save(char(strcat(DATA_DIR,filesep,'sub-', subjID, '_ses-', session, filesep,'corr_test_sub-', subjID, '_ses-', session, '.mat')), 'matrix');


xlswrite(char(strcat(DATA_DIR,filesep,'sub-', subjID, '_ses-', session, filesep,'corr_test_sub-', subjID, '_ses-', session, '.csv')), matrix);

copyfile(char(strcat(DATA_DIR,filesep,'sub-', subjID, '_ses-', session, filesep,'corr_test_sub-', subjID, '_ses-', session, '.csv')), char(strcat(DATA_DIR,filesep,'ScanCSVs', filesep,'corr_test_sub-', subjID, '_ses-', session, '.csv')));
end

