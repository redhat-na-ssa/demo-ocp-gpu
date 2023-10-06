# syntax=docker/dockerfile:1.3-labs
ARG IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-devel-ubi8
FROM ${IMAGE_NAME}

# cherry picked from below
# https://github.com/devfile/developer-images/blob/main/base/ubi8/Dockerfile

# labels for container catalog
LABEL summary="devfile base developer image"
LABEL description="Python image with base developers tools"
LABEL io.k8s.display-name="devfile-developer-base"
LABEL io.openshift.expose-services=""

USER 0

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf install -y bash curl diffutils git git-lfs iproute jq less lsof man nano procps p7zip p7zip-plugins \
                   perl-Digest-SHA net-tools openssh-clients rsync socat sudo time vim wget zip && \
                   dnf clean all

# install: entrypoint
COPY --chown=0:0 entrypoint.sh /
RUN \
    # add user
    useradd -u 1001 \
      -G wheel,root \
      -d /home/user \
      --shell /bin/bash \
      -m user && \
    # Setup $PS1 for a consistent and reasonable prompt
    echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`$ '" >> /etc/skell/.bashrc && \
    # Copy the global git configuration to user config as global /etc/gitconfig
    #  file may be overwritten by a mounted file at runtime
    cp /etc/gitconfig /etc/skel/.gitconfig && \
    # Set permissions on /etc/passwd and /home to allow arbitrary users to write
    chgrp -R 0 /home && \
    chmod -R g=u /etc/passwd /etc/group /home && \
    chmod +x /entrypoint.sh

# install: python
RUN yum install -y libGL python39 bash-completion && \
    alternatives --set python /usr/bin/python3.9 && \
    ln -s /usr/bin/pip3.9 /usr/bin/pip && \
    yum clean all && \
    rm -rf /var/cache/yum/*

# install: oc,tkn
ARG OC4_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz"
ARG TKN_URL="https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/latest/tkn-linux-amd64.tar.gz"

RUN curl -sL "${OC4_URL}" | \
      tar -C /usr/local/bin -vzxf- oc kubectl && \
      /usr/local/bin/oc completion bash > /etc/bash_completion.d/oc && \
      echo "source /etc/bash_completion.d/oc" >> /home/user/.bashrc && \
    curl -sL "${TKN_URL}" | \
      tar -C /usr/local/bin -vzxf- tkn && \
      /usr/local/bin/tkn completion bash > /etc/bash_completion.d/tkn && \
      echo "source /etc/bash_completion.d/tkn" >> /home/user/.bashrc

USER 1001
ENV HOME=/home/user
VOLUME /home/user

WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]
