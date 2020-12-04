#!/bin/bash

#Set the name of the job. This will be the first part of the error/output filename.

#$ -N SCZ_REST

#Set the shell that should be used to run the job.
#$ -S /bin/bash

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Select the queue to run in
#$ -q PINC

#Select the number of slots the job will use
#$ -pe smp 1

#Print informationn from the job into the output file
#/bin/echo Here I am: `hostname`. Sleeping now at: `date`
#/bin/echo Running on host: `hostname`.
#/bin/echo In directory: `pwd`
#/bin/echo Starting on: `date`

#Send e-mail at beginning/end/suspension of job
#$ -m n

#E-mail address to send to
#$ -M joseph-shaffer@uiowa.edu

#Run as Array Job
#$ -t 1:116:1

#Do Stuff

module load matlab/2018a

#cd /Shared/MRRCdata/BD_TMS_TIMING/scripts/BIDS

#bash runIterative_generateBIDSstructure.sh $(($SGE_TASK_ID+6))
#bash runIterative_generateBIDSstructure.sh $(($SGE_TASK_ID+7))

#matlab -nodesktop -nosplash -r "createScanTSV;quit;"



cd /Shared/MRRCdata/SCZ_TMS_TIMING/scripts/RestPipeline/RegressionAnalysis
#bash readBIDS_forRestingState.sh $(($SGE_TASK_ID-1))
matlab -nodesktop -nosplash -r "RestingStateAnalysis($SGE_TASK_ID);quit;"



