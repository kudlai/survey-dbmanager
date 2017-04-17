FROM alpine

ADD dbmanager /opt/dbmanager

RUN apk add --no-cache git bash mariadb-client gettext python py-mysqldb py-yaml vim tar gzip && \
    mkdir -p /opt/dbmanager/data/2 && \
    git clone https://github.com/datacharmer/test_db.git /opt/dbmanager/data/2/repo && \
    cd /opt/dbmanager/data/2/; rm -rf repo/.git && tar -czvf repo.tar.gz repo && \
    rm -rf /opt/dbmanager/data/2/repo && \
    apk del git

CMD     envsubst < /opt/dbmanager/config.yaml.tpl > /opt/dbmanager/config.yaml; /opt/dbmanager/run.py
