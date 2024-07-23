#!/bin/bash

# Check if the number of jobs is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <number_of_jobs>"
  exit 1
fi

# Number of jobs to submit
num_jobs=$1

# Submit the first job and get its job ID
job_id=$(sbatch leeds.job | awk '{print $4}')
echo "Submitted job 1 with job ID $job_id"

# Loop to submit the remaining jobs with dependencies
for ((i=2; i<=num_jobs; i++))
do
    job_id=$(sbatch --dependency=afterany:$job_id leeds.job | awk '{print $4}')
    echo "Submitted job $i with job ID $job_id"
done
