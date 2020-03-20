r4eta
=====

Container for R with libraries for LBNL Energy Technology Area project

* source:          https://github.com/tin6150/r4eta
* docker hub:      https://hub.docker.com/repository/docker/tin6150/r4eta
* singularity hub: https://singularity-hub.org/collections/4160

Docker build and run example
----------------------------

	docker build -t tin6150/r4eta -f Dockerfile .  | tee Dockerfile.monolithic.log

	docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/tmp/home  --user=$(id -u):$(id -g) tin6150/r4eta
	docker exec -it   distracted_keller  bash


Examples for using the singularity container
--------------------------------------------

Pull the container from the cloud:
	singularity pull --name myR shub://tin6150/r4eta


Run R interactively:
	./myR

Run R script, find out what version it is:
	singularity exec myR /usr/bin/Rscript --version


Run Rscript with a specific command specified on the command line [ library() ]:
	singularity exec myR /usr/bin/Rscript -e 'library()'


Run Rscript invoking a script file.   This is a bit more elaborate as the container need to map (bind) the file system in the outside to the inside of the container.  This example maps home dir from outside the container ($HOME) to a path inside the container (/tmp/home ), then run the script on the mapped dir (/tmp/home/helloWorld.R):
	singularity exec --bind  $HOME:/tmp/home  myR  /usr/bin/Rscript  /tmp/home/helloWorld.R 

Alternate example for mapping only the current dir on host to /mnt on the container.  Output is send to current dir on the host ( > output.txt):
	singularity exec --bind  .:/mnt  myR  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt
