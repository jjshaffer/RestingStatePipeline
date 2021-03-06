#!/bin/bash

#Set the name of the job. This will be the first part of the error/output filename.

#$ -N RestingStatePipeline

#Set the shell that should be used to run the job.
#$ -S /bin/bash

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Select the queue to run in on Argon
#$ -q PINC

#Select the number of slots the job will use - this script tends to require >1 core to accommodate some high-ram requirements in FreeSurfer
#$ -pe smp 2 

#Print informationn from the job into the output file
#/bin/echo Here I am: `hostname`. Sleeping now at: `date`
#/bin/echo Running on host: `hostname`.
#/bin/echo In directory: `pwd`
#/bin/echo Starting on: `date`

#Send e-mail at beginning/end/suspension of job
#$ -m n

#E-mail address to send to
#$ -M joseph-shaffer@uiowa.edu

#Run as Array Job - set to match # of participants (may need to add an extra for sourcedata folder if using Xnat_downloader script)
#$ -t 85:91:1

#Do Stuff

#module load matlab/R2015a

#Set these variables for the appropriate project
PROJECT_PATH="/Shared/MRRCdata/Bipolar_R01"
DATA_DIRNAME="BD_R01_data"
atlasfile=./aal_MNI_V4_convert+tlrc
#atlasfile=./mergedFunctionalAtlas.nii.gz
atlas_name="AAL"
#atlas_name="FUNCATLAS"

cd ${PROJECT_PATH}/scripts/RestingStatePipeline

bash readBIDS_forFreesurfer.sh ${SGE_TASK_ID} ${PROJECT_PATH} ${DATA_DIRNAME} ${atlasfile} ${atlas_name}



