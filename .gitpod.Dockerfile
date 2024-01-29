FROM gitpod/workspace-base

# Install Telepresence
RUN sudo curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.17.0/telepresence-linux-amd64 -o /usr/local/bin/telepresence
RUN sudo chmod a+x /usr/local/bin/telepresence

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install eksctl, aws
RUN ARCH=amd64
RUN PLATFORM=$(uname -s)_$ARCH
RUN curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
RUN curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
RUN tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
RUN sudo mv /tmp/eksctl /usr/local/bin

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install