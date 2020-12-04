function x = makeConnectionList(infile, outprefix)

%Reads _arc.txt file created by makePajekFormat function and replaces
%numbers with region names

regionLabels = {'L Motor','R Motor','L SFG','R SFG','L SOFG','R SOFG','L MFG','R MFG','L MOFG','R MOFG','L Oper IFG','R Oper IFG','L Tri IFG','R Tri IFG','L IOFG','R IOFG','L Rolandic Oper','R Rolandic Oper','L SMA','R SMA','L Olfactory','R Olfactory','L Med SFG','R Med SFG','L Med OFC','R Med OFC','L Rectus','R Rectus','L Insula','R Insula','L ACG','R ACG','L MCG','R MCG','L PCG','R PCG','L Hippocampus','R Hippocampus', 'L ParaHippocampus','R ParaHippocampus','L Amygdala','R Amygdala','L Calcarine','R Calcarine','L Cuneus','R Cuneus','L Lingual','R Lingual','L SOG','R SOG','L MOG','R MOG','L IOG','R IOG','L Fusiform','R Fusiform','L Sensory','R Sensory','L SPG','R SPG','L IPG','R IPG','L SupraMarginal','R SupraMarginal','L Angular','R Angular','L Precuneus','R Precuneus','L Paracentral','R Paracentral','L Caudate','R Caudate','L Putamen','R Putamen','L Pallidum','R Pallidum','L Thalamus','R Thalamus','L Auditory','R Auditory','L STG','R STG','L Sup Temp Pole','R Sup Temp Pole','L MTG','R MTG','L Mid Temp Pole','R Mid Temp Pole','L ITG','R ITG','L Cerebelum Crus1','R Cerebelum Crus1','L Cerebelum Crus2','R Cerebelum Crus2','L Cerebelum 3','R Cerebelum 3','L Cerebelum 4&5','R Cerebelum 4&5','L Cerebelum 6','R Cerebelum 6','L Cerebelum 7b','R Cerebelum 7b','L Cerebelum 8','R Cerebelum 8','L Cerebelum 9','R Cerebelum 9','L Cerebelum 10','R Cerebelum 10','Vermis 1&2','Vermis 3','Vermis 4&5','Vermis 6','Vermis 7','Vermis 8','Vermis 9','Vermis 10'};
outfilename = strcat(outprefix, '_namedConnections.txt');
outfid = fopen(outfilename, 'w');
fid = fopen(infile);
tline = fgetl(fid);
while ischar(tline)
    %disp(tline)
    
    A = sscanf(tline, '%f');
    
    out = strcat(regionLabels{A(1)}, '-', regionLabels{A(2)}, ':', num2str(A(3)));
  
    fprintf(outfid, '%s\n', out); 
    tline = fgetl(fid);
end
fclose(fid);
fclose(outfid);




x = 1;
end