#!/bin/bash

# Ensure $HOME exists when starting
if [ ! -d "${HOME}" ]; then
  mkdir -p "${HOME}"
fi

# Setup $PS1 for a consistent and reasonable prompt
if [ -w "${HOME}" ] && [ ! -f "${HOME}"/.bashrc ]; then
  echo "PS1='[\u@\h \W]\$ '" > "${HOME}"/.bashrc
fi

# Add current (arbitrary) user to /etc/passwd and /etc/group
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

# fix: path for local bin
# todo: move to /etc/skel/.bashrc
export PATH=$PATH:${HOME}/.local/bin

# kludge: initalize home
cp -an /etc/skel/.{bash,profile,gitconfig}* ${HOME} 2>/dev/null || true

# fix: ssh perms
# address issue for some storage classes
# where sticky bit in home modifies
# .ssh folder on pod restarts
if [ -f ${HOME}/.ssh/id_rsa ]; then
    chmod 700 ${HOME}/.ssh
    chmod 600 ${HOME}/.ssh/id_rsa*

    if [ -f ${HOME}/.ssh/known_hosts ]; then
        chmod 600 ${HOME}/.ssh/known_hosts
    fi
fi

# notice: show attribution
NVIDIA_ENTRYPOINT=/opt/nvidia/nvidia_entrypoint.sh

[ -e /NGC-DL-CONTAINER-LICENSE ] && cat /NGC-DL-CONTAINER-LICENSE

if [ -e "${NVIDIA_ENTRYPOINT}" ]; then
  "${NVIDIA_ENTRYPOINT}" "$@"
else
  exec "$@"
fi
