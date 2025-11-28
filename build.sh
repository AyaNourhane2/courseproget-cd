#!/usr/bin/env bash
# Exit on error
set -o errexit

# Debug: show current directory and files
echo "Current directory: $(pwd)"
echo "Files in current directory:"
ls -la

# Check if manage.py exists
if [ ! -f "manage.py" ]; then
    echo "ERROR: manage.py not found in current directory!"
    echo "Looking for manage.py..."
    find . -name "manage.py" -type f
    exit 1
fi

# Install dependencies (already done in Dockerfile, but keep for Render)
pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --no-input

# Apply database migrations
python manage.py migrate

echo "Build completed successfully!"