#!/bin/bash
## Job name:
#SBATCH --job-name=Ansim #Name of the job
#
## Wall time limit:
#SBATCH --time=24:00:00
#
####Partition
#SBATCH --partition smallmem
## Other parameters:
#SBATCH --cpus-per-task 16 #Number of cpus the job will use
#SBATCH --mem=64G #Memory RAM
#SBATCH --nodes 1
#SBATCH -o logs/slurm-%x_%j.out    #Standar output message
#SBATCH -e logs/slurm-%x_%j.err    #Standar error message

######Everything below this are the job instructions######
echo "Pulling repo"
git pull
echo "I am running on the NODE $SLURM_NODELIST"
echo "I am running with $SLURM_CPUS_ON_NODE cpus"
echo "Starting $SLURM_JOB_ID at"
date
echo "Loading modules"
module purge
module load MATLAB/2023b
echo "Module Loaded"
echo "Starting Matlab"
timestamp=$(date +"%Y_%m_%d_%H_%M_%S")
matlab -noFigureWindows -nosplash -nodesktop -r OPTIMIZEANTENNASCRIPT | tee logs/$timestamp_matlab-.out
echo "Ending $SLURM_JOB_ID at"
date