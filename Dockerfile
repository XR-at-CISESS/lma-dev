FROM ubuntu:latest

# Install Python
RUN apt-get update -y
RUN apt-get install python3 python3-pip -y

# Install utilities
RUN apt-get install git wget -y

# Install GEOS Library
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntugis/ppa
RUN apt-get install libgeos-dev -y 

# Install lmatools
RUN pip3 install git+https://github.com/deeplycloudy/lmatools.git --break-system-packages

# Install lma_analysis
COPY install_lma_analysis.sh /tmp/install_lma_analysis.sh
RUN chmod +x /tmp/install_lma_analysis.sh
RUN /tmp/install_lma_analysis.sh
RUN rm /tmp/install_lma_analysis.sh

CMD ["/bin/bash"]