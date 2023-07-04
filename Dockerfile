FROM python:3.11.4-slim-bullseye@sha256:933083cddf041acec1be03ddd1c2e7abb5ce0b2b5fbc0e06c8b29be5f21b2c96

ENV SERVER_HOST=0.0.0.0
ENV SERVER_PORT=5257
ENV GOOGLE_HOME_IP_ADDRESS=0.0.0.0
ENV DEFAULT_LANG=ja
ENV TMP_DIR=/tmp/google-homed
ENV NIGHT_HOURS=1,2,3,4,5,6

RUN pip install --no-cache-dir \
      pychromecast \
      flask \
      gtts

COPY entrypoint.py /

ENTRYPOINT ["python", "-u", "/entrypoint.py"]
