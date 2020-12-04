function out = makePajekFormat(infile, index, prefix)
%This function takes in a matlab matrix and converts it into the text file
%format that is needed by Pajek for Louvain clustering.

file = load(infile);

%Load the stats matrix at index value
data = file.stats(:,:,index);

out = zeros(1,3);
counter = 1;
for i = 1:116
    for j = 1:116
        if(data(i,j) ~= 0 && i~=j)
            out(counter,1) = i;
            out(counter,2) = j;
            out(counter,3) = data(i,j);
            counter = counter+1;
            disp(counter);
        end
     end
end

outname = strcat(prefix, '_arc.txt');
dlmwrite(outname, out, ' ');

text1 = fileread('group_orig.net');


text2 = fileread(outname);
text2 = sprintf('\n%s', text2);
outname = strcat(prefix, '.net');
text3 = strcat(text1, text2);

dlmwrite(outname, text3, '');

outname = strcat(prefix, '.txt');
dlmwrite(outname, data, '\t');
copyfile(outname, strcat(prefix, '.edge'));


end