FROM mariadb

LABEL   maintainer="kbeaugrand" \
        version="10.3.8"

RUN sed -i "s#LimitNOFILE=16364#LimitNOFILE=32000#g" /lib/systemd/system/mariadb.service | grep LimitNOFILE /lib/systemd/system/mariadb.service
