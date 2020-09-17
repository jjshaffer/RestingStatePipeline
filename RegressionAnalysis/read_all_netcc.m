function x = read_all_netcc ()

%DATA_DIR='/Volumes/mrrcdata/Bipolar_R01/derivatives/AAL_RESULTS';
%DATA_DIR='/Volumes/mrrcdata/BD_TMS_TIMING/derivatives/HALKO_RESULTS';
DATA_DIR='/Shared/MRRCdata/Bipolar_R01/derivatives/AAL_RESULTS';
matrixSize=116;
index=18;
SCANS = {
'23517001', '2017111012153T';
'23517002', '2017120813453T';
'23517003', '2017122712303T';
'23517004', '2018010509303T';
'23517005', '2018011813003T';
'23517006', '2018012610303T';
'23517007', '2018013113003T';
'23517008', '2018020114453T';
'23517009', '2018020812003T';
'23517010', '2018020909303T';
'23517011', '2018021312303T';
'23517012', '2018022211003T';
'23517013', '2018022711003T';
'23517014', '2018031612003T';
'23517015', '2018040408303T';
'23517016', '2018040909353T';
'23517017', '2018041217003T';
'23517017', '2018062617003T';
'23517018', '2018043011453T';
'23517019', '2018050114153T';
'23517020', '2018050310153T';
'23517020', '2018082408003T';
'23517021', '2018050710453T';
'23517021', '2018080809003T';
'23517023', '2018052409003T';
'23517024', '201805313T';
'23517025', '2018061211303T';
'23517026', '2018061914053T';
'23517027', '2018062114403T';
'23517027', '2018120608453T';
'23517029', '201806253T';
'23517030', '2018062710303T';
'23517031', '2018062811003T';
'23517033', '201807063T';
'23517034', '2018071017003T';
'23517035', '2018071111003T';
'23517036', '2018073110353T';
'23517036', '2018110710103T';
'23517038', '2018080709403T';
'23517040', '2018081014103T';
'23517041', '2018082808003T';
'23517041', '2018111408003T';
'23517042', '201808313T';
'23517043', '2018090409003T';
'23517044', '2018090713453T';
'23517045', '2018091814303T';
'23517046', '201810041003T';
'23517047', '2018101610003T';
'23517048', '2018102508453T';
'23517049', '2018110509303T';
'23517050', '2018111911153T';
'23517051', '2018112011403T';
'23517052', '2018121811003T';
'23517052', '2019040410303T';
'23517053', '2018122712403T';
'23517054', '2019010810003T';
'23517055', '201901113T';
'23517056', '2019011410303T';
'23517057', '201902083T';
'23517058', '2019021514003T';
'23517059', '2019022013153T';
'23517059', '2019051408453T';
'23517060', '2019022810303T';
'23517061', '2019030410003T';
'23517061', '2019052409303T';
'23517062', '2019030611003T';
'23517064', '2019031510003T';
'23517065', '201903253T';
'23517066', '2019032610003T';
'23517067', '2019040311003T';
'23517069', '2019042910303T';
'23517070', '2019043008303T';
'23517071', '2019051309003T';
'23517072', '2019060510003T';
'23517073', '201906243T';
'23517075', '2019082909003T';
'23517076', '2019083010303T';
'23517077', '201909113T';
'23517079', '2019091612303T';
'23517080', '2019100716153T';
'23517081', '2019100811103T';
'23517082', '2019101113053T';
'23517083', '2019101610303T';
'23517086', '20191023108003T';
'23517087', '2019110810303T';
'23517501', '2018022116453T';
'23517502', '2018022614303T';
'23517503', '2018030109303T';
'23517504', '2018030502453T';
'23517505', '2018030609003T';
'23517506', '2018031215403T';
'23517507', '2018030617003T';
'23517508', '2018030915403T';
'23517509', '2018031211403T';
'23517510', '2018032013503T';
'23517511', '2018032016503T';
'23517512', '2018032914003T';
'23517513', '2018040314353T';
'23517514', '2018041110203T';
'23517515', '2018041814003T';
'23517516', '201805293T';
'23517517', '2018061109003T';
'23517518', '201806133T';
'23517519', '2018062011003T';
'23517520', '2018082708403T';
'23517521', '2018082909003T';
'23517522', '2018091313503T';
'23517523', '201809253T';
'23517524', '2018092712303T';
'23517525', '2018100313003T';
'23517526', '2018101510303T';
'23517527', '2018110715003T';
'23517529', '2018112717003T';
'23517530', '2018112813003T';
'23517531', '2018113014003T';
'23517532', '2018121010003T';
'23517533', '2019021110453T';
'23517535', '2019021912003T';
'23517536', '2019030113303T';
'23517537', '2019031110403T';
'23517538', '2019031316303T';
'23517541', '2019050810003T';
'23517542', '2019070510303T';
'23517543', '2019070916303T';
'23517544', '2019071515453T';
'23517545', '2019071810153T';
'23517546', '2019071909303T';
'23517547', '2019072209003T';
'23517548', '2019072409003T';
'23517549', '2019072514053T';
'23517550', '2019072910003T';
'23517551', '201908013T';
'23517552', '2019080714453T';
'23517553', '2019091711303T';
'23517554', '2019102216353T';
'23517555', '2019111514303T'}

temp = length(SCANS);

matrix=zeros(matrixSize, matrixSize, temp);
%for i = 1:temp

%for i = 1:85
for i = 1:136
    dirname = strcat('sub-',SCANS(i,1), '_ses-', SCANS(i,2));
    %disp(dirname);
    matrix(:,:,i) = read_netcc(DATA_DIR, SCANS{i,1}, SCANS{i,2});
end

imgData=matrix;
%outname = strcat(DATA_DIR,'BD_TMS_Data',num2str(index),'-', date, '.mat');
outname = strcat(DATA_DIR,'BD_Only_TMS_Data',num2str(index),'-', date, '.mat');
disp(outname);
%save(outname, 'imgData');
outname = strcat(DATA_DIR,'BD_Only_TMS_Data',num2str(index),'-', date, '.csv');
%writematrix(imgData, outname);

%outname = strcat(DATA_DIR,'BD_TMS_SessionList',num2str(index),'-', date, '.xls');
outname = strcat(DATA_DIR,'BD_Only_TMS_SessionList',num2str(index),'-', date, '.xls');
disp(outname);

T = array2table(SCANS, 'VariableNames', {'Subject', 'Session'});
writetable(T, outname);

x = matrix;
end
