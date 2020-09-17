%Function for performing mixed effects modeling and performing error-handling that allows RestingStateContrast.m to test whether the model converged
%Author: Joe Shaffer
%Date: June 2017
function x = testVoxel(dataTab, model1)

    %Silence warnings since this typically runs on the cluster
    warning('off', 'all');
    %Initialize test variable to 0
    test = 0;
 
    %Perform Mixed Effects modeling
    try
        lme = fitlme(dataTab, model1);
        
    catch Mexep
        test = -1;
        msgText = getReport(Mexep)
        disp(msgText);
    end
    
    #If Model fitting succeeds, return the model
    if (test==0)
        x = lme;
        %filename = strcat(int2str(i), '_', int2str(j), '_', int2str(k), '_LME', int2str(n), '.mat');
        %save(filename, 'lme', '-v7.3');
    #If model fitting fails, return null
    else
         x = [];
    end
    
end
