function x = RestingStateAnalysis(i)

DATA_DIR ='/Shared/MRRCdata/BD_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';
%DATA_DIR ='/Volumes/mrrcdata/BD_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';

covars = 'BD_TMS_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'BD_TMS_Data-04-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'BD_TMS', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

covars = 'BDvHC_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'BDvHC_Data-04-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'BDvHC', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

%Comparison of pre-post in TMS recipients only for Grant
covars = 'BD_TMS_Only_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'BD_TMS_Only_Data-04-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'BD_TMS_Only', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Session+Age+Sex+(1|Subject)', 'Session');


x = 1;
end