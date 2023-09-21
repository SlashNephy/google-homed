FROM python:3.11.5-slim-bullseye@sha256:9f35f3a6420693c209c11bba63dcf103d88e47ebe0b205336b5168c122967edf

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
