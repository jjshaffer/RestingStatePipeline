function out = makeBrainNetFormat(infile, prefix, numClusters, matrixFile, index)

nodes = readtable('aal_centroid116_all.node.txt');

filename = strcat(infile, '.txt');
copyfile(infile, filename);

clusters = readtable(filename);

[a, b] = size(nodes);

edges = table(nodes{:,1}, nodes{:,2}, nodes{:,3}, clusters{:,1}, nodes{:,5}, nodes{:,6});

outname = strcat(prefix, '.txt');
writetable(edges, outname,'Delimiter','\t', 'WriteVariableNames', false);
copyfile(outname, strcat(prefix, '.node'));

%Create Edge File

file = load(matrixFile);
data = file.stats(:,:,index);
outname = strcat(prefix, '.txt');
dlmwrite(outname, data, '\t');
copyfile(outname, strcat(prefix, '.edge'));


%Divide Files into clusters

m = max(clusters{:,1});
ed = [1:m+1];
[n, e]= histcounts(clusters{:,1}, ed);

for i=1:numClusters
[M, I] = max(n);



clusterList = zeros(M,1);
count = 1;
    for j = 1:116
        if(edges{j,4}==I)
            clusterList(count,1) = j;
            count = count + 1;
        end
    end

    %Create node file for each cluster
    cluster = table(nodes{clusterList,1}, nodes{clusterList,2}, nodes{clusterList,3}, clusters{clusterList,1}, nodes{clusterList,5}, nodes{clusterList,6});
    outname = strcat(prefix, '_cluster', int2str(i),'.txt');
    writetable(cluster, outname,'Delimiter','\t', 'WriteVariableNames', false);
    copyfile(outname, strcat(prefix, '_cluster', int2str(i),'.node'));
    
    %Create edge file for each cluster
    
    newEdge = zeros(M,M);
    
    for x = 1:M
        disp(int2str(x));
        for y = 1:M
            newEdge(x,y) = data(clusterList(x), clusterList(y));
        end
    end
    
    outname = strcat(prefix,'_cluster', int2str(i), '.txt');
    dlmwrite(outname, newEdge, '\t');
    copyfile(outname, strcat(prefix,'_cluster', int2str(i), '.edge'));
    
n(I) = 0;
end

out = edges;

end