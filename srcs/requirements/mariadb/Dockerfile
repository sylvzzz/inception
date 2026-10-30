FROM debian:bookworm

WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/lib/mysql/*

COPY . /dir
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /dir/tools/mariadb.sh

ENTRYPOINT ["/dir/tools/mariadb.sh"]