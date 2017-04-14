FROM alpine

ADD dbmanager /opt/dbmanager

RUN apk add --no-cache git bash mariadb-client gettext python py-mysqldb vim && \
    git clone https://github.com/datacharmer/test_db.git /opt/dbmanager/data/1 && \
    apk del git

ADD entrypoint.sh.tpl /entrypoint.sh.tpl

CMD     envsubst < /entrypoint.sh.tpl > /entrypoint.sh; /bin/bash /entrypoint.sh
