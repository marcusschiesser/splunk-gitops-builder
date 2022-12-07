FROM ubuntu:22.04

WORKDIR /tmp/apps
# Install Dependencies (Python, git and wget)
RUN apt-get update && apt-get -y install --no-install-recommends python3-pip wget git
# Install JQ 1.6 & Splunkbase client & AWS CLI
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /usr/local/bin/jq && chmod +x /usr/local/bin/jq
RUN pip install git+https://github.com/HurricaneLabs/sbclient.git
RUN pip install awscli --upgrade
# Copy helper scripts
COPY ./bin /bin
RUN chmod +x /bin/*.sh
# Install NVM
RUN wget https://raw.githubusercontent.com/creationix/nvm/master/install.sh -O - | bash 
RUN echo "source /root/.nvm/nvm.sh" >> /root/.profile 
# Force bash so github actions are using bash instead of dash
RUN ln -sf /bin/bash /bin/sh


