r4eta
=====

Container for R with libraries for LBNL Energy Technology Area project

* source:          https://github.com/tin6150/r4eta
* docker hub:      https://hub.docker.com/repository/docker/tin6150/r4eta
* singularity hub: https://singularity-hub.org/collections/4160


container sizes
----

myR has rstudio binary, but  w/o Qt: 1.7G in singularity
myR with Qt Libs needed by rstudio:  1.9G in singularity
docker last layer only:
tin6150/r4eta            latest              dd66fe981035        43 hours ago        4.89GB
in docker, largest layer about 1.7 GB?


Examples for using the singularity container
--------------------------------------------

Pull the container from the cloud ::
	singularity pull --name myR shub://tin6150/r4eta


Run R interactively ::
	./myR
  q() # exit R and container session.

Run rstudio interactively ::
	singularity exec myR  rstudio
  -or-
	singularity exec shub://tin6150/r4eta rstudio


Interact with the container, run bash, R, Rscript INSIDE the container ::
	singularity exec  myR  bash
	ls # current working directory should be bind mounted
	R  # run R interactively, use q() to quit, return back to shell INSIDE the container
  Rscript helloWorld.R  # invoke an R script
	exit # exit the container, return to host prompt


Run R script in "batch mode", find out what version it is ::
	singularity exec myR /usr/bin/Rscript --version


Run Rscript with a specific command specified on the command line [ library() ] ::
	singularity exec myR /usr/bin/Rscript -e 'library()'


Run Rscript invoking a script file.   This is a bit more elaborate as the container need to map (bind) the file system in the outside to the inside of the container.  This example maps home dir from outside the container ($HOME) to a path inside the container (/tmp/home ), then run the script on the mapped dir (/tmp/home/helloWorld.R) ::
	singularity exec --bind  $HOME:/tmp/home  myR  /usr/bin/Rscript  /tmp/home/helloWorld.R 

Alternate example for mapping only the current dir on host to /mnt on the container.  Output is send to current dir on the host ( > output.txt) ::
	singularity exec --bind  .:/mnt  myR  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt



Docker build, run and troubleshoot example
------------------------------------------

	docker build -t tin6150/r4eta -f Dockerfile .  | tee Dockerfile.monolithic.log

	docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/tmp/home  --user=$(id -u):$(id -g) tin6150/r4eta
	docker run  -it --entrypoint /usr/bin/Rscript -v $HOME:/tmp/home  --user=$(id -u):$(id -g) tin6150/r4eta
	docker run  -it --entrypoint /bin/bash  --user=$(id -u):$(id -g) tin6150/r4eta
	docker exec -it boring_home  bash


rstudio Qt GUI via docker
-------------------------

Singularity is actually a lot more straightforward in this regard (see above), since everything is run as a user process without uid change.  Docker needs to map a number of environments before a GUI can be run:

  xhost +
	docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.xauth -v $HOME:/tmp/home  --entrypoint rstudio tin6150/r4eta

need to run rstudio with root, so can't use the --user=$(id -u) cuz it needs to a web server...



Troubleshooting if GUI doesn't lauch:
  
Instead of rstudio, can execute xterm or qterminal 
as a lighter test to check whether X11 is working for the container.  
The capabilities() function in R should report X11 as TRUE.
Running `xhost +` on the host may help.
Change :0 to whatever DISPLAY session you maybe using, or omit it altogether.

  XSOCK=/tmp/.X11-unix && XAUTH=/tmp/.docker.xauth && xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge - && docker run  -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH  -e DISPLAY=$DISPLAY --rm -it  tin6150/r4eta  R -e "capabilities()"

should produce output like:

	> capabilities()
				 jpeg         png        tiff       tcltk         X11        aqua 
				 TRUE        TRUE        TRUE        TRUE        TRUE       FALSE 
		 http/ftp     sockets      libxml        fifo      cledit       iconv 
				 TRUE        TRUE        TRUE        TRUE       FALSE        TRUE 
					NLS     profmem       cairo         ICU long.double     libcurl 
				 TRUE        TRUE        TRUE        TRUE        TRUE        TRUE 

	docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/tmp/home  --user=$(id -u):$(id -g)  -p 8787:8787 -e PASSWORD=yourpasswordhere   --entrypoint rstudio tin6150/r4eta
