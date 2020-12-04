function x = read_all_netcc ()

DATA_DIR='/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/AAL_RESULTS/';
%DATA_DIR='/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/HALKO_RESULTS/';

matrixSize=116;

%Because Control data is stored in the SCZ directories, you must provide
%this location as well and the index for where in the list the controls.
%When combining the TMS dataset, you will want to switch this to a very
%high value so that it isn't used
%start
%CTRL_DIR = '/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/TimingTask_Onset/';
%CTRL_DIR = '/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/TimingTask_Response/';
%ctrl_index = 26;
%ctrl_index = 1000;

%List of Scans for Group comparison
Outprefix='SCZvHC';

%SCANS = {
%'CBM0001',	'20171128';
%'CBM0011',	'20180118';
%'CBM0021',	'20180129';
%'CBM0031',	'20180216';
%'CBM0051',	'20180709';
%'CBM0061',	'20180822';
%'CBM0071',	'20181004';
%'CBM0081',	'20190402';
%'CBM0091',	'20190515';
%'CBM0101',	'20190923';
%'CBM0111',	'20191113';
%'CBM0131',	'20201008';
%'CBM0141',	'20201015';
%'23517557',	'2020100610153T';
%'23517558',	'202010143T';
%'23517559',	'2020101609453T';
%'23517560',	'2020102914503T';
%'23517562',	'202011123T';
%'23517563',	'202011133T';
%'23517564',	'202011163T';
%'23517565',	'202011203T';
%'23517566',	'202011233T';
%'23517567',	'202011243T';
%'CTL9001',	'20190807';
%'CTL9011',	'20191003';
%'CTL9021',	'20191009';
%'CTL9041',	'20191107';
%'CTL9051',	'20200305';
%'CTL9061',	'20200309';
%'CTL9071',	'20200313';
%'CTL9081',	'20200626';
%'CTL9091',	'20200824';
%'CTL9101',	'20200826';
%'CTL9111',	'20201027'};

%'CBM0041','20180426'; Missing data

%List of Scans for TMS comparison
Outprefix='SCZ_TMS';

SCANS = {
'CBM0001',	'20171128';
'CBM0001',	'20171208';
'CBM0011',	'20180118';
'CBM0011',	'20180126';
'CBM0021',	'20180129';
'CBM0021',	'20180209';
'CBM0031',	'20180216';
'CBM0031',	'20180223';
'CBM0061',	'20180822';
'CBM0061',	'20180831';
'CBM0071',	'20181004';
'CBM0071',	'20181012';
'CBM0131',	'20201008';
'CBM0131',	'20201016';
'CBM0141',	'20201015';
'CBM0141',	'20201023'};

temp = length(SCANS);

matrix=zeros(matrixSize, matrixSize, temp);

for i = 1:temp
    dirname = strcat('sub-',SCANS(i,1), '_ses-', SCANS(i,2));
    %disp(dirname);
    matrix(:,:,i) = read_netcc(DATA_DIR, SCANS{i,1}, SCANS{i,2});
end

imgData=matrix;
%outname = strcat(DATA_DIR,'SCZvHC_Data-', date, '.mat');
outname = strcat(DATA_DIR, Outprefix,'_Data-', date, '.mat');

disp(outname);
save(outname, 'imgData');

%outname = strcat(DATA_DIR,'SCZvHC_SessionList-', date, '.xls');
outname = strcat(DATA_DIR, Outprefix,'_SessionList-', date, '.xls');

disp(outname);

T = array2table(SCANS, 'VariableNames', {'Subject', 'Session'});
writetable(T, outname);

x = matrix;
end