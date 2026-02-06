# Development Guide

This guide provides instructions for developers and AI agents on how to contribute to and manage this project.

## 1. Ansible Project Structure

The project follows the standard Ansible project structure:

-   `inventory/`: Contains the host inventory.
-   `group_vars/`: Contains variables applicable to groups of hosts.
-   `playbooks/`: Contains the main playbooks that orchestrate the deployment.
-   `roles/`: Contains the reusable Ansible roles. Each role is responsible for a specific component (e.g., `base_os`, `k8s_install`).
-   `requirements.yaml`: Defines the required Ansible collections.
-   `ansible.cfg`: Ansible configuration file.

## 2. Git Workflow

All development should be done on the `develop` branch.

1.  Ensure your local `develop` branch is up-to-date:
    ```bash
    git checkout develop
    git pull origin develop
    ```

2.  Create a new feature branch for your changes:
    ```bash
    git checkout -b feature/<your-feature-name>
    ```

3.  Make your changes and commit them.

4.  Push your feature branch to the remote repository:
    ```bash
    git push -u origin feature/<your-feature-name>
    ```

5.  Create a pull request on GitHub to merge your changes into the `develop` branch.

## 3. Running the Playbooks

The playbooks are designed to be run in a specific order to ensure dependencies are met.

To run a playbook, use the `ansible-playbook` command:

```bash
ansible-playbook -i inventory/hosts.yaml playbooks/<playbook_name>.yaml
```

The recommended execution order is:

1.  `01_base_os.yaml`
2.  `02_libvirt.yaml`
3.  `03_pfsense_vm.yaml`
4.  `04_k8s_install.yaml`
5.  `05_k8s_networking.yaml`
6.  `06_k8s_storage.yaml`
7.  `07_apps.yaml`
