FROM selenium/node-chrome:3.3

USER root

ADD make-writable /usr/local/bin/make-writable
RUN chmod 755 /usr/local/bin/make-writable

RUN make-writable /opt/selenium/config.json || true
RUN make-writable /opt/selenium/

USER seluser
