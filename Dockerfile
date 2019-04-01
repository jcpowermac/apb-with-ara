FROM docker.io/fedora:29


#RUN dnf install -y python2-pip \
#    @'C Development Tools and Libraries' \
#    redhat-rpm-config \
#    python2-devel \
#    python3-psycopg2 ara httpd mod_wsgi && \
#    dnf clean all
RUN dnf install -y python3-psycopg2 ara httpd mod_wsgi && \
    dnf clean all

#RUN pip install -U setuptools ara==0.16.3


ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
ENV ARA_WWW=/var/www/ara
COPY bin/ ${APP_ROOT}/bin/
COPY ara.conf /etc/httpd/conf.d/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd && \
    mkdir -p ${ARA_WWW} && \
    mkdir -p /run/httpd && \
    cp -p $(which ara-wsgi) ${ARA_WWW} && \
    chown -R apache:0 /etc/httpd/ ${ARA_WWW} /run/httpd/ && \
    rm /run/httpd/httpd.pid || true && \
    sed -i '/Listen 80/c\Listen 8080' /etc/httpd/conf/httpd.conf

EXPOSE 8080
USER 10001
WORKDIR ${APP_ROOT}
ENTRYPOINT [ "uid_entrypoint" ]
CMD run
