FROM python:3.7 

WORKDIR /tmp/apps
# Install JQ 1.6 & Splunkbase client
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /usr/local/bin/jq && chmod +x /usr/local/bin/jq
RUN pip install git+https://github.com/marcusschiesser/sbclient.git
# Copy helper scripts
COPY ./bin /bin
RUN chmod +x /bin/*.sh
