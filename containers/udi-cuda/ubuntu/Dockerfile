# syntax=docker/dockerfile:1.3-labs
#
# The CUDA version should match the Openshift worker node.
#
ARG IMAGE_NAME=docker.io/nvidia/cuda:12.4.1-cudnn-devel-ubuntu24.04

# hadolint ignore=DL3006
FROM ${IMAGE_NAME}

# The FROM statement defines a new scope
ARG CUDA_VERSION="12-4"
ARG V1="${CUDA_VERSION//./-}"
ARG CUDA_NSIGHT_VERSION=${V1%-*}

# cherry picked from below
# https://github.com/devfile/developer-images/blob/main/base/ubi8/Dockerfile


USER 0

# install: common tools
RUN apt update && \
    apt install -y bash curl diffutils git git-lfs iproute2 \
                    jq less lsof man nano procps p7zip \
                    net-tools openssh-client \
                    pigz rsync socat screen sudo time vim wget xz-utils zip 

# install: other bins

RUN apt install -y bash-completion cuda-nsight-systems-${CUDA_NSIGHT_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# install: oc,tkn
# todo: install cli tools during env init / not in container
ARG OC4_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux-amd64-rhel8.tar.gz"
ARG TKN_URL="https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/latest/tkn-linux-amd64.tar.gz"

RUN curl -sL "${OC4_URL}" | \
      tar -C /usr/local/bin -vzxf- oc kubectl && \
      /usr/local/bin/oc completion bash > /etc/bash_completion.d/oc && \
      echo "source /etc/bash_completion.d/oc" >> /etc/skel/.bashrc && \
    curl -sL "${TKN_URL}" | \
      tar -C /usr/local/bin -vzxf- --no-same-owner tkn && \
      /usr/local/bin/tkn completion bash > /etc/bash_completion.d/tkn && \
      echo "source /etc/bash_completion.d/tkn" >> /etc/skel/.bashrc

# install: entrypoint
COPY --chown=0:0 entrypoint.sh /

# setup: user
RUN \
    # setup $PS1 prompt
    echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`$ '" >> /etc/skel/.bashrc && \
    echo '' >> /etc/skel/.bashrc && \
    echo 'NVIDIA_ENTRYPOINT=/opt/nvidia/entrypoint.d' >> /etc/skel/.bashrc && \
    echo '[ -d "${NVIDIA_ENTRYPOINT}" ] && cat "${NVIDIA_ENTRYPOINT}"/*.txt' >> /etc/skel/.bashrc && \
    echo '' >> /etc/skel/.bashrc && \
    echo '[ -d /projects/bin ] && export PATH=/projects/bin:${PATH}' >> /etc/skel/.bashrc && \
    # copy global git configuration to user config
    cp /etc/gitconfig /etc/skel/.gitconfig && \
    useradd -u 1001 \
      -G sudo,root \
      -d /home/user \
      --shell /bin/bash \
      -m user && \
    # Set permissions on /etc/passwd and /home to allow users to write
    chgrp -R 0 /home && \
    chmod -R g=u /etc/passwd /etc/group /home && \
    chmod +x /entrypoint.sh

USER 1001
ENV HOME=/home/user
VOLUME /home/user

WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["sleep", "infinity"]

# labels for container catalog
LABEL summary="devfile base developer image"
LABEL description="Python image with base developers tools"
LABEL io.k8s.display-name="devfile-developer-base"
LABEL io.openshift.expose-services=""
