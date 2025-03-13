FROM ubuntu:latest AS os_setup

# Install utilities
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntugis/ppa && \
    # Install Python and utilities
    apt-get install -y \
    python3 python3-pip python3-venv \
    git wget vim tmux \
    libgeos-dev fonts-paratype && \
    # Cleanup apt cache
    rm -rf /var/lib/apt/lists/*

FROM os_setup AS lma_scripts

# Install lmatools
RUN pip3 install --no-cache-dir --break-system-packages \
    git+https://github.com/XR-at-CISESS/lmatools.git \
    git+https://github.com/deeplycloudy/glmtools.git \
    git+https://github.com/XR-at-CISESS/lma_data.git

# Install lma_analysis
COPY ./scripts/install_lma_analysis.sh /tmp/install_lma_analysis.sh
RUN chmod +x /tmp/install_lma_analysis.sh
RUN /tmp/install_lma_analysis.sh
RUN rm /tmp/install_lma_analysis.sh

# Copy shapes
COPY ./shapes /usr/share/lma_shapes
RUN chmod -R a+r /usr/share/lma_shapes

# Copy bash initialization script
COPY ./scripts/initialize_lma.sh /usr/local/bin/initialize_lma.sh
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