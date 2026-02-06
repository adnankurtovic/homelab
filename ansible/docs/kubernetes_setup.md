# Kubernetes Setup

This document details the configuration of the Kubernetes cluster.

## 1. Distribution

We are using the standard Kubernetes distribution, installed and managed by `kubeadm`. This provides a robust and well-supported foundation for the cluster.

## 2. Networking

-   **CNI:** The cluster uses [Flannel](https://github.com/flannel-io/flannel) as the Container Network Interface (CNI). It is installed by applying the official manifest.
-   **Pod CIDR:** `10.244.0.0/16`
-   **Service CIDR:** `10.96.0.0/12`

## 3. Storage

The `k8s_storage` role is currently a placeholder. A storage solution needs to be implemented to provide persistent storage for stateful applications.

**Proposed Solution:**
-   **Provisioner:** `local-path-provisioner`. This is a good choice for a single-node cluster as it uses the host's local filesystem for storage.
-   **StorageClass:** A default StorageClass should be created to automatically provision PersistentVolumes.

## 4. Application Deployment

Applications will be deployed to the Kubernetes cluster using a combination of Ansible, Helm, and GitOps principles.

-   **Ansible:** The initial deployment of applications will be managed by Ansible roles (e.g., `apps_homeassistant`, `apps_grafana`).
-   **Helm:** Where possible, Helm charts will be used to package and deploy applications.
-   **ArgoCD:** ArgoCD will be used to implement GitOps. It will monitor the GitHub repository for changes to application manifests and automatically apply them to the cluster. This ensures that the state of the cluster is always in sync with the code in the repository.
-   **Jenkins:** Jenkins will be used for CI/CD pipelines to automate the testing and deployment of applications.
