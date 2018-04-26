FROM redis:alpine
ENV DEBIAN_FRONTEND noninteractive
ADD redis-trib.rb /usr/local/bin/redis-trib
RUN set -ex \
	\
    apk update \
    \
    && apk --update --no-cache --virtual add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates wget \
    \
    &&  echo 'gem: --no-document' > /etc/gemrc \
    \
    && gem install redis \
    \
    && chmod 755 /usr/local/bin/redis-trib
CMD redis-server /conf/redis.conf
