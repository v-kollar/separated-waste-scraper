FROM mariadb:10.11.2

WORKDIR /mnt/mysql-data

ENV MARIADB_ROOT_PASSWORD=aaa

RUN mkdir -p /mnt/mysql-data \
    && chown -R mysql:mysql /mnt/mysql-data \
    && sed -i 's/\/var\/lib\/mysql/\/mnt\/mysql-data/g' \
    	       /etc/mysql/mariadb.conf.d/50-server.cnf \
    && echo "[mysqld]" >> /etc/mysql/my.cnf \
    && echo "innodb_buffer_pool_size = 64M" >> /etc/mysql/my.cnf \
    && echo "max_connections = 10" >> /etc/mysql/my.cnf \
    && echo "default_time_zone = '+02:00'" >> /etc/mysql/my.cnf

COPY ./data/containers-filtered.csv /mnt/mysql-data/
COPY init.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]

