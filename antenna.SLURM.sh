#!/bin/bash

## Job name:
#SBATCH --job-name=Antenna_test  #Name of the job
#
## Wall time limit:
#SBATCH --time=64:00:00
#
####Partition
#SBATCH -w cn-1
## Other parameters:
#SBATCH --cpus-per-task 10 #Number of cpus the job will use
#SBATCH --mem=84G             #Memory RAM
#SBATCH --nodes 1
#SBATCH -o slurm-%x_%j.out    #Standar output message
#SBATCH -e slurm-%x_%j.err    #Standar error message

######Everything below this are the job instructions######

echo "I am running on the NODE $SLURM_NODELIST"
echo "I am running with $SLURM_CPUS_ON_NODE cpus"
echo "Starting $SLURM_JOB_ID at"
date

module purge
module load MATLAB/2019b
matlab -nodisplay -nosplash -nodesktop -r IFALOOP, exit

echo "Ending $SLURM_JOB_ID at"
date