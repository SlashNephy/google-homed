# google-homed
📢 Simple API server daemon for Google Home; Let it Speak from API

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/slashnephy/google-homed/latest)](https://hub.docker.com/r/slashnephy/google-homed)

`docker-compose.yml`

```yaml
version: '3.8'

services:
  google_homed:
    container_name: google-homed
    image: slashnephy/google-homed:latest
    restart: always
    network_mode: host
    expose:
      - '5257'
    environment:
      TZ: Asia/Tokyo
      SERVER_HOST: 192.168.x.x
      SERVER_PORT: 5257
      GOOGLE_HOME_IP_ADDRESS: 192.168.x.x
      # デフォルトの言語
      DEFAULT_LANG: ja
      # /speak を無視する時間帯
      NIGHT_HOURS: 1,2,3,4,5,6
```

Try calling `GET /speak?text={text}` or `POST /speak` with JSON payload `{"text": "hoge"}`.
