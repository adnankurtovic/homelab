# Project Overview

This document provides a high-level overview of the Homelab-as-Code project.

## 1. Goal

The primary goal of this project is to completely automate the deployment and configuration of a home lab environment using Ansible. This includes provisioning the base operating system, setting up virtualization, deploying a Kubernetes cluster, and installing various applications.

## 2. Technology Stack

### 2.1. Hardware
- **Compute:** Lenovo Mini PC (16GB RAM, 2 NICs)
- **Storage:** D-Link DNS320 NAS
- **Networking:** TP-Link 720n (acting as a switch and wireless access point)

### 2.2. Software
- **Host OS:** Rocky Linux 10
- **Virtualization:** KVM/QEMU managed by `libvirt`
- **Firewall/Router:** pfSense (running as a virtual machine)
- **Container Orchestration:** Kubernetes (k8s), installed via `kubeadm`
- **Configuration Management:** Ansible
- **Infrastructure as Code (Apps):** Terraform

## 3. Architecture

The architecture is designed in layers, with each layer building upon the previous one:

1.  **Host Layer:** A bare-metal Lenovo Mini PC running Rocky Linux 10 serves as the foundation.

2.  **Virtualization Layer:** `libvirt` is installed on the host to manage virtual machines. A pfSense VM is created to act as the primary router and firewall for the entire home network. It is connected to a dedicated physical NIC via a Linux bridge.

3.  **Orchestration Layer:** A standard Kubernetes (k8s) cluster is installed on the Rocky Linux host. This cluster will host all the home lab applications.

4.  **Application Layer:** Various applications are deployed on the Kubernetes cluster using Terraform, including:
    - **Home Assistant:** For smart home automation.
    - **Grafana:** For monitoring and visualization.
    - **PostgreSQL:** As a database for various applications.
    - **Jenkins:** For CI/CD pipelines.
    - **ArgoCD:** For GitOps-based continuous delivery.
    - **Nextcloud:** For file storage and collaboration (to be implemented).
