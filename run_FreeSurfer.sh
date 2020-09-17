#!/bin/bash

#This script runs FreeSurfer on the anatomical T1 image in order to perform tissue type identification. 
#Author: Joe Shaffer
#Date: February, 2018
dir="$1"
outdir="$2"
subj="$3"
session1="$4"
scan1="$5"
scan2="$6"


echo "DataDir:" $dir
echo "Freesurfer:" $outdir
echo "Subject:" $subj
echo "Session:" $session1
echo "T1:" $scan1
echo "T2:" $scan2


export SUBJECTS_DIR=$outdir
#echo $SUBJECTS_DIR

#Check whether there is a T2 image. If not, run Freesurfer without T2 image
if [[ ${scan2} = "None" ]]; then
	recon-all -all -subject sub-${subj}_ses-${session1} -i $scan1
	#echo "not 3T1"

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}
	@SUMA_Make_Spec_FS -sid sub-${subj}_ses-${session1} -NIFTI

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}/SUMA
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_vent.nii \
              -expr 'amongst(a,4,43)'
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_WM.nii \
              -expr 'amongst(a,2,7,41,46,251,252,253,254,255)'

#Check whether this is the T1 for 31P imaging. If so, run Freesurfer without T2 image and name output differently
elif [[ ${scan2} = "31P" ]]; then
    #subject=sub-${subj}_ses-${session1}_31P
    #echo $subject
    recon-all -all -subject sub-${subj}_ses-${session1}_31P -i $scan1

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}_31P
	@SUMA_Make_Spec_FS -sid sub-${subj}_ses-${session1}_31P -NIFTI

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}_31P/SUMA
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_31P_vent.nii \
              -expr 'amongst(a,4,43)'
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_31P_WM.nii \
              -expr 'amongst(a,2,7,41,46,251,252,253,254,255)'

#Otherwise run Freesurfer with the T1 and T2 image
else
	recon-all -all -subject sub-${subj}_ses-${session1} -i $scan1 -T2 $scan2 -T2pial
	#echo "not 3T"

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}
	@SUMA_Make_Spec_FS -sid sub-${subj}_ses-${session1} -NIFTI

	cd $SUBJECTS_DIR/sub-${subj}_ses-${session1}/SUMA
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_vent.nii \
              -expr 'amongst(a,4,43)'
	3dcalc -a aparc+aseg.nii -datum byte -prefix sub-${subj}_ses-${session1}_WM.nii \
              -expr 'amongst(a,2,7,41,46,251,252,253,254,255)'

fi
