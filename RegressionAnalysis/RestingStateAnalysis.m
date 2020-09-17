function x = RestingStateAnalysis()


%batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020.txt', 'BD_AAL_Data-28-Jul-2020.mat', 'BDvHC', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~BD+Age+Male+(1|SUBJID)', 'BD');

%batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020_BDonly.txt', 'BD_AAL_Data-28-Jul-2020_BDonly.mat', 'MADRS', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~MADRS+Age+Male+(1|SUBJID)', 'MADRS');
%batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020_BDonly.txt', 'BD_AAL_Data-28-Jul-2020_BDonly.mat', 'YMRS', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~YMRS+Age+Male+(1|SUBJID)', 'YMRS');
%batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020_BDonly.txt', 'BD_AAL_Data-28-Jul-2020_BDonly.mat', 'TotalAttempts', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~TotalAttempts+Age+Male+(1|SUBJID)', 'TotalAttempts');
batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020_BDonly.txt', 'BD_AAL_Data-28-Jul-2020_BDonly.mat', 'PrevAttempt', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~PrevAttempt+Age+Male+(1|SUBJID)', 'PrevAttempt');

%batchRestingStateContrast('BD_TMS_SessionList-28-Jul-2020.txt', 'BD_AAL_Data-28-Jul-2020.mat', 'Mood', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~Mood+Age+Male+(1|SUBJID)', 'Mood');

%batchRestingStateContrast('BD_ImagingDemographics_DvE.txt', 'BD_rsfMRI_DvE_data.mat', 'DvE', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~D+Age+Male+(1|SUBJID)', 'D');
%batchRestingStateContrast('BD_ImagingDemographics_DvHC.txt', 'BD_rsfMRI_DvH_data.mat', 'DvH', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~D+Age+Male+(1|SUBJID)', 'D');
%batchRestingStateContrast('BD_ImagingDemographics_DvM.txt', 'BD_rsfMRI_DvM_data.mat', 'DvM', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~D+Age+Male+(1|SUBJID)', 'D');


%batchRestingStateContrast('BD_ImagingDemographics_MvE.txt', 'BD_rsfMRI_MvE_data.mat', 'MvE', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~M+Age+Male+(1|SUBJID)', 'M');
%batchRestingStateContrast('BD_ImagingDemographics_MvHC.txt', 'BD_rsfMRI_MvH_data.mat', 'MvH', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~M+Age+Male+(1|SUBJID)', 'M');

%batchRestingStateContrast('BD_Only_ImagingDemographics.txt', 'BD_Only_rsfMRI_data-29-Jan-2020.mat', 'Attempt', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~Attempt+Age+Male+(1|SUBJID)', 'Attempt');
%batchRestingStateContrast('BD_Only_ImagingDemographics.txt', 'BD_Only_rsfMRI_data-29-Jan-2020.mat', 'Ideation', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~Ideation+Age+Male+(1|SUBJID)', 'Ideation');
%batchRestingStateContrast('BD_Only_ImagingDemographics.txt', 'BD_Only_rsfMRI_data-29-Jan-2020.mat', 'Thoughts', 'BOLD~Age+Male+(1|SUBJID)', 'BOLD~Thoughts+Age+Male+(1|SUBJID)', 'Thoughts');



x = 1;
end
