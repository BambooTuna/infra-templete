# nginx-ssl


## docker-compose sample
```yaml
version: "3.4"
services:
  # https://tech.actindi.net/2018/09/20/093414
  ssl-proxy-server:
    restart: always
    build: nginx-ssl
    environment:
      TZ: Asia/Tokyo
      PROXY_SERVER_HOST: localhost:18080
      LETSENCRYPT_HOSTS: localhost
      LETSENCRYPT_MAIL: example@localhost
      LETSENCRYPT_SUBJECT: "/C=JP/ST=Tokyo/L=Shinagawa/CN=default"
    ports:
      - 80:80
      - 443:443
```
