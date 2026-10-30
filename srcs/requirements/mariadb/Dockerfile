FROM debian:bookworm

WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/lib/mysql/*

COPY . /mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /mariadb/tools/mariadb.sh

ENTRYPOINT ["/mariadb/tools/mariadb.sh"]