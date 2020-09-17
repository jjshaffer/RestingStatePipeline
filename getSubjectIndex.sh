#!/bin/bash

#Script for looping through all subjects in the data directory in order to identify their index number in case it is necessary to run resting-state analysis on a sub-set.
#There is a chance that the provided index may be off by one, depending on whether you're running this locally or using the cluster. Keep this in mind and double check when
# running the "readBids" script. 
#Author: Joe Shaffer
#Date December, 2019

BIDS_DIR="$1"

#Cluster Path
#SHARE_DIR=/Shared/MRRCdata
#Local Path
#SHARE_DIR=/Volumes/mrrcdata
#BIDS_DIR=${SHARE_DIR}/Bipolar_R01/BD_R01_data

#Find all subjects in BIDS_DIR & sessions
subjects=(${BIDS_DIR}/*/)
numsubjs=${#subjects[@]}
#echo $numsubjs

#Loop through each subject
for i in `seq 0 $(($numsubjs-1))`
do

  #echo ${subjects[$i]}
  subject=${subjects[$i]}

  #Trim / at end
  subject=${subject%*/}
  #echo $subject

  #Trim base file path
  subject=${subject##*/}
  #echo $subject

  if [[ $subject != "sourcedata" ]]; then

    #Trim everything preceding -
    subject=${subject#*-}

    echo ${i}:${subject}
  fi

done #subject
