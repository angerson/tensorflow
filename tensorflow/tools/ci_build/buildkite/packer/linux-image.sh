#! /usr/bin/env bash
set -euxo pipefail

# Install Buildkite agent
echo "deb https://apt.buildkite.com/buildkite-agent stable main" | sudo tee /etc/apt/sources.list.d/buildkite-agent.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198
sudo apt-get update && sudo apt-get install -y buildkite-agent
sudo sed -i "s/xxx/${BUILDKITE_AGENT_TOKEN}/g" /etc/buildkite-agent/buildkite-agent.cfg
# echo "tags-from-gcp=true" | sudo tee -a /etc/buildkite-agent/buildkite-agent.cfg
sudo tee -a /etc/buildkite-agent/buildkite-agent.cfg <<BK
tags="queue=docker"
name="linux-%n"
BK
sudo systemctl enable buildkite-agent
# Do not treat this instance as an agent
sudo systemctl stop buildkite-agent

# Install Docker
sudo apt-get update && sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
# Let the agent use Docker
sudo usermod -aG docker buildkite-agent


# Install Nvidia and Nvidia Docker support
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-driver-430 nvidia-docker2

# Clean up apt lists
sudo rm -rf /var/lib/apt/lists/*
