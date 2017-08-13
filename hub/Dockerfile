FROM selenium/hub:3.4

ADD make-writable /usr/local/bin/make-writable
RUN chmod 755 /usr/local/bin/make-writable

RUN make-writable /opt/selenium/config.json
RUN make-writable /opt/selenium/
