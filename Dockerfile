FROM ubuntu:14.04

WORKDIR /beetbox

ENV BEET_PROFILE 'docker'

EXPOSE 80

VOLUME ["/var/beetbox"]

# Install sudo.
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean

# Copy source files into the build context.
COPY . /beetbox

# Provision Beetbox.
RUN /beetbox/provisioning/beetbox.sh