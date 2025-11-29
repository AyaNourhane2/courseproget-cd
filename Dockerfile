FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p staticfiles

EXPOSE $PORT

CMD sh -c "python manage.py migrate && python manage.py collectstatic --noinput --clear && gunicorn --bind 0.0.0.0:$PORT course_project.wsgi:application"