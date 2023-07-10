# Use an official Python runtime as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Create the environment:
COPY environment.yml .

# Update conda and install mamba and prerequisites for Osmium
RUN conda update -n base -c defaults conda && \
    conda install mamba -c conda-forge && \
    apt-get update && \
    apt-get install -y build-essential cmake libboost-program-options-dev \
                       libbz2-dev zlib1g-dev libexpat1-dev pandoc

# Create the environment:
RUN mamba env create -f environment.yml

# Make sure the environment is activated:
SHELL ["conda", "run", "-n", "ev_charging_env", "/bin/bash", "-c"]

# Clone osmium dependencies
RUN git clone https://github.com/mapbox/protozero.git && \
    git clone https://github.com/osmcode/libosmium.git

# Clone and build osmium
RUN git clone https://github.com/osmcode/osmium-tool.git && \
    cd osmium-tool && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "ev_charging_env", "python", "your_script.py"] ## I dont have a main Python script, the Python script would be application-specific.

# This Dockerfile starts with a base image (continuumio/miniconda3) that contains a minimal installation of Python and conda. 
# It sets /app as the working directory in the Docker image, and copies the contents of your project directory into the Docker image. 
# It then creates a conda environment using your environment.yml file.
# Finally, it sets the SHELL to use conda run. This ensures that all subsequent commands will be run in your conda environment.



# Build a new Docker image:
# docker build -t ev_charging_env .



# To run the container in the powershell:
# --> docker run -it --rm ev_charging_env /bin/bash