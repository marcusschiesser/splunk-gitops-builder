FROM python:3.7 

WORKDIR /tmp/apps
# Install JQ 1.6 & Splunkbase client & AWS CLI
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /usr/local/bin/jq && chmod +x /usr/local/bin/jq
RUN pip install git+https://github.com/HurricaneLabs/sbclient.git
RUN pip install awscli --upgrade
# Copy helper scripts
COPY ./bin /bin
RUN chmod +x /bin/*.sh
