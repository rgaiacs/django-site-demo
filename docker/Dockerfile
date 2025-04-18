FROM python:3.13.3-alpine3.21 AS base

# This should be defined at build-time with --build-arg
ARG CI_COMMIT_TAG
ARG CI_COMMIT_SHA

# A default value is provided
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
ENV VERSION=${CI_COMMIT_TAG:-undefined}
ENV COMMIT_SHA=${CI_COMMIT_SHA:-undefined}

LABEL org.opencontainers.image.authors="Raniere Silva <raniere@rgaiacs.com>"
LABEL org.opencontainers.image.url="https://github.com/rgaiacs/django-site-demo"
LABEL org.opencontainers.image.documentation="https://github.com/rgaiacs/django-site-demo"
LABEL org.opencontainers.image.source="https://github.com/rgaiacs/django-site-demo"
LABEL org.opencontainers.image.version=$VERSION
LABEL org.opencontainers.image.revision=$COMMIT_SHA
LABEL org.opencontainers.image.licenses="CC0-1.0"
LABEL org.opencontainers.image.title="Django Site DEmo"

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR /var/app

COPY ./docker/apk.list /tmp
RUN grep -v "^#" /tmp/apk.list | xargs apk add --no-cache

COPY ./docker/pip.list /tmp
RUN grep -v "^#" /tmp/pip.list | xargs python -m pip install --no-cache-dir

COPY ./docker/createsuperuser.sh /usr/bin/createsuperuser.sh
COPY ./docker/export-data.sh /usr/bin/export-data.sh
COPY ./docker/import-data.sh /usr/bin/import-data.sh

# From Docker documentation at https://docs.docker.com/reference/dockerfile/#cmd
# 
# If CMD is used to provide default arguments for the ENTRYPOINT instruction,
# both the CMD and ENTRYPOINT instructions should be specified in the exec form.
ENTRYPOINT ["/usr/bin/django-entrypoint.sh"]
CMD []
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "wget", "-O", "/dev/null", "http://127.0.0.1:8000"]

FROM base AS development

COPY ./docker/entrypoint.dev.sh /usr/bin/django-entrypoint.sh

FROM base AS production

RUN python -m pip install --no-cache-dir gunicorn

COPY ./docker/entrypoint.sh /usr/bin/django-entrypoint.sh

COPY ./src /var/app
