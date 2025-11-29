# Use official Python runtime
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project
COPY . .

# Create static directory and collect static files
RUN mkdir -p staticfiles
RUN python manage.py collectstatic --noinput --clear

# Apply database migrations
RUN python manage.py migrate

# Expose port
EXPOSE $PORT

# Start Gunicorn server
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "course_project.wsgi:application"]