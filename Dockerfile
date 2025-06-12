# Use the official Python base image
FROM python:3.8.10

# Set the working directory in the container
WORKDIR /data

# Copy the requirements file into the container
COPY requirements.txt ./

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Command to run the script (use absolute path)
ENTRYPOINT ["python", "/data/T1GRS_pipeline_R3_catboost_robust.py"]