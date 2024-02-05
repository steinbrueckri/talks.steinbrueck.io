---
theme: seriph
background: https://docs.docker.com/desktop/mac/images/docker-tutorial-mac.png
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Docker on OSX Talk
drawings:
  persist: false
defaults:
  foo: true
transition: slide-left
title: Docker on OSX Talk
mdc: true
---
## Today we are Talk about ...
### Docker for Desktop

---

### Why?

- [License issue with Docker for Desktop](https://www.docker.com/blog/updating-product-subscriptions/)
- Docker introducing a change in the license for Docker for Desktop ... From January 31, 2022 it require a paid subscription to use Docker Desktop
- Docker Desktop remains free for small businesses (fewer than 250 employees AND less than $10 million in annual revenue)
- It requires a paid subscription (Pro, Team or Business), starting at $5 per user per month, for professional use in larger businesses.
- No changes to Docker Engine or any upstream open source Docker or Moby project.

- and Nobody need a GUI! ;)

---

There are Solutions ...

[Podman](https://podman.io/), [Rancher for desktop](https://rancherdesktop.io/) and [Lima](https://github.com/lima-vm/lima) (macOS only)

All Solution above are build on Podman / Containerd. But Podman and Containerd have some issues with [Docker-compose](https://major.io/2021/07/09/rootless-container-management-with-docker-compose-and-podman/) or [Testcontainers](https://github.com/testcontainers/testcontainers-java/issues/2088). You can make it work but at least for me its to much pain right now!

---
layout: image
image: https://media.giphy.com/media/lKPFZ1nPKW8c8/giphy.gif
backgroundSize: contain
---

---

### Multipass

Multipass is a mini-cloud on your workstation using native hypervisors of all the supported platforms (Windows, macOS and Linux), it will give you an Ubuntu command line in just a click (“Open shell”) or a simple `multipass shell` command.

---

```bash
$ brew install multipass docker

$ multipass launch -n test
Launched: test

$ multipass info test
Name:           test
State:          Running
IPv4:           192.168.64.4
Release:        Ubuntu 20.04.3 LTS
Image hash:     91740d72ffff (Ubuntu 20.04 LTS)
Load:           0.00 0.07 0.09
Disk usage:     1.3G out of 4.7G
Memory usage:   135.6M out of 981.3M
Mounts:         --
```

But it is now just a Virtual Machine without Docker

---

### CloudInit can to the Job!

cloud-init is a software package that automates the initialization of cloud instances during system boot. You can configure cloud-init to perform a variety of tasks. Some sample tasks that cloud-init can perform include: Configuring a host name. Installing packages on an instance.

![](https://assets.ubuntu.com/v1/15971bf5-cloud-init-primary.svg)

---

```
## add user and pull key from github
users:
  - name: steinbrueckri   <---------------------------------- Important part
    sudo: ALL=(ALL) NOPASSWD:ALL
    ## Import my key from github
    ssh_import_id: gh:steinbrueckri <------------------------ Important part
## Update apt database and upgrade packages on first boot
package_update: true
package_upgrade: true
## install packages
packages:
  - vim
  - docker
  - avahi-daemon <------------------------------------------- Important part
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg
  - lsb-release
## setup docker
runcmd:
  - sudo curl -fsSL https://get.docker.com | sudo bash
  - sudo systemctl enable docker
  - sudo systemctl enable -s HUP ssh
  - sudo groupadd docker
  - sudo usermod -aG docker steinbrueckri <------------------ Important part
```

---

Put all together ...

```bash
multipass launch \
-c 4 \               # 4 cores CPU
-m 4G \              # 4 GB memory
-d 50G \             # 50 GB disk space
-n docker \          # name
--cloud-init .dotfileassets/multipass-docker.yaml
```

---

Now we can login to our Virtual Machine and can use docker.

```bash
$ ssh docker.local
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-90-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Nov 19 15:07:09 CET 2021

  System load:              0.0
  Usage of /:               7.5% of 48.29GB
  Memory usage:             16%
  Swap usage:               0%
  Processes:                152
  Users logged in:          0
  IPv4 address for docker0: 172.17.0.1
  IPv4 address for enp0s2:  192.168.64.3
  IPv6 address for enp0s2:  fd9c:f1b4:94a0:cbaf:a833:ffff:fe6d:fc7a

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

7 updates can be applied immediately.
To see these additional updates run: apt list --upgradable
```

---

... And can use docker in the Virtual Machine.

```bash
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:cc15c5b292d8525effc0f89cb299f1804f3a725c8d05e158653a563f15e4f685
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
```

But we want to use it on our workstation and not in the Virtual Machine.

```bash
$ export DOCKER_HOST=ssh://docker.local
$ docker info | grep -e "Operating System"
 Operating System: Ubuntu 20.04.3 LTS
```

---

### 💡 Tipps

<small>We need the files in our VM to then mount them into the container.</small>

```bash
multipass mount -u 501:1000 /Users/steinbrueckri/ docker:/Users/steinbrueckri
```

<small>When the Virtual Machine is recreated, the SSH host key is changed and becuase of that the snippet will help you.</small>

```bash
$ cat ~/.ssh/config
Host docker.local
  StrictHostKeyChecking no
```

---
layout: image-right
image: https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Kubernetes_logo_without_workmark.svg/2109px-Kubernetes_logo_without_workmark.svg.png
---
Add Kubernetes to the stack ...

```bash
$ brew install k3d
==> Summary
🍺  /usr/local/Cellar/k3d/5.1.0: 9 files, 18MB
$ k3d --version
k3d version v5.1.0
k3s version v1.21.5-k3s2 (default)
```

---

```bash
$ k3d cluster create
INFO[0002] Prep: Network
INFO[0005] Created network 'k3d-k3s-default'
INFO[0007] Created volume 'k3d-k3s-default-images'
INFO[0008] Creating node 'k3d-k3s-default-server-0'
INFO[0081] Starting Node 'k3d-k3s-default-serverlb'
INFO[0089] Injecting '172.18.0.1 host.k3d.internal' into /etc/hosts of all nodes...
INFO[0091] Injecting records for host.k3d.internal and for 2 network members into CoreDNS configmap...
INFO[0102] Cluster 'k3s-default' created successfully!
INFO[0108] You can now use it like this:
kubectl cluster-info
$ k get nodes
NAME                       STATUS   ROLES                  AGE     VERSION
k3d-k3s-default-server-0   Ready    control-plane,master   3m52s   v1.21.5+k3s2
```

---

https://source.unsplash.com/user/steinbrueckri

### TL;DR

- Multipass
- CloudInit
- Docker
- K3d
- SSH

... And some macOS networking glue. :)

---
layout: cover
background: https://source.unsplash.com/user/steinbrueckri/1600x900
---

# Questions?
