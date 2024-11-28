# Use a lightweight Python image for production
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DOCKERIZE_VERSION=v0.6.1 \
    PATH=/usr/src/.local/bin:$PATH
ENV PYTHONPATH="/usr/src/app:$PYTHONPATH"
# Set work directory
WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y netcat-openbsd
# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    wget \
    gcc \
    libpq-dev \
    python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dockerize
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 8000

# Command to run the Django application
CMD ["gunicorn","config.wsgi:application","--bind", "0.0.0.0:8000"]