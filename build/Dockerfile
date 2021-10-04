FROM oraclelinux:8-slim

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

# Create user and disable password
RUN groupadd -g $SSH_GID -r $SSH_GROUP && \
    useradd --no-log-init -m -r -u $SSH_UID -g $SSH_GROUP $SSH_USER && \
    usermod -p '*' root && \
    usermod -p '*' $SSH_USER && \
    mkdir -p /home/$SSH_USER/.ssh && \
    chown $SSH_USER:$SSH_USER /home/$SSH_USER/.ssh

EXPOSE 22

# Startup script will perform chown on authorized keys and setup permissions
COPY startup.sh /opt/startup.sh

CMD ["/opt/startup.sh"]