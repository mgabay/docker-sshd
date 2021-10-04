ARG SSH_BASE_IMG=oraclelinux:8-slim
FROM ${SSH_BASE_IMG}

# Update packages and install dependencies
RUN microdnf update -y && \
    microdnf install -y openssh-server && \
    microdnf clean all

# Setup SSH:
# - Generate host keys
# - Disable PAM for security purposes
RUN ssh-keygen -A && \
    sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ARG SSH_GID
ARG SSH_GROUP
ARG SSH_UID
ARG SSH_USER

# Create user and disable password
RUN groupadd -g ${SSH_GID} -r ${SSH_GROUP} && \
    useradd --no-log-init -m -r -u ${SSH_UID} -g ${SSH_GROUP} ${SSH_USER} && \
    usermod -p '*' root && \
    usermod -p '*' ${SSH_USER} && \
    mkdir -p /home/${SSH_USER}/.ssh && \
    chown ${SSH_USER}:${SSH_GROUP} /home/${SSH_USER}/.ssh

ENV SSH_USER=${SSH_USER} \
    SSH_GROUP=${SSH_GROUP}

EXPOSE 22

# Startup script will perform chown on authorized keys and setup permissions
COPY startup.sh /opt/startup.sh

CMD ["/opt/startup.sh"]