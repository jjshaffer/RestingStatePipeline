#!/bin/bash

#Script for reading through the data directory, identifying imaging data within that folder, and running Freesurfer, functional connectivity, and fALFF analyses on the data. 
#Author Joe Shaffer
#Date June 2019

#Get iterator value to allow for parallel computing. This script will run for the ith individual in the data folder. Also get file paths for data input.
i="$1"
SHARE_DIR="$2" #Root of the 
DATA_DIRNAME="$3"
atlasfile="$4"
atlas_name="$5"

#Cluster Path
#SHARE_DIR=/Shared/MRRCdata/Bipolar_R01
#Local Path
#SHARE_DIR=/Volumes/mrrcdata/Bipolar_R01


BIDS_DIR=${SHARE_DIR}/${DATA_DIRNAME} #Directory of BIDS-formatted imaging data
FREESURFER_DIR=${SHARE_DIR}/derivatives/FreeSurfer #Directory for output of FreeSurfer analysis



#Find all subjects in BIDS_DIR & sessions
subjects=(${BIDS_DIR}/*/)
numsubjs=${#subjects[@]}
#echo $numsubjs


#Loop through each subject - legacy function
#for i in `seq 0 $(($numsubjs-1))`
#for i in `seq 0 0`
#do

#Identify which subject this instance will be
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

    #Loop through each imaging session
    sessions=(${subjects[$i]}*/)
    numses=${#sessions[@]}
    #echo $numses

    #Create empty arrays to store images for each session
    T1=()
    T1m=()
    T2=()
    ses=()

    #Initialize each array with "None"
    for x in `seq 0 $(($numses-1))`
    do
        T1[$x]="None"
        T1m[$x]="None"
        T2[$x]="None"
        ses[$x]=0
    done



    for j in `seq 0 $(($numses-1))`
    do
        #echo ${sessions[$j]}
        session=${sessions[$j]}

        #Trim / at end
        session=${session%*/}



        #Trim everything preceding -
        session=${session##*-}
        echo $session
        ses[$j]=$session

        #Get list of files in the anatomy folder
        files=(${sessions[$j]}anat/*)
        numfiles=${#files[@]}
        #echo $numfiles

        #Loop through each anatomy file
        for k in `seq 0 $(($numfiles-1))`
        do

            filepath=${files[$k]}
            file=$(basename $filepath)
            #echo $file
            #Identify T1 image from the 31P spectroscopy in 7T session
            if [[ $file == *"For31P_T1w.nii.gz" ]]
            then

                T1m[$j]=$filepath
            #Identify the T1 image from the session
            elif [[ $file == *"T1w.nii.gz" ]]
            then
                #echo $filepath
                T1[$j]=$filepath

            #Identify the T2 image from the session
            elif [[ $file == *"T2w.nii.gz" ]]
            then
                    #echo $filepath
                    T2[$j]=$filepath
            fi

        done #files

        #echo $j
        #Check whether a T1 and T2 image are present.
        if [[ ${T1[$j]} != "None" ]]
        then
            if [[ ${T2[$j]} != "None" ]]
            then
                echo ${T1[$j]}
                echo ${T2[$j]}
                #If both T1 and T2 image, run Freesurfer with both T1 and T2 image
                bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1[$j]} ${T2[$j]}
            else
                echo ${T1[$j]}
                #If only T1 image, run Freesurfer without T2
                bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1[$j]} None
            fi
        else
            #If there is no T1 image, Freesurfer cannot run
            echo "No T1 Image"
        fi

        #Run Freesurfer on the T1 image that's matched to the 31P spectroscopy. 
        if [[ ${T1m[$j]} != "None" ]]
        then
            echo ${T1m[$j]}
            bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1m[$j]} 31P
        fi

        #If data is from 3T session
        if [[ ${session} == *3T ]];
        then
            echo ${session}_Func
            echo ${sessions[$j]}
            
            #If there is a /func directory
            if [ -d ${sessions[$j]}func ];
            then
                echo ${sessions[$j]}func
            #If the directory is instead named /fmri
            elif [ -d ${sessions[$j]}fmri ];
            then
                echo ${sessions[$j]}fmri
                #Correct error in naming by moving files from "fmri" folder to "func" folder
                mv ${sessions[$j]}fmri ${sessions[$j]}func
            fi

            #Get list of files in the func folder
            files=(${sessions[$j]}func/*)
            numfiles=${#files[@]}
            #echo $numfiles
            #echo $files

            funcfile=""

            #Loop through each functional file
            for k in `seq 0 $(($numfiles-1))`
            do
                filepath=${files[$k]}
                file=$(basename $filepath)
                #echo $file

                #Use pu reconstruction if available
                if [[ $file == *"task-rest"*"pu_bold.nii.gz" ]];
                then
                    #echo ${file}_test
                    funcfile=$filepath
                elif [[ $file == *"task-rest"*"bold.nii.gz" ]];
                then
                    #echo ${file}_bad
                    if [[ $funcfile == "" ]];
                    then
                        funcfile=$filepath
                    fi
                fi
            done #Loop through each file

            echo $funcfile

            ## Run AFNI to calculate fALFF
            tcsh run_afni_proc_fALFF.sh ${SHARE_DIR} ${DATA_DIRNAME} ${subject} ${ses[$j]} $funcfile

            ## Run AFNI Processing Steps on resting-state run
            tcsh run_afni_proc_rest.sh ${SHARE_DIR} ${DATA_DIRNAME} ${subject} ${ses[$j]} $funcfile

            ##Resample Resting State to MNI Atlas and generate correlation matrices
            bash create_correlations.sh ${SHARE_DIR} ${subject} ${ses[$j]} ${atlasfile} ${atlas_name}

        fi #3T
    done #session
fi

#done #subject
