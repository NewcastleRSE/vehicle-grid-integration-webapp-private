FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim


# Install dependencies
RUN apt-get update && \
    apt-get -y install curl 

# Install Poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/901bdf0491005f1b3db41947d0d938da6838ecb9/get-poetry.py | POETRY_VERSION=1.1.12 POETRY_HOME=/etc/poetry python && \
    cd /usr/local/bin && \
    ln -s /etc/poetry/bin/poetry && \
    poetry config virtualenvs.create false

COPY vgi_api /app/vgi_api
WORKDIR /app/vgi_api
RUN rm poetry.lock
RUN poetry lock
RUN poetry install --no-root --no-dev