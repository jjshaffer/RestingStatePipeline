function x = read_all_netcc ()
%Function for converting .netcc files and compiling a .mat file based on
%list of subjects and sessions provided in SCANS variable
% Author: Joe Shaffer
% Date: 2018

DATA_DIR='/Volumes/mrrcdata/BD_TMS_TIMING/derivatives/AAL_RESULTS/';
%DATA_DIR='/Volumes/mrrcdata/BD_TMS_TIMING/derivatives/HALKO_RESULTS/';


%Because Control data is stored in the SCZ directories, you must provide
%this location as well and the index for where in the list the controls.
%When combining the TMS dataset, you will want to switch this to a very
%high value so that it isn't used
%start
CTRL_DIR = '/Volumes/mrrcdata/SCZ_TMS_TIMING/derivatives/AAL_RESULTS/';
%ctrl_index = 26;
ctrl_index = 1000;


matrixSize=116;
%BD vs HC

%Outprefix='BDvHC';

%SCANS = {'cbm0411',	'20180620';
%'cbm0421',	'20180725';
%'cbm0431',	'20180809';
%'cbm0441',	'20180919';
%'cbm0451',	'20180927';
%'cbm0461',	'20181025';
%'cbm0471',	'20181106';
%'cbm0481',	'20190114';
%'cbm0491',	'20181213';
%'CBM0501',	'20190131';
%'CBM0511',	'20190206';
%'CBM0531',	'20190307';
%'CBM0541',	'20190318';
%'CBM0551',	'20190425';
%'CBM0561',	'20190619';
%'CBM0571',	'20190725';
%'CBM0581',	'20190823';
%'CBM0591',	'20191001';
%'CBM0601',	'20191105';
%'CBM0611',	'20200205';
%'CBM0621',	'20200722';
%'CBM0641',	'20200828';
%'CBM0651',	'20200918';
%'CBM0661',	'20201104';
%'CBM0671',	'20201112';
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

%'CBM0631',	'20200811'; Still processing at this time

%'CBM0041','20180426';

%List of Scans for TMS comparison
Outprefix='BD_TMS';


SCANS = {'cbm0411', '20180620';
'cbm0411',	'20180629';
'cbm0421',	'20180725';
'cbm0421',	'20180803';
'cbm0431',	'20180809';
'cbm0431',	'20180817';
'cbm0441',	'20180919';
'cbm0441',	'20180928';
'cbm0451',	'20180927';
'cbm0451',	'20181005';
'cbm0461',	'20181025';
'cbm0461',	'20181102';
'cbm0471',	'20181106';
'cbm0471',	'20181116';
'cbm0481',	'20190114';
'cbm0481',	'20190125';
'cbm0491',	'20181213';
'cbm0491',	'20181221';
'CBM0501',	'20190131';
'CBM0501',	'20190208';
'CBM0511',	'20190206';
'CBM0511',	'20190215';
'CBM0531',	'20190307';
'CBM0531',	'20190315';
'CBM0541',	'20190318';
'CBM0541',	'20190329';
'CBM0551',	'20190425';
'CBM0551',	'20190503';
'CBM0561',	'20190619';
'CBM0561',	'20190628';
'CBM0571',	'20190725';
'CBM0571',	'20190802';
'CBM0581',	'20190823';
'CBM0581',	'20190830';
'CBM0591',	'20191001';
'CBM0591',	'20191011';
'CBM0601',	'20191105';
'CBM0601',	'20191115';
'CBM0611',	'20200205';
'CBM0611',	'20200214';
'CBM0621',	'20200722';
'CBM0621',  '20200731';
'CBM0641',	'20200828';
'CBM0641',	'20200904';
'CBM0651',	'20200918';
'CBM0651',	'20200925';
'CBM0661',	'20201104';
'CBM0661',	'20201113';
'CBM0671',	'20201112';
'CBM0671',	'20201120'};

temp = length(SCANS);

matrix=zeros(matrixSize, matrixSize, temp);

for i = 1:temp
    dirname = strcat('sub-',SCANS(i,1), '_ses-', SCANS(i,2));
    %disp(dirname);
    
    if i >= ctrl_index
        matrix(:,:,i) = read_netcc(CTRL_DIR, SCANS{i,1}, SCANS{i,2});

    else
        matrix(:,:,i) = read_netcc(DATA_DIR, SCANS{i,1}, SCANS{i,2});

    end
    
end

imgData=matrix;
outname = strcat(DATA_DIR,Outprefix,'_Data','-', date, '.mat');
disp(outname);
save(outname, 'imgData');

outname = strcat(DATA_DIR,Outprefix,'_SessionList','-', date, '.xls');
disp(outname);

T = array2table(SCANS, 'VariableNames', {'Subject', 'SessionID'});
writetable(T, outname);

x = matrix;
end