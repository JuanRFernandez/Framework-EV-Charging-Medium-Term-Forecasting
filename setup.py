from setuptools import find_packages, setup

# Read the requirements.txt file
with open("requirements.txt", "r") as f:
    requirements = f.read().splitlines()

# Read the README.md file for the long_description
with open("README.md", "r") as f:
    long_description = f.read()

setup(
    name='ev_power_demand_forecasting',
    version='0.1.0',
    packages=find_packages(),
    description='Project Template Framework for medium-term EV charging demand forecasting for the DDEII subject',
    long_description=long_description,
    long_description_content_type="text/markdown",
    author='Juan_Fernandez',
    author_email='roferbru@email.com', # replace with your email
    url="https://github.com/JuanRFernandez/Framework-EV-Charging-Medium-Term-Forecasting.git", # replace with your github username
    license='MIT',
    install_requires=requirements,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)
