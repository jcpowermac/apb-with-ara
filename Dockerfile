FROM registry.fedoraproject.org/f29/httpd  


#RUN dnf install -y python2-pip \
#    @'C Development Tools and Libraries' \
#    redhat-rpm-config \
#    python2-devel \
#    python3-psycopg2 ara httpd mod_wsgi && \
#    dnf clean all
RUN dnf install -y python3-psycopg2 ara mod_wsgi && \
    dnf clean all

#RUN pip install -U setuptools ara==0.16.3

ENV ARA_WWW=/var/www/ara
COPY ara.conf /etc/httpd/conf.d/
RUN mkdir -p ${ARA_WWW} && \
    cp -p $(which ara-wsgi) ${ARA_WWW} && \
    chown -R apache:0 ${ARA_WWW}
