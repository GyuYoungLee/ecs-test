FROM python:3.10.4-slim as base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1


FROM base AS python-deps

# Install pipenv and compilation dependencies
RUN pip install pipenv==2022.1.8 --no-cache-dir
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc musl-dev \
    && apt-get install -y --no-install-recommends default-libmysqlclient-dev python3-dev \
    && apt-get install -y --no-install-recommends netcat

# Install python depenencies in /.venv
WORKDIR /
COPY Pipfile .
COPY Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy --dev


FROM base AS runtime

COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

RUN useradd --create-home user
WORKDIR /usr/src
USER user

COPY --chown=user:user ./hello ./hello
COPY --chown=user:user ./start.sh ./start.sh

CMD ["sh", "start.sh"]
