#!/usr/bin/env R


# on Rocky Linux 8, 
# install.packages(pacman) 
# as user, not as root, so that it will install the packages under the user's dir
# then future p_load() can install also under user's dir.

print("Hello World from R! (ref:0906)")

library(pacman)

p_load( "dplyr" )  # quite sizable install.

print("Goodbye World from R! (ref:0906)")


# #clear workspace
# rm(list=ls())

