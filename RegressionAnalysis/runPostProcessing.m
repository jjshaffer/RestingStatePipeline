function out = runPostProcessing(prefix, threshold)

%Function for performing post-processing steps to reassemble image slices,
%create .nii.gz images (Using NIFTI Tools) and perform FDR correction on
%the main_contrast. This step should be followed by running toBucket.sh in
%the terminal to combine images into a single "BUCKET" image for AFNI
%viewing/thresholding. An example function call:
%runPostProcessing('BD_TMS_T1rho', 'BD_TMS_names.txt', 'SessionxTMS', 'BD_TMS_Data-04-Dec-2020-0.95Mask.mat');
% Author: Joe Shaffer
% December, 5, 2020

num_slices = 116;
%nameFile = 'names.txt'
niiTemplate = 'MNI_aligned_T1.nii.gz'


%Put images back together
out = combineConnectivityRows(prefix, num_slices);

%Run FDR correction on whole connectivity matrix
imgFile=strcat(prefix, '_results.mat');
out2 = runFDRCorrection(imgFile, prefix);

%Threshold FDR corrected Results
filename = strcat(prefix, '_FDRadjusted_Results.mat');
out3 = thresholdMaps(filename, strcat(prefix, '_FDRadjusted'), threshold);

%Create .edge file for BrainNet Viewer (Pajek is a clustering tool that I
%no longer use, but could be applied to this output as well)
filename = strcat(prefix, '_FDRadjusted_Thresholded-',num2str(threshold),'_Results.mat');
out5 = makePajekFormat( filename , 1, strcat(prefix, '_FDRadjusted_Thresholded-',num2str(threshold),'_Results'));

data = load(filename);
out6 = makeAALMatrix(squeeze(data.stats(:,:,1)), strcat(prefix, '_FDR_tStat'), -5, 5);


%Threshold uncorrected results & make Pajek file
out4 = thresholdMaps(imgFile, prefix, threshold);
filename = strcat(prefix, '_Thresholded-',num2str(threshold),'_Results.mat');
out5 = makePajekFormat(filename , 1, strcat(prefix, '_Thresholded-',num2str(threshold),'_Results'));
%Generate uncorrected data matrix
data = load(filename);
out6 = makeAALMatrix(squeeze(data.stats(:,:,1)), strcat(prefix, '_uncorr_tStat'), -5, 5);

%%% Apply Cerebellar Masks

Mask='AAL-cbmMask.mat';
maskName = 'cbm';

out6 = maskImage(Mask, imgFile, strcat(prefix, '_', maskName))

%FDR Correct Masked Results
maskfilename = strcat(prefix, '_',maskName, '_Masked.mat');
out7 = runMaskedFDRCorrection(maskfilename, Mask, strcat(prefix, '_',maskName, '_Masked'));
%Threshold
fdrfilename = strcat(prefix, '_',maskName, '_Masked_FDRadjusted_Results.mat');
out8 = thresholdMaps(fdrfilename, strcat(prefix, '_',maskName, '_Masked_FDRadjusted'), threshold);
%Make Pajek
out9 = makePajekFormat(strcat(prefix, '_', maskName, '_Masked_FDRadjusted_Thresholded-',num2str(threshold),'_Results.mat'), 1, strcat(prefix, '_', maskName, '_Masked_FDRadjusted_Thresholded-',num2str(threshold),'_Results' ));

%Threshold uncorrected Results & Make Pajek
out8 = thresholdMaps(maskfilename, strcat(prefix, '_',maskName, '_Masked'), threshold);
out9 = makePajekFormat(strcat(prefix, '_', maskName, '_Masked_Thresholded-',num2str(threshold),'_Results.mat'), 1, strcat(prefix, '_', maskName, '_Masked_Thresholded-',num2str(threshold),'_Results' ));



%Apply Second (Vermis) mask
Mask = 'AAL-VermisMask.mat';
maskName = 'Vermis';
out6 = maskImage(Mask, imgFile, strcat(prefix, '_', maskName))

%FDR Correct Masked Results
maskfilename = strcat(prefix, '_',maskName, '_Masked.mat');
out7 = runMaskedFDRCorrection(maskfilename, Mask, strcat(prefix, '_',maskName, '_Masked'));
%Threshold
fdrfilename = strcat(prefix, '_',maskName, '_Masked_FDRadjusted_Results.mat');
out8 = thresholdMaps(fdrfilename, strcat(prefix, '_',maskName, '_Masked_FDRadjusted'), threshold);
%Make Pajek
out9 = makePajekFormat(strcat(prefix, '_', maskName, '_Masked_FDRadjusted_Thresholded-',num2str(threshold),'_Results.mat'), 1, strcat(prefix, '_', maskName, '_Masked_FDRadjusted_Thresholded-',num2str(threshold),'_Results' ));

%Threshold uncorrected Results & Make Pajek
out8 = thresholdMaps(maskfilename, strcat(prefix, '_',maskName, '_Masked'), threshold);
out9 = makePajekFormat(strcat(prefix, '_', maskName, '_Masked_Thresholded-',num2str(threshold),'_Results.mat'), 1, strcat(prefix, '_', maskName, '_Masked_Thresholded-',num2str(threshold),'_Results' ));







out=1;
end