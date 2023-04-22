--------------------------------------on master-node---------------------------------
apt-get update 
apt-get install docker-io 
systemctl start docker
systemctl enable docker

--------------------------------------on worker-node---------------------------------
apt-get update 
apt-get install docker-io 
systemctl start docker
systemctl enable docker

--------------------------------------on master-node------------------------------

Download the Google Cloud public signing key:
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

             or 

sudo apt update -y
sudo apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y

--------------------------------------on worker-node------------------------------

Download the Google Cloud public signing key:
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

             or 

sudo apt update -y
sudo apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y

--------------------------------------on master-node------------------------------

sudo su
kubeadm init

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

kubeadm token create --print-join-command

allow port no 6443 in master-node sg 

------------------------------------------- Worker Node ------------------------------------------------ 
sudo su
kubeadm reset pre-flight checks
-----> Paste the Join command on worker node with `--v=5`

---------------------------------------on Master Node-----------------------------------------

kubectl get nodes 

Might be you will get erro : the-connection-to-the-server-x-x-x-6443-was-refused-did-you-specify-the-right 
please use below command to fix :

sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

Credits: https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-containerd-on-ubuntu-22-04.html

The error message "the-connection-to-the-server-x-x-x-6443-was-refused-did-you-specify-the-right" is a common issue that can occur when using kubeadm to set up a Kubernetes cluster. This error usually occurs when the kubeadm init command is unable to establish a connection to the Kubernetes API server.

Here are a few things you can try to troubleshoot the issue:

Check if the Kubernetes API server is running: The Kubernetes API server is responsible for managing the cluster's state and responding to API requests. Ensure that the Kubernetes API server is running and accessible. You can check the status of the API server using the following command:

systemctl status kubelet

Check if the kubeconfig file is configured correctly: The kubeconfig file contains the credentials and configuration information required to authenticate and access the Kubernetes API server. Ensure that the kubeconfig file is correctly configured and accessible. You can check the contents of the kubeconfig file using the following command:

cat ~/.kube/config

Check the network settings: Ensure that the network settings are configured correctly to allow communication between the nodes in the cluster. You can check the network settings using the following command:

kubectl get pods -n kube-system

If the above steps do not resolve the issue, you may need to check the logs for more information about the error. You can check the logs using the following command:

journalctl -u kubelet











             
