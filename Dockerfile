FROM redis:alpine
ENV DEBIAN_FRONTEND noninteractive
ADD redis-trib.rb /usr/local/bin/redis-trib
RUN set -ex \
    apk add --no-cache 'su-exec>=0.2' \
    \
    && apk update \
    \
    && apk --update --no-cache --virtual add \
            ruby \
            ruby-irb \
            ruby-io-console \
            ruby-bigdecimal \
            ruby-json \
            ruby-bundler \
            tzdata \
    \
    &&  echo 'gem: --no-document' > /etc/gemrc \
    \
    && gem install redis \
    \
    && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    \
    && chmod 755 /usr/local/bin/redis-trib
CMD redis-server /conf/redis.conf
