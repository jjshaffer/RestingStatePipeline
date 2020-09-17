#!/bin/bash

#Set the name of the job. This will be the first part of the error/output filename.

#$ -N Rest_Regression

#Set the shell that should be used to run the job.
#$ -S /bin/bash

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Select the queue to run in
#$ -q PINC

#Select the number of slots the job will use
#$ -pe smp 2 

#Print informationn from the job into the output file
#/bin/echo Here I am: `hostname`. Sleeping now at: `date`
#/bin/echo Running on host: `hostname`.
#/bin/echo In directory: `pwd`
#/bin/echo Starting on: `date`

#Send e-mail at beginning/end/suspension of job
#$ -m n

#E-mail address to send to
#$ -M emailAddress@uiowa.edu

#Run as Array Job
#$ -t 1:1:1

#Do Stuff

module load matlab/2018a

#Set variables depending on research study
PROJECT_PATH="/Shared/MRRCdata/Bipolar_R01"
CovarFile='BD_TMS_SessionList-28-Jul-2020.txt'
DataFile='BD_AAL_Data-28-Jul-2020.mat'
OutPrefix='BDvHC'
NullModel='BOLD~Age+Male+(1|SUBJID)'
ExpModel='BOLD~BD+Age+Male+(1|SUBJID)'
ExpVar='BD'

cd ${PROJECT_PATH}/scripts/RestingStatePipeline/RegressionAnalysis

matlab -nodesktop -nosplash -r "RestingStateContrast(${CovarFile}, ${DataFile}, ${OutPrefix}, ${NullModel}, ${ExpModel}, ${ExpVar});quit;"




