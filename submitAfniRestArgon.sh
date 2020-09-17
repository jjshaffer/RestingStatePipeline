#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Usage: runAfniRest.sh inputfMRI outputDir scanId subjectId"
  exit 1
fi

scriptDir=/Shared/MRRCdata/Bipolar_R01/scripts/RestingState

qsub -q PINC -pe smp 8 ${scriptDir}/runAfniRest.sh $1 $2 $3 $4


