FROM alpine:edge

# Install packages
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
  apk --no-cache add \
    bash \
    vim \
    python \
    openssh \
    curl

# Add configuration files
COPY .bashrc /root/.bashrc
COPY start.sh /bin/original_start.sh

# Set up bash, gcloud, helm, start script
RUN ln -snf /bin/bash /bin/sh && \
    sed -i -e 's/\r$//' /root/.bashrc && \
    tr -d '\r' < /bin/original_start.sh > /bin/start.sh && \
    chmod -R 700 /bin/start.sh && \
    printf "color desert" > /root/.vimrc && \
    rm -fr /var/cache/apk/* && \
    mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    mkdir /var/install && \
    curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz && \
    mkdir -p /usr/local/gcloud && \
    tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
    /usr/local/gcloud/google-cloud-sdk/install.sh && \
    /usr/local/gcloud/google-cloud-sdk/bin/gcloud components install kubectl && \
    wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz && \
    tar -zxvf helm-v2.11.0-linux-amd64.tar.gz && \
    cp linux-amd64/helm /usr/local/bin/

ENV PATH="/usr/local/gcloud/google-cloud-sdk/bin:${PATH}"

# Install app
COPY . /var/kube
WORKDIR /var/kube

EXPOSE 8001

ENV TERM xterm-color

CMD ["sh", "/bin/start.sh"]