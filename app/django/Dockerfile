
FROM python:3.9-buster AS builder

RUN python -m venv /venv

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create virtual env for docker container to run python in
ENV PATH "/venv/bin:$PATH"

RUN pip install --upgrade pip

COPY requirements.dev.txt .
RUN pip install -r requirements.dev.txt

COPY .env .

# install redis
# python3 -m pip install channels_redis
# python3 -m pip install selenium
# RUN docker run -p 6379:6379 -d redis:5

#######################################
# App stage #
# Smaller official Debian-based Python image
FROM python:3.9-slim-buster AS app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PATH "/venv/bin:$PATH"

WORKDIR /usr/src/app

# copy in Python environment
COPY --from=builder /venv /venv

COPY . .

ENV DJANGO_SETTINGS_MODULE=quantumapp.settings

EXPOSE 8000

# CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
