FROM python:3.8-slim-buster

RUN python -m venv /venv

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# don't check for pip updates
# ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# Create virtual env for docker container to run python in
ENV PATH "/venv/bin:$PATH"

RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /usr/src/app

COPY . .

ENV FLASK_APP=app
ENV FLASK_ENV=production

RUN export FLASK_APP
RUN export FLASK_ENV

# initialize db
RUN flask db init
RUN flask db migrate -m "Initial migration."
RUN flask db upgrade

EXPOSE 5000

# The main purpose of a CMD is to provide defaults for an executing container.
CMD ["flask", "run", "--host", "0.0.0.0"]
