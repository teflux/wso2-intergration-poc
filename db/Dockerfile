FROM postgres:10.21
RUN apt update
RUN apt install -y vim

#RUN mkdir /docker-entrypoint-initdb.d
VOLUME ['/var/lib/postgresql/data']
ADD ./init-user-db.sh /docker-entrypoint-initdb.d/