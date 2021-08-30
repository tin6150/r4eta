Bootstrap: docker
From: tin6150/r4eta

# vim: nosmartindent tabstop=4 noexpandtab shiftwidth=4

# Singularity def, wrap around docker tin6150/r4eta

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


%post
	touch "_ROOT_DIR_OF_CONTAINER_" ## also is "_CURRENT_DIR_CONTAINER_BUILD" 
	date     >> _ROOT_DIR_OF_CONTAINER_
	hostname >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2020.0908.1717 HelloWorld" >> _ROOT_DIR_OF_CONTAINER_
	echo "Singularity def 2021.0829.0822 HelloWorld" >> _ROOT_DIR_OF_CONTAINER_

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

    
%environment
	TZ=PST8PDT
	export TZ 

%labels
	#BUILD = 2020_0908_1717_helloWorld
	BUILD = 2021_0829_0822_foreach_doSNOW
	MAINTAINER = tin_at_lbl_dot_gov
	REFERENCES = "https://github.com/tin6150/r4eta"

%runscript
    #/bin/bash -i 
	R

	
## help is displayed by `singularity run-help ./myR`

%help
	R programming language env in a container, with many packages from CRAN
	Example run:
	Pull and run via singularity-hub:
	singularity pull --name myR shub://tin6150/r4eta
	./myR
	singularity exec myR /usr/bin/Rscript -e 'library()'
	singularity exec --bind  .:/mnt  myR  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt
    Where helloWorld.R is in your current dir (on the host system)
	See README.rst for additional details.
	source:          https://github.com/tin6150/r4eta
	docker hub:      https://hub.docker.com/repository/docker/tin6150/r4eta
	singularity hub: https://singularity-hub.org/collections/4160

