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
#$ -pe smp 2

#Print informationn from the job into the output file
#/bin/echo Here I am: `hostname`. Sleeping now at: `date`
#/bin/echo Running on host: `hostname`.
#/bin/echo In directory: `pwd`
#/bin/echo Starting on: `date`

#Send e-mail at beginning/end/suspension of job
#$ -m n

#E-mail address to send to
#$ -M email@uiowa.edu

#Run as Array Job
#$ -t 1:60:1

#Do Stuff

cd /Shared/MRRCdata/SCZ_TMS_TIMING/scripts/RestPipeline
bash readBIDS_forRestingState2.sh $(($SGE_TASK_ID-1))



