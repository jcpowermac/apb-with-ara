FROM registry.fedoraproject.org/f29/httpd  

USER root
RUN dnf install -y python3-psycopg2 ara mod_wsgi && \
    dnf clean all

ENV ARA_WWW=/var/www/ara
COPY ara.conf /etc/httpd/conf.d/
RUN mkdir -p ${ARA_WWW} && \
    cp -p $(which ara-wsgi) ${ARA_WWW} && \
    chown -R apache:0 ${ARA_WWW}
COPY ansible.cfg ${ARA_WWW}

USER 1001    
