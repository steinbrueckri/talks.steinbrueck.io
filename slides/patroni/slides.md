---
theme: seriph
background: https://source.unsplash.com/user/steinbrueckri/3840x2160
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Postgres HA with Patroni
drawings:
  persist: false
defaults:
  foo: true
transition: slide-left
title: Postgres HA with Patroni
mdc: true
---

# Postgres HA

## With Patroni

---

## src: ../../reuse/intro.md

## src: ../../reuse/outro.md

# Why?

Postgres Cluster managment is hard by hand, you do it just one or twice a year and its a pain every time because you do it by hand or with scripts that are tested just two times a year.

---

# How?

By using a software called Patroni

---

# Who is Patroni?

Patroni is a **template** for high availability (HA) PostgreSQL solutions using Python. For maximum accessibility, Patroni supports a variety of **distributed configuration stores** like ZooKeeper, etcd, Consul or Kubernetes. Database engineers, DBAs, DevOps engineers, and SREs who are looking to quickly deploy HA PostgreSQL in datacenters — or anywhere else — will hopefully find it useful.

Patroni is a postgres process orchestrator and template engine. Its ...

- Create your postgres configs from the Patroni config
- Monitors your postgres process

---

# Disaster Recovery - What if your datacenter is burning

Use OVH Picture

---

## src: ../../reuse/outro.md
