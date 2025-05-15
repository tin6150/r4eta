#!/bin/bash

# install miniconda then jupyter notebook server
# ref: r4envids DIOS_demonstration

TZ="America/Los_Angeles" date

mkdir -p Downloads 
cd Downloads


wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh  
bash miniconda3.sh -b -p /opt/conda 
echo 'export PATH="${PATH}:/opt/conda/bin"'                       >> /etc/bashrc    
echo 'export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/conda/lib"' >> /etc/bashrc   

source /etc/bashrc # conda in /opt/conda/bin/conda
conda install -q -y -c conda-forge jupyterlab
# -q for quiet, reduced output
# -y for yes, avoid prompt to confirm


echo $?
TZ="America/Los_Angeles" date



#### https://stackoverflow.com/questions/57870575/install-and-run-r-kernel-for-jupyter-notebook
#### added 2023-02-16, untested inside container
#### instead of adding IRkernel in R
#### said can use conda
conda config --add channels r
conda install --yes r-irkernel
####  config on wombat wsl... R kernel avail, but can't run things, get error.  
####  didn't troubleshoot, Rstudio is lot less friction

