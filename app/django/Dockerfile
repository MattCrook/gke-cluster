FROM python:3.9-buster AS builder

RUN python3 -m venv /venv

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create virtual env for docker container to run python in
ENV PATH "/venv/bin:$PATH"

RUN python3 -m pip install --upgrade pip

COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt

ARG DJANGO_KEY=${SECRET_KEY}

#######################################
# App stage #
FROM python:3.9-slim-buster AS app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PATH "/venv/bin:$PATH"

WORKDIR /usr/src/app

# copy in Python environment
COPY --from=builder /venv /venv

ENV DJANGO_SETTINGS_MODULE=project.settings
ENV SECRET_KEY=DJANGO_KEY

COPY . .

# Run Migrations
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate


EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
