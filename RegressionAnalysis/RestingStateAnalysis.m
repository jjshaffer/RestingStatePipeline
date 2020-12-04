function x = RestingStateAnalysis(i)

DATA_DIR ='/Shared/MRRCdata/BD_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';
%DATA_DIR ='/Volumes/mrrcdata/BD_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';

covars = 'BD_TMS_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'BD_TMS_Data_04-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'BD_TMS', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

covars = 'BDvHC_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'BDvHC_Data_04-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'BDvHC', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

x = 1;
end