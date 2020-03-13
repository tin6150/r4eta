Bootstrap: docker
From: tin6150/r4eta

# Singularity def, wrap around docker tin6150/r4eta

%post
	touch "_ROOT_DIR_OF_CONTAINER_" ## also is "_CURRENT_DIR_CONTAINER_BUILD" 
	date     >> _ROOT_DIR_OF_CONTAINER_
	hostname >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2020.0313.1500" >> _ROOT_DIR_OF_CONTAINER_

	# docker run as root, but singularity may run as user, so adding these hacks here
	mkdir -p /global/scratch/tin
	mkdir -p /global/home/users/tin
	mkdir -p /home/tin
	mkdir -p /home/tmp
	mkdir -p /Downloads
	chown    43143 /global/scratch/tin
	chown    43143 /global/home/users/tin
	chown -R 43143 /home
	#chown -R 43143 /home/tin
	chown -R 43143 /opt
	chown -R 43143 /Downloads
	chmod 1777 /home/tmp

	# this is in Dockerfile now
	#Rscript --quiet -e 'library()' > R_library_list.out.txt.singularity 
    
%environment
	TZ=PST8PDT
	export TZ 

%labels
	BUILD = 2019_0313_1500
	MAINTAINER = tin_at_lbl_dot_gov
	REFERENCES = "https://github.com/tin6150/r4eta"

%runscript
    #TZ=PST8PDT /bin/tcsh
    #/bin/bash -i 
    #xx source /etc/bashrc && /Downloads/CMAQ/CMAQ-4.5-ADJ-LAJB_tutorial/code/CMAQ-4.5-ADJ-LAJB/./built_gcc_gfortran_serial_SAPRC99ROS/bin/CCTM/cctm
	#LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/conda/lib PATH=${PATH}:/opt/conda/bin /bin/bash -i
	R

	

%help
	R programming language env in a container, with many packages from CRAN
    
# Pull and run via singularity-hub:
# singularity pull shub://tin6150/r4eta
# singularity pull --name r4eta_b1219.sif shub://tin6150/r4eta
# singularity shell r4eta.sif

# manual build cmd (singularity 3.2): 
# sudo SINGULARITY_TMPDIR=/global/scratch/tin/tmp singularity build --sandbox ./r4eta.sif Singularity 2>&1  | tee singularity_build.log
# sudo SINGULARITY_TMPDIR=/dev/shm singularity build --sandbox ./r4eta.sif Singularity 2>&1  | tee singularity_build.log
#
# manual build cmd (singularity 2.6): 
# sudo /opt/singularity-2.6/bin/singularity build --writable r4eta_b1219a.img Singularity 2>&1  | tee singularity_build.log
#
# eg run cmd on bofh w/ singularity 2.6.2:
#      /opt/singularity-2.6/bin/singularity run     r4eta_b1219a.img
# sudo /opt/singularity-2.6/bin/singularity exec -w r4eta_b1219a.img /bin/tcsh

# eg run cmd on lrc, singularity 2.6-dist (maybe locally compiled)
#      singularity shell -w -B /global/scratch/tin ./r4eta_b1219a.img
#
# dirac1 has singularity singularity-3.2.1-1.el7.x86_64 

# vim: nosmartindent tabstop=4 noexpandtab shiftwidth=4
