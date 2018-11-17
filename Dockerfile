FROM r-base:latest

MAINTAINER Svetlana Vinogradova "kintany@gmail.com"

RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    make \
    gcc && \
    R -e "install.packages(c('shiny', 'shinyFiles'), repos='https://cran.rstudio.com/')" && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY testDocker/ /srv/shiny-server/testDocker/

CMD ["/usr/bin/shiny-server.sh"]
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
