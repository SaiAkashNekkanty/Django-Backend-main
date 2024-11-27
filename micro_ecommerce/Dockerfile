# Use Python 3.9 as the base image
FROM python:3.9

# Setup environment variables
ENV DOCKERIZE_VERSION v0.6.1
ENV PYTHONUNBUFFERED 1
ENV PATH $PATH:/usr/src/.local/bin

# Set workspace directory
WORKDIR /usr/src/app

# Install dependencies for Dockerize
RUN apt-get update && apt-get install -y wget

# Install Dockerize
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Copy only requirements.txt first to cache layer
COPY requirements.txt /usr/src/app/


# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /usr/src/app/

# Expose the default Django port
EXPOSE 8000

# Run the Django application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "micro_ecommerce.config.wsgi:application"]
