#!/bin/bash

#This script generates a correlation matrix using the supplied atlas atlas in AFNI.
#Author: Joe Shaffer
#Date: March, 2017

rootdir=$1
subject=$2
session=$3
atlasfile=$4
atlas_name=$5

resultdir=${rootdir}/derivatives/AFNI_Rest/${subject}_${session}.results
infile=${resultdir}/errts.${subject}_${session}.fanaticor+tlrc

#Create the necessary output paths
mkdir -p ${rootdir}/derivatives/${atlas_name}_RESULTS
outdir=${rootdir}/derivatives/${atlas_name}_RESULTS/sub-${subject}_ses-${session}
mkdir -p $outdir
outfile=${outdir}/resampled_errts.sub-${subject}_ses-${session}.fanaticor

#Fit the preprocessed EPI data to the AAL atlas orientation
3dresample -master $atlasfile -prefix $outfile -inset $infile
echo "Resample Complete"

#calculate the correlation and z-score between each region and output as text file
3dNetCorr -prefix ${outdir}/corr_test_sub-${subject}_ses-${session} -fish_z -inset ${outfile}+tlrc -in_rois $atlasfile

echo "Network Correlations Complete"
