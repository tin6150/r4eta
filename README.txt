r4eta
=====

Container for R with libraries for LBNL Energy Technology Area project
Now with Jupyter Notebook server


Example running R script via Docker
-----------------------------------

# R script inside the container
docker run                -it --entrypoint=Rscript  ghcr.io/tin6150/r4eta:master  /opt/gitrepo/r4eta/drJin.R  

# R script in home dir, bind mounted to container
docker run -v "$PWD":/mnt -it --entrypoint=Rscript  ghcr.io/tin6150/r4eta:master  /mnt/drJin.R                

# running a bash shell, can call R from there
docker run                -it --entrypoint=bash     ghcr.io/tin6150/r4eta:master  



Start a web-based Jupyter notebook
----------------------------------

Start jupyter notebook web server (on specific port, eg 5997):

docker run -p 5997:5997 -v "$PWD":/mnt -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4eta lab --allow-root  --no-browser --port=5997 --ip=0.0.0.0

Point web browser to something like
  http://127.0.0.1:5997/ 
  http://hima.lbl.gov:5997/ 
and paste the token URL link shown on the terminal console

/mnt is a mount of the current dir (PWD) where you started the docker process, and files written there will persist after the container is terminated.  (Other files inside the container are ephemeral!)

Repo info
---------

* source:            https://github.com/tin6150/r4eta
* github container:  https://ghcr.io/tin6150/r4eta
* docker hub:        https://hub.docker.com/repository/docker/tin6150/r4eta  # aged
* singularity hub:   https://singularity-hub.org/collections/4160            # aged



Text Terminal based run 
========================

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


Additional singularity and docker container build and troubleshooting notes in DevNote.txt

-Tin 2020.09.07

.. vim: nosmartindent tabstop=4 noexpandtab shiftwidth=4 paste
