FROM docker.io/fedora:28


RUN dnf install -y python2-pip \
    @'C Development Tools and Libraries' \
    redhat-rpm-config \
    python2-devel \
    python-psycopg2 python-PyMySQL && \
    dnf clean all

RUN pip install -U setuptools ara==0.14.6


ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

EXPOSE 8080
USER 10001
WORKDIR ${APP_ROOT}
ENTRYPOINT [ "uid_entrypoint" ]
CMD run
