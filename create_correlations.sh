#!/bin/bash

#This script generates a correlation matrix using the AAL atlas in AFNI.

#Author: Joe Shaffer
#Date: March, 2017

rootdir=$1
subject=$2
session=$3

echo $subject
echo $session


resultdir=${rootdir}/derivatives/AFNI_Rest/sub-${subject}_ses-${session}.results
infile=${resultdir}/errts.sub-${subject}_ses-${session}.fanaticor+tlrc

#resultdir=${rootdir}/derivatives/AFNI_Preprocess/${subject}.results
#infile=${resultdir}/errts.${subject}.fanaticor+tlrc

aalfile=./aal_MNI_V4_convert+tlrc
#aalfile=./resampled.HalkoMasks+tlrc

#echo ${aalfile}

mkdir -p ${rootdir}/derivatives/AAL_RESULTS
outdir=${rootdir}/derivatives/AAL_RESULTS/sub-${subject}_ses-${session}

#mkdir -p ${rootdir}/derivatives/HALKO_RESULTS
#outdir=${rootdir}/derivatives/HALKO_RESULTS/sub-${subject}_ses-${session}
mkdir -p $outdir
outfile=${outdir}/resampled_errts.sub-${subject}_ses-${session}.fanaticor

#Fit the preprocessed EPI data to the AAL atlas orientation
3dresample -master $aalfile -prefix $outfile -inset $infile

echo "Resample Complete"


#calculate the correlation and z-score between each region and output as text file
3dNetCorr -prefix ${outdir}/corr_test_sub-${subject}_ses-${session} -fish_z -inset ${outfile}+tlrc -in_rois $aalfile

#may need to include +tldr as part of input here

echo "NetCorr Complete"