#!/bin/sh

# Installs lma_analysis from lma-tech.com into /usr/bin/.

# Download lma_analysis
wget -r --no-parent -nH --cut-dirs=1 -P /tmp/ ftp://lma-tech.com/pub/lma_analysis/

# Move binary to /usr/bin
mv /tmp/lma_analysis/lma_analysis_v* /usr/bin/lma_analysis
chmod +x /usr/bin/lma_analysis

# Remove temporary directory
rm -rf /tmp/lma_analysis/