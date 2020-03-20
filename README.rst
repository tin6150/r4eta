r4eta
=====

Container for R with libraries for LBNL Energy Technology Area project

docker build -t tin6150/r4eta -f Dockerfile .  | tee Dockerfile.monolithic.log

docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/tmp/home  --user=$(id -u):$(id -g) tin6150/r4eta
docker exec -it   distracted_keller  bash

singularity pull --name myR shub://tin6150/r4eta
./myR
singularity exec myR /usr/bin/Rscript --version
singularity exec myR /usr/bin/Rscript -e 'library()'
singularity exec --bind  .:/mnt  myR  /usr/bin/Rscript  /mnt/helloWorld.R > output.txt
