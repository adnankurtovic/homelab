# homelab

# Homelab - Automation with Ansible

This repository contains Ansible playbooks and documentation for automating the setup of my personal homelab on a Lenovo ThinkCentre M920q running Rocky Linux.

## 📜 Overview

This homelab project uses DevOps practices to provision and configure:

- A Rocky Linux 10 host system with KVM/libvirt for virtualization.
- A pfSense VM for routing, firewall, and network isolation.
- A Home Assistant VM for smart home management.
- A Kubernetes (k8s) cluster on the Rocky Linux host for running:
  - Grafana (monitoring)
  - Prometheus (metrics collection)
  - Loki (logs)
  - Additional DevOps tools for learning (e.g. Jenkins, ArgoCD, etc.)

---

## 🗺️ Planned Architecture

[Internet]
|
[Home Wi-Fi Router] ---(Wi-Fi)--> [Lenovo ThinkCentre M920q (Rocky Linux)]
|
[pfSense VM]
/          |
[LAN port] [WAN over Wi-Fi]
|
[TP-Link TL-WR740N Router]
|
[Smart Home / IoT Devices on Separate SSID]

- pfSense VM provides a fully isolated LAN subnet for IoT devices.
- The Rocky Linux host bridges the WAN interface over Wi-Fi and the LAN interface over its Ethernet port.
- TP-Link router connected to the ThinkCentre's LAN port provides extra ports and Wi-Fi SSID for smart home devices.

---

## ⚙️ Components

| Component                  | Role                                          | Deployment              |
|----------------------------|-----------------------------------------------|-------------------------|
| **Rocky Linux 10**         | Host OS                                       | Bare metal              |
| **KVM/Libvirt**            | Virtualization for pfSense and Home Assistant | Managed via Ansible     |
| **pfSense VM**             | Network routing, firewall, VLAN separation    | KVM VM                  |
| **Home Assistant VM**      | Smart home automation platform                | KVM VM                  |
| **Kubernetes (k8s)**       | Container orchestration                       | Single node on Rocky Linux |
| **local-path-provisioner** | Local storage provisioner for Kubernetes      | Kubernetes              |
| **Grafana**                | Monitoring and dashboards                     | Kubernetes              |
| **Prometheus**             | Metrics collection                            | Kubernetes              |
| **Other DevOps Tools**     | Learning and experimentation                  | Kubernetes              |

---

## 🚀 Goals

✅ Automate installation and configuration with Ansible
✅ Isolate IoT/Smart Home devices on a separate subnet
✅ Learn and practice:
  - Infrastructure-as-Code
  - Virtualization
  - Networking
  - Kubernetes
  - Monitoring and logging
  - CI/CD and DevOps tools

---

## 📦 Repository Structure

Example planned layout:

ansible/
├── inventory/
│   └── hosts.yaml
├── roles/
│   ├── base_os/
│   ├── libvirt/
│   ├── pfsense_vm/
│   ├── k8s_install/
│   ├── k8s_networking/
│   ├── k8s_storage/
│   │   └── files/
│   │       └── local-path-provisioner.yaml
│   ├── apps_grafana/
│   └── apps_jenkins/
├── playbooks/
│   ├── 01_base_os.yaml
│   ├── 02_libvirt.yaml
│   ├── 03_pfsense_vm.yaml
│   ├── 04_k8s_install.yaml
│   ├── 05_k8s_networking.yaml
│   ├── 06_k8s_storage.yaml
│   └── 07_apps.yaml
├── collections/
├── group_vars/
│   ├── all.yaml
│   └── k8s_nodes.yaml
├── requirements.yaml
├── ansible.cfg
└── generate-skeleton-homelab.ps1

- **inventories/**: Define hosts and groups.
- **roles/**: Reusable roles for configuring each part of the system.
- **playbooks/**: Entry points for Ansible runs.
- **generate-skeleton-homelab.ps1**: Helper PowerShell script used to create Ansible skeleton.

---

## 🛠️ Usage

⚡ Example Ansible commands:

```bash
ansible-playbook -i inventory/hosts.yaml playbooks/02_libvirt.yaml
```

## 📝 Requirements

Rocky Linux 10.0 (Red Quartz) host
Ansible 2.18+
libvirt and QEMU installed
SSH access to host
Sufficient disk space for VMs
Internet connection over Wi-Fi

## 💡 Notes and Considerations

pfSense VM:

Needs bridged networking.
WAN interface = Wi-Fi adapter.
LAN interface = Physical Ethernet NIC.

Home Assistant VM:
Runs as a dedicated VM for best USB/Zigbee/Z-Wave support.

Kubernetes:
Single-node deployment.
Lightweight manifests for Grafana, Prometheus, etc.

Optimization:
Memory is limited (16 GB).
Use minimal VM specs.
Limit number of running pods and services.

## 🤝 Contributing

PRs welcome! This is primarily for personal learning and use, but improvements and fixes are always appreciated.

## 📜 License

MIT License