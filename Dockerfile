#
# A dockerfile to run a RStudio and RShiny server
#
# BUILD DOCKER:	docker build -t anandvl/rstudioshiny .
# RUN DOCKER: docker run -t -d --name=Ravl -p 8787:8787 -p 3838:3838 -e PASSWORD=passwd_here -v $PWD:/home/rstudio -v $PWD/shiny:/srv/shiny-server -v$PWD/logs:/var/log/shiny-server anandvl/rstudioshiny
#	In the host	browser - RStudio - localhost:8787 (username is 'rstudio'), RShiny - localhost:3838
#
 
# Start with official Rstudio image from rocker/rstudio and set up environments
FROM rocker/tidyverse:latest

MAINTAINER Anand V. Lakshmikumaran (anandvlak@gmail.com)

ENV CRAN_URL https://cloud.r-project.org/

# Set up to automatically start up shiny server too
RUN export ADD=shiny && bash /etc/cont-init.d/add

# Download and install additional relevant system packages
# May need openjdk, if we need to install rJava and XLConnect
#RUN apt-get update && apt-get install -y \
#	&& apt-get install openjdk-8-jre
#	&& apt-get -y autoremove \
#	&& apt-get clean \
#    && rm -rf /var/lib/apt/lists/*
	
# Download and install additional relevant R-packages (will modify this as we go along)
RUN R -e "\
	update.packages(ask = FALSE, repos = '${CRAN_URL}'); \
	pkgs_to_install <- c('tidyverse', 'reshape2', 'tkrplot', 'lattice', 'qcc', 'aplpack'); \
	pkgs_to_install <- c(pkgs_to_install, 'RSQLite', 'RCurl', 'feather); \
#	pkgs_to_install <- c(pkgs_to_install, 'rJava', 'XLConnect', 'RSQLite', 'RCurl', 'feather); \
#	pkgs_to_install <- c(pkgs_to_install, 'MICE', 'PARTY', 'CARET', 'randomForest'); \
#	pkgs_to_install <- c(pkgs_to_install, 'nnet', 'e1071', 'kernlab'); \
#	pkgs_to_install <- c(pkgs_to_install, 'keras', 'tensorflow', 'sparklyr'); \
#	pkgs_to_install <- c(pkgs_to_install, 'tfestimators', 'tfdatasets', 'tfruns'); \
	install.packages(pkgs = pkgs_to_install, dependencies = TRUE, repos = '${CRAN_URL}'); \
	sapply(pkgs_to_install, require, character.only = TRUE);"

# Change configs for the R-shiny server
# Change default ports for R-studio and R-shiny
# sed ...
# sed ..

# Expose the newly configured ports for R-shiny and R-studio (8787)

#EXPOSE 3838
#EXPOSE 8787
