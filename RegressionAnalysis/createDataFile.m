function out = createDataFile(covarFile, datadir, prefix)
%This function reads the data files from pre-processing in order to
%generate the matlab file of all participants' imaging data
%   Author: Joe Shaffer
%   Date: 9/5/2019
addpath('NIfTI_20140122');

T = readtable(covarFile);
[a b] = size(T);

imgData = zeros(116,116, a);
for i = 1:a
   
    
   %path = strcat(datadir, filesep,'sub-', num2str(T.Participant_ID(i)), filesep, T.x3T(i));
   path = strcat(datadir, filesep,'sub-', num2str(T.Participant_ID(i)), '_', T.x3T(i));
   
   path = char(path);
   if exist(path, 'dir')
       disp(path);
       
       %filename = strcat(path, filesep,'sub-', num2str(T.Participant_ID(i)), '_', T.x3T(i),'_acq-SLa50SLb10BrainMasked_STANDARD_T1rho.nii.gz');
       filename = strcat(path, filesep,'corr_test_sub-', num2str(T.Participant_ID(i)), '_', T.x3T(i),'_000.netcc');

       filename = char(filename);
       if exist(filename, 'file')
           
           %disp('Reading Data');
           %disp(filename);
           ses = extractAfter(T.x3T(i), 'ses-');
           %disp(ses);

           imgData(:,:,i) = read_netcc(datadir, num2str(T.Participant_ID(i)), ses);
           %x = load_nii(filename);
           %temp = x.img;
           %imgData(:,:,:,i) = temp;
       else
           disp('File Missing');
       end
       
   else
       disp(strcat('Missing Folder: ', path));
   end
end

save(strcat(prefix, '.mat'), 'imgData', '-v7.3');


out = T;
end

