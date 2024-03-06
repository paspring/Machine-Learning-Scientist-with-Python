# Use the official Miniconda image as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app

# Install any needed packages specified in requirements.txt
RUN conda install -y jupyter 

# Install ffmpeg using conda
RUN conda install -c conda-forge ffmpeg -y --quiet 

RUN conda install -y pandas matplotlib seaborn --solver classic 
RUN pip install -U scikit-learn

# Make port 8888 available to the world outside this container
EXPOSE 8888


# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]

