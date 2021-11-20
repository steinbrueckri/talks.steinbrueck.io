+++
title = "Docker on OSX Talk"
outputs = ["Reveal"]
[reveal_hugo]
custom_css = "/css/custom.css"
custom_js = "/js/text-animation.js"
transition = "zoom"
+++

<section data-noprocess class="present">
  <h2>About me!</h2>

  <img alt="avatar" class="avatar" src="/images/me.jpg"/>

  <img alt="Github" class="brand-icon" src="/images/icons/github-logo.svg"/>steinbrueckri
  <br/>
  <img alt="Twitter" class="brand-icon" src="/images/icons/twitter-logo.svg"/>@steinbrueckri

  <div class="text-animation-wrapper">
  <p class="text-animation"></p>
  </div>

</section>

---

## Today we are Talk about ...

### Docker for Desktop

![](https://docs.docker.com/desktop/mac/images/docker-tutorial-mac.png)

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

[Podman](https://podman.io/), [Rancher for desktop](https://rancherdesktop.io/) and [Lima](https://github.com/lima-vm/lima) (MacOX only)

<small>
All Solution above are build on Podman / Containerd.

But Podman and Containerd have some issues with [docker-compose](https://major.io/2021/07/09/rootless-container-management-with-docker-compose-and-podman/) or [testcontainer](https://github.com/testcontainers/testcontainers-java/issues/2088).

You can make it work but at least for me its to much pain right now!

</small>

---

![](https://media.giphy.com/media/lKPFZ1nPKW8c8/giphy.gif)

---

### Multipass

Multipass is a mini-cloud on your workstation using native hypervisors of all the supported plaforms (Windows, macOS and Linux), it will give you an Ubuntu command line in just a click (“Open shell”) or a simple `multipass shell` command.

---

```
$ brew install multipass

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

But is know just a VirtualMachine instance without Docker

---

### CloudInit

cloud-init is a software package that automates the initialization of cloud instances during system boot. You can configure cloud-init to perform a variety of tasks. Some sample tasks that cloud-init can perform include: Configuring a host name. Installing packages on an instance.

---

```yaml
## add user and pull key from github
users:
  - name: steinbrueckri
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_import_id: gh:steinbrueckri
## Update apt database and upgrade packages on first boot
package_update: true
package_upgrade: true
## install packages
packages:
  - vim
  - docker
  - avahi-daemon
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
  - sudo usermod -aG docker steinbrueckri
```

<small>💡 This is useful if you can't get Markdown to output exactly what you want.</small>

---

Put the peces together ...

```
# 4 Cores CPU / 4 GB Memory / 50 GB Diskspace / name
multipass launch -c 4 -m 4G -d 50G --name docker --cloud-init .dotfileassets/multipass-docker.yaml
```

---

now we can login to our VirtualMachine and can use docker.

```
$ ssh docker.local                                                                                                                                                       Fri Nov 19 15:06:59 2021
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

but we whant to use it on out workstation and not in the VirtualMachine.

---

```
$ export DOCKER_HOST=ssh://docker.local
$ docker info | grep -e "Operating System"
 Operating System: Ubuntu 20.04.3 LTS
```

---

### Tooling

- Multipass
- CloudInit
- Docker
- K3D
- SSH

... and some MacOX networking glue. :)

---

### 💡 Tipps

<small>We need the files in our VM to then mount them into the container.</small>

```
multipass mount -u 501:1000 /Users/steinbrueckri/ docker:/Users/steinbrueckri
```

<small>When the VM is recreated, the SSH host key is changed and becuase of that the snippet will help you.</small>

```bash
$ cat ~/.ssh/config
Host docker.local
  StrictHostKeyChecking no
```

---

{{< slide background-image="https://source.unsplash.com/user/steinbrueckri" background-opacity="0.2" >}}

---
