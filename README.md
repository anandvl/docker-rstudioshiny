# docker-rstudioshiny
Dockerfile used to create a docker image to run RStudio and RShiny server using rocker/tidyverse as base image.

This is a repository of the Dockerfile used to create a dockerimage to run RStudio server and RShiny server on the default ports of 8787 and 3838, respectively.  It starts with official Rstudio image from rocker/rstudio and installs some additional R packages (reshape2, tkrplot, lattice, qcc, aplpack, RSQLite, RCurl, feather).  Later versions may include rJava (with openjdk), XLConnect, and other machine learning (ML) and deep learning (neural networks) packages.

A typical command to run this image will be

> docker run -t -d --name=Ravl -p 8787:8787 -p 3838:3838 -e PASSWORD=passwd_here -v $PWD:/home/rstudio -v $PWD/shiny:/srv/shiny-server -v$PWD/logs:/var/log/shiny-server anandvl/rstudioshiny

Then, the RStudio server can be accessed at https://localhost:8787 (username is 'rstudio') and the RShiny server can be accessed at https://localhost:3838

