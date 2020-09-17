%Function for performing mixed effects modeling and performing error-handling that allows RestingStateContrast.m to test whether the model converged
%Author: Joe Shaffer
%Date: June 2017
function x = testVoxel(dataTab, model1)

    warning('off', 'all');
   
    test = 0;
 
    try
        lme = fitlme(dataTab, model1);
        
    catch Mexep
        test = -1;
        msgText = getReport(Mexep)
        disp(msgText);
    end
    
    if (test==0)
        x = lme;
        %filename = strcat(int2str(i), '_', int2str(j), '_', int2str(k), '_LME', int2str(n), '.mat');
        %save(filename, 'lme', '-v7.3');
      
    else
         x = [];
    end
    
end
