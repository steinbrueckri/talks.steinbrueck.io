---
theme: apple-basic
colorSchema: dark
transition: slide-left
mdc: true
title: Postgres HA
---

# Please stand by ...

---
layout: intro-image-right
image: "https://steinbrueck.io/images/frontpage_hu43e9967b0bf6bb7f2b481dd27b1d2f56_703776_2500x0_resize_q75_box.jpg"
---

# Postgres HA

## with Patroni

### JUG Ingolstadt // 02.2024

---
src: ../../reuse/intro.md
---

---
src: ../../reuse/userlike.md
---

---
layout: image-right
image: "https://images.unsplash.com/photo-1593032053343-c85b7165e739?q=80&w=2448&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
---

# Why?

Managing a PostgreSQL cluster manually is a challenging task. There are several tools to managing postgresql clusters but there are mostly extrem complex and not easy.

- Manual Configuration and Management
- Failover and Recovery
- Leader Election
- Replication Monitoring
- Configuration Changes
- Scalability
- Maintenance and Upgrades

---

# Whats are the options?

- [pg_auto_failover]()
  - No DCS (Distributed Configuration Store)
  - Not really HA
- [stolon](https://github.com/sorintlab/stolon)
  - Project look unmaint
- [Repmgr](https://www.repmgr.org)
  - Requires more manual intervention
  - Does not offer an integrated solution for leader selection
- [Pacemaker](https://clusterlabs.org/pacemaker/)
  - The configuration can be very complex, especially for users who only want to work with PostgreSQL.
  - Not specifically designed for database clusters, which requires additional customization.

---
layout: image-right
image: https://source.unsplash.com/ac3hogazUGo
---

# But what is the better option?

### (At least in my opinion)

## Patroni

- Development by [Zalando](https://zalando.com)
- [Release in 2016](https://engineering.zalando.com/posts/2016/02/zalandos-patroni-a-template-for-high-availability-postgresql.html)
- Current release [v3.2.2](https://github.com/zalando/patroni/releases/tag/v3.2.2)
- supported PostgreSQL versions: 9.3 to 16

## Who its works

- Templates PostgreSQL config files
- Distributed configuration stores like ZooKeeper, etcd, Consul
- Monitors PostgreSQL process

---
layout: image-left
image: "https://source.unsplash.com/M5tzZtFCOfs"
---

# Demo

- Setup 3 Nodes
- Install Consul as DCS
- Install Postgres and Patroni
- Init new Database via Patroni
- Check the cluster
- Start demo application
- Failover

---
layout: image-left
image: https://media.makeameme.org/created/yaml-146d7cc2d1.jpg
---

# But first ...

## let's take a look on the config ...

---

# Patroni config - Basics

```yaml
name: database01 # Hostname
scope: database # Clustername

restapi:
  listen: 10.0.0.1:8008
  connect_address: 10.0.0.1:8008
  authentication:
    username: patroni
    password: patroni
```

The restapi is used that every Patroni instance can check the status of a member.

---

# Patroni config - DCS

- In our demo we will use consul because it have some benefits. ✨
- All server in our system have a running Consul instance at least in agent mode.
- Alternatively we can also use ZooKeeper, etcd, Kubernetes as DCS.

```yaml
consul:
  host: 127.0.0.1
  port: 8500
  scheme: http
```

---

# Patroni config - bootstrap, initdb and pg_basebackup

## or _something_ else ... we talk about that later

```yaml
# This section will be written into Etcd:/<namespace>/<scope>/config after initializing new cluster
bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 10
    postgresql:
      use_pg_rewind: true
      use_slots: false
      parameters:
        wal_level: "replica"
        unix_socket_directories: "/var/run/postgresql/."

  initdb:
    - encoding: UTF8
    - data-checksums

  users:
    admin:
      password: admin%
      options:
        - createrole
        - createdb
```

---

# Patroni config - postgresql settings

```yaml
postgresql:
  listen: 127.0.0.1:5432
  connect_address: 127.0.0.1:5432
  pg_hba:
    - "local   all     postgres    peer"
    - "host    all     all         10.0.0.1/24 md5"
  data_dir: /var/lib/postgres/
  bin_dir: /usr/lib/postgresql/15/bin/
  authentication:
    replication:
      username: replicator
      password: rep-pass
    superuser:
      username: postgres
      password: postgres
    rewind:
      username: rewind_user
      password: rewind_password
```

---
layout: intro-image-right
image: https://servocode.com/assets/src/images/blog/consul-12-12-min.png
---

# Why Consul?

Because Consul is also capable of service discovery.
By setting `register_service: True`, Patroni will register 2 services for us.

### Leader

`master.<clustername>.service.consul`
`primary.<clustername>.service.consul`

### ReadOnly Slave

`<clustername>.service.consul`

---

# Consul Service discovery

![](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dconsul%26version%3Drefs%252Fheads%252Frelease%252F1.17.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fwhat_is_service_discovery_3.png%26width%3D1856%26height%3D908&w=3840&q=75)

---
layout: image-left
image: "https://source.unsplash.com/KniBt27bEsc"
---

# Lets play with Patroni

- Start the demo app
- Master switch
- Add new slave

---
layout: image-right
image: "https://w.media/wp-content/uploads/ovhcloud-fire-the-stack.jpg"
---

# Disaster Recovery

## What if your cluster is burning

We have another friendly tool that works perfectly with Patroni.

Its called [pg_backrest](https://pgbackrest.org/)

> pgBackRest is a reliable backup and restore solution for PostgreSQL that seamlessly scales up to the largest databases and workloads.

---

# PgBackrest config

```txt
[global]
log-path=/var/log/pgbackrest/
backup-standby=y                                  # we makes backups from standby's via SSH
process-max=4                                     # upload wal with 4 processes to s3 / b2
archive-async=y                                   # wal upload is async
archive-get-queue-max=10GiB                       # local queue is limited to 10gb
repo1-s3-bucket=jugin-pgbackrest
repo1-s3-endpoint=s3.us-west-001.backblazeb2.com
repo1-s3-key=xxx
repo1-s3-key-secret=xxx
repo1-type=s3
repo1-s3-region=eu-central-1
repo1-retention-full=1                            # we keep one full backup
repo1-cipher-pass=jugin                           # our backups are encrypted
repo1-cipher-type=aes-256-cbc                     # BTW: repository index is 1
repo2-type=azure/cifs/gcs/posix/s3/sftp           # You can have multiple repositories of several types
[main]
pg1-path=/srv/postgres                            # Backup hosts also indexed
pg1-host-user=postgres                            # pg1 is the system itself
pg1-port=5432
pg2-path=/srv/postgres
pg2-host=database2                                # pg2 has the user and host attributes for the ssh connection
pg2-user=postgres                                 # ... ssh keys are already setuped
pg2-port=5432
...
```

---

# Patroni config changes - Bootstrap

## patroni.yml

```yaml
bootstrap:
  method: pgbackrest # default is pg_basebackup
  pgbackrest:
    command: /usr/local/bin/boot_pgbackrest.sh
    keep_existing_recovery_conf: False
    no_params: False
    recovery_conf:
      recovery_target_action: promote
      recovery_target_timeline: latest
      restore_command: pgbackrest --config=/etc/pgbackrest//pgbackrest.conf --stanza=main archive-get %f "%p"
```

## boot_pgbackrest.sh

```bash
#!/usr/bin/env bash

# NOTE: This command is wrapped in a scirpt because patroni add some additional
# flags that are unknown to pgbackrest.
# Ref.: https://github.com/zalando/patroni/issues/1223
/usr/bin/pgbackrest --config={{ pgbackrest_conf_path }} --stanza={{ pgbackrest_stanza_name }} --delta --link-all restore

```

---

# Patroni config changes - Postgresql parameters

```yaml
postgresql:
  parameters:
    archive_command: pgbackrest --config=/etc/pgbackrest/pgbackrest.conf --stanza=main archive-push "%p"
    archive_mode: "on"
    archive_timeout: "120s"
  create_replica_methods:
    - pgbackrest
    - basebackup
  pgbackrest:
    command: /usr/bin/pgbackrest --config=/etc/pgbackrest/pgbackrest.conf --stanza=main --log-level-file=detail --delta restore
    keep_data: True
    no_params: True
  basebackup:
    max-rate: "100M"
  recovery_conf:
    restore_command: pgbackrest --config=/etc/pgbackrest/pgbackrest.conf --stanza=main archive-get %f %p
```

---
layout: image-left
image: "https://source.unsplash.com/M5tzZtFCOfs"
---

# Demo

- Install PgBackrest
- Adjust config of Patroni
- Backup to Backblaze B2 (S3 compatible)
- Desaster recovery (If we have time ⌚)

---

# BTW: PostgreSQL is the DBMS of the Year 2023 🎉

PostgreSQL is our DBMS of the Year for the fourth time, after winning already three titles between 2017 and 2020. Almost 35 years ago, Postgres, as it was called back then, was initially released.

![](https://db-engines.com/pictures/doty2023.png)

https://db-engines.com/en/blog_post/106

---
layout: image-left
image: https://careers-static.coccoc.com/2022/03/6.jpeg
---

# What is with Kubernetes?

Pretty much the same just with more yaml ✨
Do you want to see a demo? 🖥

---
src: ../../reuse/outro.md
---
