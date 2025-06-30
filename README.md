# homelab



\# Homelab Automation with Ansible



This repository contains Ansible playbooks and documentation for automating the setup of my personal homelab on a Lenovo ThinkCentre M920q running Rocky Linux.



\## 📜 Overview



This homelab project uses DevOps practices to provision and configure:



\- A Rocky Linux 9 host system with KVM/libvirt for virtualization.

\- A pfSense VM for routing, firewall, and network isolation.

\- A Home Assistant VM for smart home management.

\- A Kubernetes (k8s) cluster on the Rocky Linux host for running:

&nbsp; - Grafana (monitoring)

&nbsp; - Prometheus (metrics collection)

&nbsp; - Loki (logs)

&nbsp; - Additional DevOps tools for learning (e.g. Jenkins, ArgoCD, etc.)



---



\## 🗺️ Planned Architecture



\[Internet]

|

\[Home Wi-Fi Router] ---(Wi-Fi)--> \[Lenovo ThinkCentre M920q (Rocky Linux)]

|

\[pfSense VM]

/          |

\[LAN port] \[WAN over Wi-Fi]

|

\[TP-Link TL-WR740N Router]

|

\[Smart Home / IoT Devices on Separate SSID]





\- pfSense VM provides a fully isolated LAN subnet for IoT devices.

\- The Rocky Linux host bridges the WAN interface over Wi-Fi and the LAN interface over its Ethernet port.

\- TP-Link router connected to the ThinkCentre's LAN port provides extra ports and Wi-Fi SSID for smart home devices.



---



\## ⚙️ Components



| Component              | Role                                          | Deployment              |

|------------------------|-----------------------------------------------|-------------------------|

| \*\*Rocky Linux 10\*\*     | Host OS                                       | Bare metal              |

| \*\*KVM/Libvirt\*\*        | Virtualization for pfSense and Home Assistant | Managed via Ansible     |

| \*\*pfSense VM\*\*         | Network routing, firewall, VLAN separation    | KVM VM                  |

| \*\*Home Assistant VM\*\*  | Smart home automation platform                | KVM VM                  |

| \*\*Kubernetes (k3s or full k8s)\*\* | Container orchestration             | Single node on Rocky Linux |

| \*\*Grafana\*\*            | Monitoring and dashboards                     | Kubernetes              |

| \*\*Prometheus\*\*         | Metrics collection                            | Kubernetes              |

| \*\*Other DevOps Tools\*\* | Learning and experimentation                  | Kubernetes              |



---



\## 🚀 Goals



✅ Automate installation and configuration with Ansible  

✅ Isolate IoT/Smart Home devices on a separate subnet  

✅ Learn and practice:

\- Infrastructure-as-Code

\- Virtualization

\- Networking

\- Kubernetes

\- Monitoring and logging

\- CI/CD and DevOps tools



---



\## 📦 Repository Structure



Example planned layout:





ansible/

├── inventory/

│ └── hosts.yaml

├── roles/

│ ├── base\_os/

│ ├── libvirt/

│ ├── pfsense\_vm/

│ ├── k8s\_install/

│ ├── k8s\_networking/

│ ├── k8s\_storage/

│ ├── apps\_grafana/

│ └── apps\_jenkins/

└── playbooks/

│ ├── 01\_base\_os.yaml

│ ├── 02\_libvirt.yaml

│ ├── 03\_pfsense\_vm.yaml

│ ├── 04\_k8s\_install.yaml

│ ├── 05\_k8s\_networking.yaml

│ ├── 06\_k8s\_storage.yaml

│ ├── 07\_apps.yaml

└── requirements.yaml





\- \*\*inventories/\*\*: Define hosts and groups.

\- \*\*roles/\*\*: Reusable roles for configuring each part of the system.

\- \*\*playbooks/\*\*: Entry points for Ansible runs.



---



\## 🛠️ Usage



⚡ Example Ansible commands:



```bash

ansible-playbook -i inventory/hosts.yaml playbooks/02\_libvirt.yaml 





\## 📝 Requirements



Rocky Linux 9 host

Ansible 2.14+

libvirt and QEMU installed

SSH access to host

Sufficient disk space for VMs

Internet connection over Wi-Fi





\## 💡 Notes and Considerations

pfSense VM:



Needs bridged networking.

WAN interface = Wi-Fi adapter.

LAN interface = Physical Ethernet NIC.



Home Assistant VM:

Runs as a dedicated VM for best USB/Zigbee/Z-Wave support.



Kubernetes:

Single-node deployment (recommended: k3s for simplicity).

Lightweight manifests for Grafana, Prometheus, etc.



Optimization:

Memory is limited (16 GB).

Use minimal VM specs.

Limit number of running pods and services.



\## 🤝 Contributing

PRs welcome! This is primarily for personal learning and use, but improvements and fixes are always appreciated.

