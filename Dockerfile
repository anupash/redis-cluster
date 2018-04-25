FROM redis
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y --no-install-recommends install ruby wget \
  && gem install redis -v 3.3.5 \
  && apt-get -y autoremove \
  && apt-get -y clean
ADD redis-trib.rb /usr/local/bin/redis-trib
RUN chmod 755 /usr/local/bin/redis-trib
CMD redis-server /conf/redis.conf
