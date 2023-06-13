FROM python:3.11.4-slim-bullseye@sha256:4102cb4b15a5c0c52068d3128f87b1d43e6a3b431714f4a65e8b8e91750c7c54

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
