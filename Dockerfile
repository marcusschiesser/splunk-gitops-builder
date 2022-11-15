FROM python:3.7 

WORKDIR /tmp/apps
# Install JQ 1.6 & Splunkbase downloader
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /usr/local/bin/jq && chmod +x /usr/local/bin/jq
RUN pip install $(curl -s https://raw.githubusercontent.com/marcusschiesser/splunkbase-download/v1.1.3/requirements.txt)
RUN wget https://raw.githubusercontent.com/marcusschiesser/splunkbase-download/v1.1.3/download-splunkbase.py -O /usr/local/bin/download-splunkbase.py && chmod +x /usr/local/bin/download-splunkbase.py
# Copy helper scripts
COPY ./bin /bin
RUN chmod +x /bin/*.sh
