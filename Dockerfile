FROM python:3.11.5-slim-bullseye@sha256:0bc6588e043ceff0278c3936467fce6dad52c5889bf4eb257ad5147a17522064

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
