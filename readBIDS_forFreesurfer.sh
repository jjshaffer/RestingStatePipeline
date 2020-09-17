#!/bin/bash

i="$1"

#Cluster Path
SHARE_DIR=/Shared/MRRCdata

#Local Path
#SHARE_DIR=/Volumes/mrrcdata


BIDS_DIR=${SHARE_DIR}/Bipolar_R01/BD_R01_data
FREESURFER_DIR=${SHARE_DIR}/Bipolar_R01/derivatives/FreeSurfer



#Find all subjects in BIDS_DIR & sessions
subjects=(${BIDS_DIR}/*/)
numsubjs=${#subjects[@]}
#echo $numsubjs


#Loop through each subject
#for i in `seq 0 $(($numsubjs-1))`
#for i in `seq 0 0`
#do

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


T1=()
T1m=()
T2=()
ses=()

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

if [[ $file == *"For31P_T1w.nii.gz" ]]
then

    T1m[$j]=$filepath

elif [[ $file == *"T1w.nii.gz" ]]
then
    #echo $filepath
    T1[$j]=$filepath

elif [[ $file == *"T2w.nii.gz" ]]
then
    #echo $filepath
    T2[$j]=$filepath
fi

done #files

#echo $j
if [[ ${T1[$j]} != "None" ]]
then
    if [[ ${T2[$j]} != "None" ]]
    then
        echo ${T1[$j]}
        echo ${T2[$j]}
##bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1[$j]} ${T2[$j]}
    else
        echo ${T1[$j]}
##bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1[$j]} None
    fi
else
    echo "No T1 Image"
fi

if [[ ${T1m[$j]} != "None" ]]
then
    echo ${T1m[$j]}
##bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[$j]} ${T1m[$j]} 31P
fi


if [[ ${session} == *3T ]];
then
    echo ${session}_Func
    echo ${sessions[$j]}

    if [ -d ${sessions[$j]}func ];
    then

        echo ${sessions[$j]}func

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
        if [[ $file == *"pu_bold.nii.gz" ]];
        then
            #echo ${file}_test
            funcfile=$filepath
        elif [[ $file == *"bold.nii.gz" ]];
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
tcsh run_afni_proc_fALFF.sh ${SHARE_DIR}/Bipolar_R01 BD_R01_data ${subject} ${ses[$j]} $funcfile

    ## Run AFNI Processing Steps on resting-state run
tcsh run_afni_proc_rest.sh ${SHARE_DIR}/Bipolar_R01 BD_R01_data ${subject} ${ses[$j]} $funcfile


    ##Resample Resting State to MNI Atlas and generate correlation matrices
  bash create_correlations.sh ${SHARE_DIR}/Bipolar_R01 ${subject} ${ses[$j]}

fi





done #session

fi

#done #subject
