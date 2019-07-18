#################################################################################################################
#################################################################################################################

# How to install the gpu tools package - on a Windows 64-bit desktop

#################################################################################################################
#################################################################################################################

# 1. Install nvidia's cuda capable video driver

    # e.g. from website http://www.nvidia.com/object/cuda_get.html

    # I installed cuda_5.0.35_winvista_win7_win8_general_64.msi

#################################################################################################################

# 2. Install nvidia's cuda toolkit

    # e.g. from website http://www.nvidia.com/object/cuda_get.html

# 3. set the environment variable CUDA_HOME to the folder where you installed it


# Control Panel > System > Advanced sytstem settings > Environment variables

#################################################################################################################

# 3. Install the gputools package from a locally saved tar.gz file

install.packages("~/Resources/Applications/R/Downloads/Packages/gputools_0.26.tar.gz", repos=NULL, type="source")

# doesn't work...

require(gputools)

#################################################################################################################
#################################################################################################################

# Testing

#################################################################################################################
#################################################################################################################
