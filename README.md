# homelab

# Homelab - Automation with Ansible

This repository contains Ansible playbooks and documentation for automating the setup of my personal homelab on a Lenovo ThinkCentre M920q running Rocky Linux.

## 🎯 Project Goal

The primary goal of this project is to completely automate the deployment and configuration of a home lab environment using Ansible. This includes provisioning the base operating system, setting up virtualization, deploying a Kubernetes cluster, and installing various applications.

---

## 💻 Technology Stack

### Hardware
- **Compute:** Lenovo Mini PC (16GB RAM, 2 NICs)
- **Storage:** D-Link DNS320 NAS
- **Networking:** TP-Link 720n (acting as a switch and wireless access point)

### Software
| Component                  | Role                                          | Deployment              |
|----------------------------|-----------------------------------------------|-------------------------|
| **Host OS**                | Rocky Linux 10                                | Bare metal              |
| **Virtualization**         | KVM/QEMU managed by `libvirt`                 | Managed via Ansible     |
| **Firewall/Router**        | pfSense                                       | KVM VM                  |
| **Container Orchestration**| Kubernetes (k8s), installed via `kubeadm`     | Single node on Rocky Linux |
| **Configuration Mgmt**     | Ansible                                       | Bare metal/VM           |
| **local-path-provisioner** | Local storage provisioner for Kubernetes      | Kubernetes              |
| **Home Assistant**         | Smart home automation platform                | Kubernetes/KVM VM       |
| **Grafana**                | Monitoring and visualization                  | Kubernetes              |
| **PostgreSQL**             | Database for various applications             | Kubernetes              |
| **Jenkins**                | CI/CD pipelines                               | Kubernetes              |
| **ArgoCD**                 | GitOps-based continuous delivery              | Kubernetes              |
| **Nextcloud**              | File storage and collaboration (to be implemented) | Kubernetes              |
| **Terraform**              | Infrastructure as Code for Kubernetes applications | Kubernetes              |

---

## 🏛️ Architecture

The architecture is designed in layers, with each layer building upon the previous one:

1.  **Host Layer:** A bare-metal Lenovo Mini PC running Rocky Linux 10 serves as the foundation.
2.  **Virtualization Layer:** `libvirt` is installed on the host to manage virtual machines. A pfSense VM is created to act as the primary router and firewall for the entire home network. It is connected to a dedicated physical NIC via a Linux bridge.
3.  **Orchestration Layer:** A standard Kubernetes (k8s) cluster is installed on the Rocky Linux host. This cluster will host all the home lab applications.
4.  **Application Layer:** Various applications are deployed on the Kubernetes cluster.

---

## 📦 Repository Structure

Example planned layout:
```
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
```

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
WAN interface = Physical Ethernet NIC (connected to router).
LAN interface = Physical Ethernet NIC (for internal LAN).

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