# Use the official Ubuntu image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy the requirements file and the application code into the container
COPY requirements.txt /app
COPY djangodocker /app/djangodocker

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Python, pip, and venv
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment, and install dependencies
RUN python3 -m venv venv
RUN . venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Set the working directory to the Django project directory
WORKDIR /app/djangodocker

# Command to run the Django application
CMD ["/app/venv/bin/python3", "manage.py", "runserver", "0.0.0.0:8000"]
