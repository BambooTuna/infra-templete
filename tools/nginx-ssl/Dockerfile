FROM nginx:latest

ENV PROXY_SERVER_HOST "localhost:18080"

# 【ドメイン名 スペース区切りで複数指定可】
ENV LETSENCRYPT_HOSTS "localhost"

# 【窓口メールアドレス】
ENV LETSENCRYPT_MAIL "example@localhost"

# 【←仮証明書用の記載内容】
ENV LETSENCRYPT_SUBJECT "/C=JP/ST=Tokyo/L=Shinagawa/CN=default"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
      openssl \
      certbot \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.tpl.conf /etc/nginx/nginx.tpl.conf
COPY extcat.sh /extcat.sh
COPY start.sh /start.sh

RUN chmod +x /extcat.sh && chmod +x /start.sh

CMD cat /etc/nginx/nginx.tpl.conf | /extcat.sh > /etc/nginx/nginx.conf && /start.sh
