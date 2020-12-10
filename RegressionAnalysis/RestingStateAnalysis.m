function x = RestingStateAnalysis(i)

DATA_DIR ='/Shared/MRRCdata/SCZ_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';
%DATA_DIR ='/Volumes/mrrcdata/SCZ_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis/';

covars = 'SCZ_TMS_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'SCZ_TMS_Data-07-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'SCZ_TMS', 'BOLD~TMS+Session+Age+Sex+(1|Subject)', 'BOLD~TMS*Session+Age+Sex+(1|Subject)', 'Session:TMS');

covars = 'SCZvHC_SessionList-03-Dec-2020.txt';
data = strcat(DATA_DIR, 'SCZvHC_Data-07-Dec-2020.mat');
batchRestingStateContrast(i,covars, data, 'SCZvHC', 'BOLD~Age+Sex+(1|Subject)', 'BOLD~Group+Age+Sex+(1|Subject)', 'Group');

x = 1;
end