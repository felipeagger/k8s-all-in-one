#!/usr/bin/env bash

echo "Starting Instalarion of K8s All-in-One"

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

echo "Install Docker..."
curl -fsSL https://get.docker.com | bash

systemctl enable --now docker
systemctl status docker | grep "Active:"
usermod -aG docker ${USER}


echo "Install K8s..."
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet kubeadm kubectl git --disableexcludes=kubernetes

systemctl enable kubelet

echo "Pull Images K8s..."
kubeadm config images pull

kubeadm init

mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:$(id -g) /home/vagrant/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf

source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc

echo "Apply Network Polices K8s..."
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl taint nodes --all node-role.kubernetes.io/master-

echo "Get Nodes K8s..."
kubectl get nodes

echo "Cloning Example"
git clone -b k8s https://github.com/felipeagger/apinodejs.git

echo "Get All namespaces Default"
kubectl get all