FROM python:3.11.4-slim-bullseye@sha256:68ff2208aed4c4d9562e4f1e42e9a648430a52bf8b284ac0c8c7d5ef26dc8575

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
