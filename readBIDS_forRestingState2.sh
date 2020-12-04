#!/bin/bash

i="$1"

#Cluster Path
SHARE_DIR=/Shared/MRRCdata

#Local Path
#SHARE_DIR=/Volumes/mrrcdata

PROJECT_DIR=${SHARE_DIR}/SCZ_TMS_TIMING

BIDS_DIR=${SHARE_DIR}/SCZ_TMS_TIMING/SCZ_TMS_data
FREESURFER_DIR=${SHARE_DIR}/SCZ_TMS_TIMING/derivatives/FreeSurfer



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
#Trim everything preceding -
subject=${subject#*-}

echo $subject
#echo ${subjects[$i]}

#Loop through each imaging session
sessions=(${subjects[$i]}*/)
numses=${#sessions[@]}
#echo $numses


postSes=0;

for x in `seq 0 $(($numses-1))`
do
#echo "x"${x}
session=${sessions[$x]}

#Trim / at end
session=${session%*/}
#Trim everything preceding -
session=${session##*-}
#echo "session_"${x}"_"${session}
#ses[$x]=$session
#echo "ses_"${ses[$x]}

if [[ $session > $postSes ]]
then
    postSes=$session

fi
done

#echo ${postSes}_post



#Create variables for storing scan info for each session

T1=()
T2=()
ses=()
rest=()
task=()
#rest=("", "", "")
#task=("","","","")



for x in `seq 0 $(($numses-1))`
do

T1[$x]="x"
T2[$x]="y"
ses[$x]=0

index0=$((3*$x))
index1=$((3*$x+1))
index2=$((3*$x+2))

rest[$index0]="a"
rest[$index1]="b"
rest[$index2]="c"

index0=$((4*$x))
index1=$((4*$x+1))
index2=$((4*$x+2))
index3=$((4*$x+3))

task[$index0]=""
task[$index1]=""
task[$index2]=""
task[$index3]=""

done



for j in `seq 0 $(($numses-1))`
do

#echo "j_"$j
#echo ${sessions[$j]}

session=${sessions[$j]}

#Trim / at end
session=${session%*/}
#Trim everything preceding -
session=${session##*-}
#echo $session


#Set session index
sessionIndex=0;
#if [[ $numses > 1 ]]
#then
   if [[ $session = $postSes ]]
   then
       #echo $session
       sessionIndex=1;
   fi
#fi
#echo $sessionIndex
ses[$sessionIndex]=$session

#echo "ses1_"${ses[0]}
#echo "ses2_"${ses[1]}
#Find anatomical files

#echo ${sessions[$j]}

files=(${sessions[$j]}anat/*)
numfiles=${#files[@]}
#echo $numfiles


for k in `seq 0 $(($numfiles-1))`
do

filepath=${files[$k]}
file=$(basename $filepath)
#echo $file

if [[ $file == *"T1w.nii.gz" ]]; then
#echo $filepath
    T1[$j]=$filepath
fi

if [[ $file == *"T2w.nii.gz" ]]; then
#echo $filepath
    T2[$j]=$filepath
fi

done #files

#Correct folder naming if necessary
if [ -d ${sessions[$j]}fmri ]
then
    mv ${sessions[$j]}fmri ${sessions[$j]}func
fi

#Get list of files in the func folder
files=(${sessions[$j]}func/*)
numfiles=${#files[@]}
#echo $numfiles
#echo $files



#Loop through each functional file
for k in `seq 0 $(($numfiles-1))`
do
filepath=${files[$k]}
file=$(basename $filepath)
#echo $file

#Use pu reconstruction if available
if [[ $file == *"task-rest"*"bold.nii.gz" ]];
then
echo ${file}_rest

    if [[ $file == *"run-1"*.nii.gz ]];
    then
        rest[$(($sessionIndex*3))]=$file

    elif [[ $file == *"run-2"*.nii.gz ]];
    then
        rest[$(($sessionIndex*3+1))]=$file
    elif [[ $file == *"run-3"*.nii.gz ]];
    then
        rest[$(($sessionIndex*3+2))]=$file

    fi

#echo ${rest[$sessionIndex,0]}
#echo ${rest[$sessionIndex,1]}
#echo ${rest[$sessionIndex,2]}


elif [[ $file == *"task-timing"*"bold.nii.gz" ]];
then
#echo ${file}_task
    if [[ $file == *"run-1"*.nii.gz ]];
    then
        task[$sessionIndex,0]=$file
    elif [[ $file == *"run-2"*.nii.gz ]];
    then
        task[$sessionIndex,1]=$file
    elif [[ $file == *"run-3"*.nii.gz ]];
    then
        task[$sessionIndex,2]=$file
    elif [[ $file == *"run-4"*.nii.gz ]];
    then
        task[$sessionIndex,3]=$file
    fi
fi
done #Loop through each file


#echo ${rest[$sessionIndex,0]}
#echo ${rest[$sessionIndex,1]}
#echo ${rest[$sessionIndex,2]}



done #session

if [[ ${ses[0]} == "0" ]];
then
echo "Single Session"

t1=$(basename ${T1[0]})
t1=${t1%%.*}
echo T1: $t1
t2=$(basename ${T2[0]})
t2=${t2%%.*}
echo T2: $t2

#Run Freesurfer analysis
bash run_FreeSurfer_singleSession.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[1]} ${ses[1]} $t1 $t2
else

#Extra code for dealing with lack of T2 image in first session and T1 in second session.

t1=$(basename ${T1[0]})
t1=${t1%%.*}
echo T1: $t1
t2=$(basename ${T2[1]})
t2=${t2%%.*}
echo T2: $t2

#done

#Run Freesurfer analysis
bash run_FreeSurfer.sh ${BIDS_DIR} ${FREESURFER_DIR} ${subject} ${ses[0]} ${ses[1]} $t1 $t2
fi

echo "Freesurfer Complete"

session_it=$(($numses-1))

if [[ ${numses} == 1 ]];
then
    session_it=$numses
fi
#echo $session_it

for j in `seq 0 $session_it`
do
#echo ${ses[$j]}

rest0=${rest[$(($j*3))]}
rest1=${rest[$(($j*3+1))]}
rest2=${rest[$(($j*3+2))]}

if [[ ${rest0} == "a" ]];
   then
       echo "No second session"

else
    echo "Processing Resting State"
    echo $rest0
    echo $rest1
    echo $rest2
    ## Run AFNI Processing Steps on resting-state run
    tcsh run_afni_proc_rest.sh ${PROJECT_DIR} SCZ_TMS_data ${subject} ${ses[$j]} $rest0 $rest1 $rest2
     #tcsh run_afni_proc_rest_2runs.sh ${PROJECT_DIR} SCZ_TMS_data ${subject} ${ses[$j]} $rest0 $rest1

    #tcsh run_afni_proc_rest_1run.sh ${PROJECT_DIR} SCZ_TMS_data ${subject} ${ses[$j]} $rest0
     
##Resample Resting State to MNI Atlas and generate correlation matrices
bash create_correlations.sh ${PROJECT_DIR} ${subject} ${ses[$j]}

fi
       
done

#done #subject
