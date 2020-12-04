#!/usr/bin/env tcsh

#This script will run preprocessing using AFNI. It uses the NIFTI formatted images along with the output of FreeSurfer
#Author: Joe Shaffer
#Date: March, 2017
# created by uber_subject.py: version 0.37 (April 14, 2015)
# creation date: Fri Oct  7 15:05:42 2016

set rootdir=$1
set datadir=$2
set subject=$3
set session=$4
set epi_file1=$5
set epi_file2=$6
#set epi_file3=$7


set currdir=`pwd`

echo "rootdir: "$rootdir
echo "Subject: "$subject
echo "Session: "$session


# set data directories
set epi_dir=${rootdir}/${datadir}/sub-${subject}/ses-${session}/func
set anat_dir=${rootdir}/derivatives/FreeSurfer/sub-${subject}_ses-${session}/SUMA
#set epi_dir   = ${top_dir}



# set subject and group identifiers
set subj=sub-${subject}_ses-${session}
set group_id=bd

mkdir -p ${rootdir}/derivatives/AFNI_Rest
cd ${rootdir}/derivatives/AFNI_Rest


#Check to see whether functional images exist
#set epi_file=${epi_dir}/${subject}_${session}_task-rest_rec-pu_bold.nii.gz

#if ( -f $epi_file1 ) then
#set tmp="x"

#else
#set epi_file=${epi_dir}/${subject}_${session}_task-rest_bold.nii.gz
#if ( -f $epi_file ) then
#set tmp="x"

#else
#echo "No functional image for $subject_$session"

#endif
#endif
    
#Generate Script for running analysis
    afni_proc.py -subj_id sub-${subject}_ses-${session}                                    \
        -blocks despike tshift align tlrc volreg blur mask regress \
	-copy_anat $anat_dir/sub-${subject}_ses-${session}_SurfVol.nii                \
	-anat_follower_ROI aaseg anat $anat_dir/aparc.a2009s+aseg.nii   \
       -anat_follower_ROI aeseg epi  $anat_dir/aparc.a2009s+aseg.nii   \
	-anat_follower_ROI FSvent epi $anat_dir/sub-${subject}_ses-${session}_vent.nii     \
        -anat_follower_ROI FSWe epi $anat_dir/sub-${subject}_ses-${session}_WM.nii         \
-dsets ${epi_dir}/${epi_file1} ${epi_dir}/${epi_file2} \
	    -tcat_remove_first_trs 0                                   \
        -tlrc_base MNI_avg152T1+tlrc                               \
        -tlrc_NL_warp                                              \
        -volreg_align_to MIN_OUTLIER                               \
        -volreg_align_e2a                                          \
        -volreg_tlrc_warp                                          \
        -regress_ROI_PC FSvent 3                                   \
        -regress_make_corr_vols aeseg FSvent                       \
        -regress_anaticor_fast                                     \
        -regress_anaticor_label FSWe                               \
        -regress_censor_motion 0.5                                 \
        -regress_censor_outliers 0.1                               \
        -regress_apply_mot_types demean deriv                      \
        -regress_est_blur_epits                                    \
        -regress_est_blur_errts                                    \
        -regress_run_clustsim no
#Usually use motion censor of 0.3, but up to 0.4 to process subject 0011
#Run Analysis
tcsh proc.sub-${subject}_ses-${session}

cd $currdir
