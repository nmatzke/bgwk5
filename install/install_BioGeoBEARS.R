#######################################################
# Installation of BioGeoBEARS
#######################################################

#######################################################
# The R package BioGeoBEARS requires that you 
# install R, and a number of R package dependencies.
#######################################################
#
# To install R (I recommend RStudio; on Macs, R.app 
#               also works.), go to:
#
# R, and R.app for Macs if desired:
# https://cloud.r-project.org/
#
# RStudio Desktop:
# https://posit.co/download/rstudio-desktop/
#######################################################


# BioGeoBEARS dependencies
# Install some necessary R packages from CRAN (these are precompiled,
# so easy to install on all systems)

install.packages("ape")
install.packages("pak") # replacement for devtools
install.packages("Rcpp")
install.packages("FD")
install.packages("snow")
install.packages("rexpokit")
install.packages("cladoRcpp")

install.packages("phytools")
install.packages("phangorn")
install.packages("phylobase")
install.packages("optimx")
install.packages("GenSA")

# Install additional dependencies
#install.packages(c("plotrix","gdata","minqa","fdrtool","statmod","SparseM","spam"),"MultinomialCI"))
install.packages(c("plotrix","gdata","minqa","fdrtool","statmod","SparseM","spam")

# MultinomialCI is currently off of CRAN. It is just "suggested" for BioGeoBEARS. 
# But if you need it, download the tar.gz file from e.g.:
# https://github.com/nmatzke/Matzke_R_binaries/tree/master/Multinomial_CI
# https://cran.r-project.org/src/contrib/Archive/MultinomialCI/
install.packages(pkgs="~/Downloads/MultinomialCI_1.2.tar.gz", repos=NULL, type="source", dependencies=TRUE)


# Installing BioGeoBEARS - options:

# Option #1 (easiest): pak (replacing install_github)
library(pak)
pak::pkg_install(pkg="nmatzke/BioGeoBEARS", lib=NULL, upgrade=FALSE, ask=FALSE, dependencies=NA)

# Option #2 (2nd simplest): remotes (which simplified from devtools::install_github, which is being deprectated)
# (BioGeoBEARS is pure R, so installation is easy *if* the above 
#  packages have been installed)
install.packages("remotes")
library(remotes)
remotes::install_github(repo="nmatzke/BioGeoBEARS", dependencies=TRUE, upgrade="never")

# Option #2 (requires downloading zipfile)
# Install BioGeoBEARS from downloaded zipfile
install.packages("BioGeoBEARS_1.1.4.tar.gz", repos=NULL, type="source", dependencies=TRUE)


# Check that your BioGeoBEARS installation loads
library(BioGeoBEARS)

# If this returns without an error, it worked
# (other messages are fine)


# Get the file locations for example files, inside the BioGeoBEARS installation
extdata_dir = np(system.file("extdata", package="BioGeoBEARS"))
extdata_dir
list.files(extdata_dir)

# Get the locations of the lab example files from GitHub install
labdir = paste(extdata_dir, "examples/395lab/", sep="/")
labpt1a = paste(extdata_dir, "examples/395lab/Psychotria_M0_equalRates/", sep="/")
labpt1b = paste(extdata_dir, "examples/395lab/Psychotria_M2_oneWayDispersal/", sep="/")
labpt1c = paste(extdata_dir, "examples/395lab/Psychotria_M4_DistanceDispersal/", sep="/")
labpt2a = paste(extdata_dir, "examples/395lab/conifer_DEC_traits_models/", sep="/")
labpt2b = paste(extdata_dir, "examples/395lab/conifer_DEC+x_traits_models/", sep="/")

labpt1a_script = paste(extdata_dir, "examples/395lab/Psychotria_M0_equalRates/Psychotria_M0_v1.R", sep="/")
labpt1b_script = paste(extdata_dir, "examples/395lab/Psychotria_M2_oneWayDispersal/Psychotria_M2_oneWayDispersal_v1.R", sep="/")
labpt1c_script = paste(extdata_dir, "examples/395lab/Psychotria_M4_DistanceDispersal/Psychotria_M4_DistanceDispersal_v1.R/", sep="/")
labpt2a_script = paste(extdata_dir, "examples/395lab/conifer_DEC_traits_models/conifer_DEC_traits_models_v3.R", sep="/")
labpt2b_script = paste(extdata_dir, "examples/395lab/conifer_DEC+x_traits_models/conifer_DEC+x_traits_models_v3.R", sep="/")


# Open an R script in R Studio
file.edit(labpt1a_script)
