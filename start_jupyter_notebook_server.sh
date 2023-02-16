#!/bin/bash

#### manually starting jupyter notebook (server) eg when testing build of container, etc
#### worked on wombat (wsl2), http://127.0.0.1:8888/ is default port 
#### worked from browser on windoze side
#### top of notebook server dir is pwd of where command is run

# cd $HOME
jupyter-notebook


# or

# jupyter-notebook --port=9999 --ip='*'"
