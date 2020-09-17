#!/bin/bash

#This script generates a correlation matrix using the AAL atlas in AFNI.

#Author: Joe Shaffer
#Date: March, 2017

rootdir=$1
subject=$2
session=$3


resultdir=${rootdir}/derivatives/AFNI_Rest/${subject}_${session}.results
infile=${resultdir}/errts.${subject}_${session}.fanaticor+tlrc

#resultdir=${rootdir}/derivatives/AFNI_Preprocess/${subject}.results
#infile=${resultdir}/errts.${subject}.fanaticor+tlrc

atlasfile=./aal_MNI_V4_convert+tlrc
#atlasfile=./mergedFunctionalAtlas.nii.gz

#echo ${atlasfile}

mkdir -p ${rootdir}/derivatives/AAL_RESULTS
outdir=${rootdir}/derivatives/AAL_RESULTS/sub-${subject}_ses-${session}

#mkdir -p ${rootdir}/derivatives/FUNCATLAS_RESULTS
#outdir=${rootdir}/derivatives/FUNCATLAS_RESULTS/sub-${subject}_ses-${session}

mkdir -p $outdir
outfile=${outdir}/resampled_errts.sub-${subject}_ses-${session}.fanaticor

#Fit the preprocessed EPI data to the AAL atlas orientation
3dresample -master $atlasfile -prefix $outfile -inset $infile

echo "Resample Complete"


#calculate the correlation and z-score between each region and output as text file
3dNetCorr -prefix ${outdir}/corr_test_sub-${subject}_ses-${session} -fish_z -inset ${outfile}+tlrc -in_rois $atlasfile

#may need to include +tldr as part of input here

echo "NetCorr Complete"
