FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p staticfiles

# Run migrations
RUN python manage.py migrate

# Skip collectstatic in build - do it at runtime
# RUN python manage.py collectstatic --noinput --clear || true

EXPOSE $PORT

CMD python manage.py collectstatic --noinput --clear; gunicorn --bind 0.0.0.0:$PORT course_project.wsgi:application