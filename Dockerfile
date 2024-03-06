# Use the official Miniconda image as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app

# Install PySpark and Spark
RUN conda install conda-forge::pyspark -y --solver classic

RUN conda install -c conda-forge findspark -y

RUN conda install -y jupyter --solver classic

# Install ffmpeg using conda
RUN conda install -c conda-forge ffmpeg -y --quiet

RUN conda install -y pandas matplotlib seaborn --solver classic

RUN pip install -U scikit-learn


# Set the environment variables for Spark
ENV SPARK_HOME /usr/local/spark
ENV PATH $SPARK_HOME/bin:$PATH

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]