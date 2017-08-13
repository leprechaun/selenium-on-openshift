FROM python

RUN pip install selenium

ADD runner/test.py /usr/local/bin/selenium-runner
RUN chmod 755 /usr/local/bin/selenium-runner

CMD selenium-runner

