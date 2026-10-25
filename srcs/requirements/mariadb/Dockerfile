from debian:trixie

WORKDIR /

RUN apt-get update && apt-get install -y mariadb-server

# meter para copiar para a pasta definitiva
COPY . dir

RUN chmod +x mariadb.sh

ENTRYPOINT ["mariadb.sh"]