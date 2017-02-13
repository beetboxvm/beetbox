FROM ubuntu:14.04

WORKDIR /beetbox

VOLUME ["/var/beetbox"]

# Copy source files into the build context.
COPY ./provisioning /beetbox/provisioning

# Provision Beetbox.
RUN /beetbox/provisioning/beetbox.sh

# Delete innodb log files.
RUN rm /var/lib/mysql/ib_logfile*

# Allow reprovision.
RUN rm /beetbox/installed

EXPOSE 22 80 443
CMD ["/bin/bash", "/start.sh"]
