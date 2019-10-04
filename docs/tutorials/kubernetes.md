<div class="range range-xs-left">
<div class="cell-xs-10 cell-lg-6 text-md-left inset-md-right-80 cell-lg-push-1 offset-top-50 offset-lg-top-0">
<h2 id="content" class="h1">Kubernetes</h2>
<div class="offset-top-30 offset-md-top-30">
</div>
</div>
</div>

<h3 class="small-subtitle">How to run ElasTest on K8s</h3>

##### Get the ElasTest Manifests
- **Clone** toolbox project    
```
git clone https://github.com/elastest/elastest-toolbox.git
```
<p></p>

- **Navigate** to folder
```
cd elastest-toolbox/kubernetes/ek
```
##### Enable Security
If you want to stablish credentials to access to ElasTest and its integrated services, follow these steps:

- **Set Jenkins and TestLink Credentials.** Edit the file **`etm-deployment.yml`** and replace the value "none" in the variables **`ET_USER`** and **`ET_PASS`** for whatever you want.
```
- name: ET_USER
  value: XXXXXX
- name: ET_PASS
  value: YYYYYY
```
<p></p>

- **Set ElasTest Credentials.** Edit the file *"etm-proxy-deployment.yml"* and replace the value "none" in the variables **`ET_USER`** and **`ET_PASS`** for whatever you want.
```
- name: ET_USER
  value: XXXXXX
- name: ET_PASS
  value: YYYYYY
```
<p></p>

In addition, you have to set to true the variable **`ET_SECURITY`**.
```
- name: ET_SECURITY
  value: "true"
```

<h4 class="holder-subtitle link-top">Minikube</h4>
It is possible that when you start with this mini tutorial, you don't have Minikube and the necessary tools installed. To know how to do this, please follow the steps in described in the official [site](https://kubernetes.io/es/docs/tasks/tools/install-minikube/)

##### **Minikube in Ubuntu host (without a VM)**
Run Minikube with this command in your local:
```
sudo minikube start --memory=4098 --cpus=4 --vm-driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost --extra-config=kubelet.resolv-conf=/run/systemd/resolve/resolv.conf --extra-config=apiserver.service-node-port-range=1000-60000
```

###### Deploy ElasTest

```
kubectl create -f . -f volumes/
```
        
**Note:** **`-f volumes`** it’s only necessary first time, but there is no problem if it is used at another time, although error messages will be output*

##### **Minikube in VM**
Run Minikube with this command in your local:
```
sudo minikube start --memory=6048 --cpus=4 --extra-config=apiserver.service-node-port-range=1000-60000 --extra-config kubelet.node-ip=VM-IP
```

###### Deploy ElasTest

- Set the Public Node IP in ElasTest
Edit the file **`etm-deployment.yml`** and update this environment variable with the VM IP:
    
        - name: ET_PUBLIC_HOST
          value: VM IP
    

- Start ElasTest
    
        kubectl create -f . -f volumes/
**Note:** **`-f volumes`** it’s only necessary first time, but there is no problem if it is used at another time, although error messages will be output*



##### How to access
- Execute **`sudo minikube ip`** to get the cluster ip.
- Open your browser and navigate to http://*CLUSTER-IP*:37000

<h4 class="holder-subtitle link-top">AWS (Single Node)</h4>

If you want to deploy ElasTest on a k8s cluster in AWS, you will need to do something else before executing the command to start ElasTest on k8s.

##### Cluster Configuration
- Extend default NodePort range 
Add this line **`--service-node-port-range=1000-40000`** to the file **`/etc/kubernetes/manifests/kube-apiserver.yaml`**.

```
:q!apiVersion: v1
kind: Pod
metadata:
creationTimestamp: null
labels:
    component: kube-apiserver
    tier: control-plane
name: kube-apiserver
namespace: kube-system
spec:
containers:
- command:
    - kube-apiserver
    - --advertise-address=10.1.47.54
    ……
    - --service-node-port-range=1000-40000
```

##### Deploy ElasTest
- Set the Public Node IP in ElasTest
Edit the file **`etm-deployment.yml`** and update this environment variable with the public ip for the node in AWS:

        - name: ET_PUBLIC_HOST
          value: AWS Public Node IP

- Start ElasTest

        kubectl create -f . -f volumes/
**Note:** **`-f volumes`** it’s only necessary first time, but there is no problem if it is used at another time, although error messages will be output*

##### How to access
- Use the **AWS public IP** as your cluster IP.
- Open your browser and navigate to http://*CLUSTER-IP*:37000


###### How to stop:
```
kubectl delete -f .
```

**Note:** don't include the volumes folder if you don't want to lose the elastest data, as the volumes will be deleted






