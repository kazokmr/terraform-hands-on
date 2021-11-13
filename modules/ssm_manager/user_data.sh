#!/bin/sh

# Dockerをインストールしサービスで起動する
amazon-linux-extras install -y docker
systemctl start docker
systemctl enable docker
