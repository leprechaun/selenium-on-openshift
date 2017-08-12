FROM selenium/standalone-chrome

ADD ./make-writable /usr/local/bin/make-writable
RUN chmod 755 /usr/local/bin/make-writable

EXPOSE 4444
#ENTRYPOINT ["/run.sh"]
#CMD ["couchbase-server"]
