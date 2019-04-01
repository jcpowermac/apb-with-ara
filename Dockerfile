FROM registry.fedoraproject.org/fedora:29

RUN dnf install -y python3-gunicorn python3-psycopg2 ara && \
    dnf clean all

ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
ENV ANSIBLE_CONFIG=/ansible.cfg
COPY bin/ ${APP_ROOT}/bin/
COPY ansible.cfg /
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /ansible.cfg /etc/passwd

EXPOSE 8080
USER 10001
WORKDIR ${APP_ROOT}
ENTRYPOINT [ "uid_entrypoint" ]
CMD run
