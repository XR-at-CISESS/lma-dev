FROM ubuntu:latest AS os_setup

# Install Python
RUN apt-get update -y
RUN apt-get install python3 python3-pip -y

# Install utilities
RUN apt-get install git wget vim -y

# Install GEOS Library
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntugis/ppa
RUN apt-get install libgeos-dev -y

FROM os_setup AS lma_scripts

# Install lmatools
RUN pip3 install git+https://github.com/XR-at-CISESS/lmatools.git --break-system-packages

# Install glmtools
RUN pip3 install git+https://github.com/deeplycloudy/glmtools.git --break-system-packages

# Install lma_data
RUN pip3 install git+https://github.com/XR-at-CISESS/lma_data.git --break-system-packages

# Install lma_analysis
COPY install_lma_analysis.sh /tmp/install_lma_analysis.sh
RUN chmod +x /tmp/install_lma_analysis.sh
RUN /tmp/install_lma_analysis.sh
RUN rm /tmp/install_lma_analysis.sh

# Copy shapes
COPY ./shapes /usr/share/lma_shapes
RUN chmod -R a+r /usr/share/lma_shapes

# Copy bash initialization script
COPY initialize_lma.sh /usr/local/bin/initialize_lma.sh
RUN chmod +x /usr/local/bin/initialize_lma.sh

# Set environment variables
ENV LMA_DATA_DIR="/home/lma/lma_data"
ENV LMA_OUT_DIR="/home/lma/lma_out"
ENV LMA_SHAPES_DIR="/usr/share/lma_shapes"

# Configure LMA user
RUN useradd -m lma
USER lma
WORKDIR /home/lma

ENTRYPOINT [ "/usr/local/bin/initialize_lma.sh" ]