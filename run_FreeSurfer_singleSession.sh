#!/bin/bash

#This script runs FreeSurfer on the anatomical T1 image in order to perform tissue type identification. 
#Author: Joe Shaffer
#Date: February, 2018
dir="$1"
outdir="$2"
subj="$3"
session1="$4"
session2="$5"
scan1="$6"
scan2="$7"


echo "DataDir:" $dir
echo "Freesurfer:" $outdir
echo "Subject:" $subj
echo "Session 1:" $session1
echo "Session 2:" $session2

echo "T1:" $scan1
echo "T2:" $scan2

#cd $dir/$subj/Analysis
#SERIES=($(find * -type d -name "*" -print -maxdepth 1))

T1=$dir/sub-${subj}/ses-${session1}/anat/${scan1}.nii.gz
T2=$dir/sub-${subj}/ses-${session2}/anat/${scan2}.nii.gz

#T1a=$dir/sub-${subj}/ses-${session1}/anat/${scan1}.nii.gz
#T1b=$dir/sub-${subj}/ses-${session2}/anat/${scan1}.aligned.nii.gz
#T2a=$dir/sub-${subj}/ses-${session1}/anat/${scan2}.aligned.nii.gz
#T2b=$dir/sub-${subj}/ses-${session2}/anat/${scan2}.nii.gz



#echo $T1a
#echo $T2a
#echo $T1b
#echo $T2b

#3dAllineate -base $T1 -input $T2 -prefix $T2a -1Dmatrix_save $dir/sub-${subj}/ses-${session1}/anat/ses2to1transform
#3dAllineate -base $T2 -input $T1 -prefix $T1b -1Dmatrix_save $dir/sub-${subj}/ses-${session2}/anat/ses1to2transform

export SUBJECTS_DIR=$outdir
echo $SUBJECTS_DIR

if [[ $scan2 == 'y' ]]
then
    echo "No T2"
    recon-all -all -subject sub-${subj}_ses-${session1} -i $T1

else
    echo "Run with T2"
    recon-all -all -subject sub-${subj}_ses-${session1} -i $T1 -T2 $T2 -T2pial
fi

cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}
@SUMA_Make_Spec_FS -sid sub-${subj}_ses-${session1} -NIFTI

cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}/SUMA
3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_vent.nii \
              -expr 'amongst(a,4,43)'
3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_WM.nii \
              -expr 'amongst(a,2,7,41,46,251,252,253,254,255)'


#cd $SUBJECTS_DIR/sub-${subj}_ses-${session2}
#@SUMA_Make_Spec_FS -sid sub-${subj}_ses-${session2} -NIFTI

#cd $SUBJECTS_DIR/sub-${subj}_ses-${session2}/SUMA
#3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session2}_vent.nii \
#-expr 'amongst(a,4,43)'
#3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session2}_WM.nii \
#-expr 'amongst(a,2,7,41,46,251,252,253,254,255)'
