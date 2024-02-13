---
theme: apple-basic
colorSchema: dark
transition: slide-left
mdc: true
title: Teleport
---

# Please stand by ...

---
layout: intro-image-right
image: "https://steinbrueck.io/images/frontpage_hu43e9967b0bf6bb7f2b481dd27b1d2f56_703776_2500x0_resize_q75_box.jpg"
---

# Teleport

## The easiest and most secure way to access and protect all your infrastructure

### JUG Ingolstadt // 02.2024

---
src: ../../reuse/intro.md
---

---
layout: image-right
image: "https://source.unsplash.com/2IZ9r2pgJjQ"
---

# Why we switch from OpenVPN to Teleport?

- OpenVPN is hard to manage ... certs and stuff 🔑
- Client is needed ... for example Tunnelblick
- lack of Auditing
- Firewall rules for user groups ... developer vs. staff

---

# How Teleport works?

![](https://goteleport.com/docs/_next/static/assets/getting-started-diagram-1adf5b562e.svg)

---

# Demo Setup

- 3 Nodes (teleport-proxy, teleport-agent-1 and teleport-agent-2)
- Setup DNS teleport.dev.steinbrueck.io and \*.teleport.dev.steinbrueck.io point to teleport-proxy
- Install teleport via `curl https://goteleport.com/static/install.sh | bash -s 15.0.1`
- on proxy `teleport configure --cluster-name teleport.dev.steinbrueck.io --acme-email me@steinbrueck.io > /etc/teleport.yaml`
- on agent-1 `sudo bash -c "$(curl -fsSL https://teleport.dev.steinbrueck.io/scripts/fde6b033a95537cda5085281a762e37f/install-node.sh)"`
- on agent-2 `teleport configure --output=$HOME/.config/app_config.yaml --app-name=[example-app] --app-uri=http://localhost/ --roles=app --token=73d95c49522321def721852493f1d540 --proxy=teleport.dev.steinbrueck.io:443 --data-dir=$HOME/.config`

---
layout: image-left
image: "https://source.unsplash.com/V9qc-JVKIBo"
---

# Lets play

[teleport.dev.steinbrueck.io](https://teleport.dev.steinbrueck.io)

---
src: ../../reuse/outro.md
---
