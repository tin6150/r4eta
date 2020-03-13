# Dockerfile for creating R container 
# and add specific library needed by projects by LBNL/ETA
# local build should work, but it no longer has all the updates done Dockerfile.metabolic
# docker build -t tin6150/r4eta -f Dockerfile .  | tee Dockerfile.monolithic.log 

# rscript has its own set of fairly long install...
# (model after cmaq container)
 

#FROM r-base:3.6.2
FROM r-base:3.6.3
MAINTAINER Tin (at) LBL.gov

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=PST8PDT 

#ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN touch    _TOP_DIR_OF_CONTAINER_  ;\
    echo "begining docker build process at " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a       _TOP_DIR_OF_CONTAINER_ ;\
    echo "installing packages via apt"       | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    apt-get update ;\
    # ubuntu:
    apt-get --quiet install git file wget gzip bash tcsh zsh less vim bc tmux screen xterm ;\
    apt-get --quiet install rstudio ;\
    echo '==================================================================' ;\
    echo "git cloning the repo for reference/tracking" | tee -a _TOP_DIR_OF_CONTAINER_ ;\
    #apt-get -y --quiet install git  ;\
    test -d /opt/gitrepo  || mkdir -p /opt/gitrepo        ;\
    cd /opt/gitrepo       ;\
    test -d /opt/gitrepo/r4eta  || git clone https://github.com/tin6150/r4eta.git  ;\
    cd /opt/gitrepo/r4eta &&  git pull && cd /            ;\

    echo '==================================================================' ;\
    echo '==================================================================' ;\
    echo '==================================================================' ;\
    echo "installing packages cran packages" | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                      ;\
    echo '==================================================================' ;\
    echo '==================================================================' ;\
    echo '==================================================================' ;\
    echo ''
    # initialization1.R

RUN touch    _TOP_DIR_OF_CONTAINER_  ;\
    Rscript --quiet -e 'install.packages("ggplot2",    repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("maps",    repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("dplyr",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("sf",  repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("fields",  repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("Imap",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("raster",  repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("readxl",    repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("ncdf4",   repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("rgdal", repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("ggmap",   repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("lawn",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("sp",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("shapefiles",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("tmap",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("spdplyr",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("rgdal",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'library()'   | sort | tee R_library_list.out.1.txt  ;\
    ls /usr/local/lib/R/site-library | sort | tee R-site-lib-ls.out.1.txt   ;\
    echo "Done installing packages cran packages - part 1" | tee -a _TOP_DIR_OF_CONTAINER_     ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                      ;\
    echo ""

    # initialization2.R
RUN echo "installing packages cran packages - part 2" | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    Rscript --quiet -e 'install.packages("MASS",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("reshape2",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("cowplot",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("corrplot",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("RColorBrewer",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("fmsb",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("ggmap",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("tictoc",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("stargazer",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("psych",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("GPArotation",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("cluster",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("factoextra",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("DandEFA",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("xtrable",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("psychTools",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("aCRM",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("clusterCrit",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("data.table",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("tigris",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("DAAG",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'library()'   | sort | tee R_library_list.out.2.txt  ;\
    ls /usr/local/lib/R/site-library | sort | tee R-site-lib-ls.out.2.txt   ;\
    echo "Done installing packages cran packages - part 2" | tee -a _TOP_DIR_OF_CONTAINER_     ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                      ;\
    echo ""

    # initialization3.R
RUN echo "installing packages cran packages - part 3" | tee -a _TOP_DIR_OF_CONTAINER_     ;\
    Rscript --quiet -e 'install.packages("RSQLite",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("rgeos",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("gpclib",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("utils",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("plyr",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("maptools",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("datamart",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("dismo",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("openair",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("broom",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("gridExtra",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("foreach",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("doParallel",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("sandwich",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("lmtest",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("cvTools",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("timeDate",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("lubridate",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("zoo",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("stringr",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("stringi",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("chron",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("proj4",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("akima",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("RColorBrewer",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("directlabels",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("FactoMineR",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("rstudioapi",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("iterators",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("doSNOW",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'install.packages("Hmisc",     repos = "http://cran.us.r-project.org")'    ;\
    Rscript --quiet -e 'library()'   | sort | tee R_library_list.out.3.txt  ;\
    ls /usr/local/lib/R/site-library | sort | tee R-site-lib-ls.out.3.txt   ;\
    echo "Done installing packages cran packages - part 3" | tee -a _TOP_DIR_OF_CONTAINER_     ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                      ;\
    echo ""

RUN     cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_  \
  && echo  "Dockerfile 2020.0313 1522"  >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale"

#- ENV TZ America/Los_Angeles  
ENV TZ America/Los_Angeles 
# ENV TZ likely changed/overwritten by container's /etc/csh.cshrc
#ENV DOCKERFILE Dockerfile[.cmaq]
# does overwrite parent def of ENV DOCKERFILE
ENV TEST_DOCKER_ENV     this_env_will_be_avail_when_container_is_run_or_exec
ENV TEST_DOCKER_ENV_2   Can_use_ADD_to_make_ENV_avail_in_build_process
ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values
# but how to append, eg add to PATH?

#ENTRYPOINT ["cat", "/_TOP_DIR_OF_CONTAINER_"]
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT [ "R" ]
# if no defined ENTRYPOINT, default to bash inside the container
# parent container defined tcsh.
# can also run with exec bash to get shell:
# docker exec -it tin6150/r4eta -v $HOME:/home/tin  bash 
# careful not to cover /home/username (for this container)
