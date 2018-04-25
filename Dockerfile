FROM redis
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y --no-install-recommends install ruby wget \
  && gem install redis -v 3.3.5 \
  && apt-get -y autoremove \
  && apt-get -y clean
RUN wget -O /usr/local/bin/redis-trib https://gist.githubusercontent.com/anupash/b839e0feae193d1bd5cf89062744f1ce/raw/2a4017c4906335da94fbf6fecf53484058e9fa0d/redis-trib.rb
RUN chmod 755 /usr/local/bin/redis-trib
CMD sed -i 's/\/data\/nodes.conf/\/data\/nodes-'$HOSTNAME'.conf/g; s/dump.rdb/dump-'$HOSTNAME'.rdb/g' /conf/redis.conf \
  && redis-server /conf/redis.conf
