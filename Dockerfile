# Use an official Python runtime as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
# Note: the .dockerignore file will exclude unnecessary files and folders
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




# Summary of Steps:
# Dockerfile Creation: You've written a Dockerfile to describe an environment that includes Python, Conda, and several other dependencies.

# Build Docker Image: You built a Docker image named ev_charging_env based on that Dockerfile, which means you have created a snapshot of that environment.

# Run Docker Container: You ran a Docker container from that image, creating a running instance of the environment. This is where your code execution happens.

# Connect VS Code to Container: You've connected your VS Code to this running Docker container. This allows you to work within the container's environment, accessing its file system, running code in its Python environment, etc.

# Jupyter Kernel Setup: Inside the container, you activated the ev_charging_env environment and installed it as a Jupyter kernel. This allows Jupyter Notebooks to run using this environment.

# About the Containers:
# ev_charging_env gallant_roentgen: This is the container you created from the ev_charging_env image. This is your main working environment.

# vsc-ss2023 project template framework for medium-term...: This seems to be a development container created by VS Code itself for managing the remote development setup. VS Code often handles the remote container connection by running its own container, which helps in providing an isolated and consistent development environment.

# Why Two Containers:
# You have two containers because one is your specific working environment (ev_charging_env gallant_roentgen), and the other is used by VS Code for managing the remote development setup.

# What You're Working With:
# You should be working within the ev_charging_env gallant_roentgen container, which has everything you defined in your Dockerfile. The Jupyter Notebook should now be using the kernel from this container, so any code you run in the notebook is executed within this environment.

# Moving Forward:
# You can continue working in this environment as you would normally, and your code will have access to all the dependencies and settings you've defined in the Dockerfile.