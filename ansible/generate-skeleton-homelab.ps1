# Define root path
$Root = "C:\Users\korisnik\ansible"

# Define roles
$Roles = @(
    "base_os",
    "libvirt",
    "pfsense_vm",
    "k8s_install",
    "k8s_networking",
    "k8s_storage",
    "apps_homeassistant",
    "apps_grafana",
    "apps_postgres",
    "apps_jenkins",
    "apps_argocd"
)

# Create root folders
New-Item -ItemType Directory -Force -Path "$Root\inventory"
New-Item -ItemType Directory -Force -Path "$Root\group_vars"
New-Item -ItemType Directory -Force -Path "$Root\playbooks"
New-Item -ItemType Directory -Force -Path "$Root\collections"

# Write ansible.cfg
Set-Content -Path "$Root\ansible.cfg" -Value @"
[defaults]
inventory = ./inventory/hosts.yaml
roles_path = ./roles
host_key_checking = False
retry_files_enabled = False
stdout_callback = yaml
collections_paths = ./collections
"@

# Create inventory/hosts.yaml
Set-Content -Path "$Root\inventory\hosts.yaml" -Value @"
all:
  hosts:
    rocky_host:
      ansible_host: 192.168.1.100
      ansible_user: your_user
  children:
    k8s_nodes:
      hosts:
        rocky_host:
"@

# Create group_vars/all.yaml
Set-Content -Path "$Root\group_vars\all.yaml" -Value @"
nvme_mount_point: "/mnt/data"
k8s_version: "1.33.2"
common_packages:
  - vim
  - curl
  - wget
  - git
  - net-tools

pfsense:
  iso_path: "{{ nvme_mount_point }}/iso/netgate-installer-amd64.iso"
  vm_disk_path: "{{ nvme_mount_point }}/vms/pfsense.qcow2"
  vm_disk_size_gb: 20
  vm_memory_mb: 2048
  vm_vcpus: 2
  lan_network: "virbr-lan"
  wan_network: "default"
"@

# Create group_vars/k8s_nodes.yaml
Set-Content -Path "$Root\group_vars\k8s_nodes.yaml" -Value @"
k8s_pod_network_cidr: ""10.244.0.0/16""
k8s_service_cidr: ""10.96.0.0/12""
"@

# Create requirements.yaml
Set-Content -Path "$Root\requirements.yaml" -Value @"
---
collections:
  - name: community.general
  - name: kubernetes.core
"@

# Create playbooks for all stages
$Playbooks = @(
    "01_base_os",
    "02_libvirt",
    "03_opnsense_vm",
    "04_k8s_install",
    "05_k8s_networking",
    "06_k8s_storage",
    "07_apps"
)

foreach ($pb in $Playbooks) {
    $roleName = $pb.Substring(3)
    Set-Content -Path "$Root\playbooks\$pb.yaml" -Value @"
- hosts: rocky_host
  become: yes
  roles:
    - $roleName
"@
}

# Create role skeleton with best practice folders and starter files
foreach ($role in $Roles) {
    $RoleRoot = "$Root\roles\$role"

    # Create folders
    New-Item -ItemType Directory -Force -Path "$RoleRoot\tasks"
    New-Item -ItemType Directory -Force -Path "$RoleRoot\defaults"
    New-Item -ItemType Directory -Force -Path "$RoleRoot\handlers"
    New-Item -ItemType Directory -Force -Path "$RoleRoot\files"
    New-Item -ItemType Directory -Force -Path "$RoleRoot\templates"
    New-Item -ItemType Directory -Force -Path "$RoleRoot\meta"

    # Add .gitkeep to empty folders
    Set-Content -Path "$RoleRoot\files\.gitkeep" -Value ""
    Set-Content -Path "$RoleRoot\templates\.gitkeep" -Value ""

    # Create tasks/main.yaml with starter example
    Set-Content -Path "$RoleRoot\tasks\main.yaml" -Value @"
- name: Placeholder task for role '$role'
  debug:
    msg: ""Role $role executed.""
"@

    # Create defaults/main.yaml with empty dict
    Set-Content -Path "$RoleRoot\defaults\main.yaml" -Value @"
# Default variables for role '$role'
"@

    # Create handlers/main.yaml with placeholder
    Set-Content -Path "$RoleRoot\handlers\main.yaml" -Value @"
# Handlers for role '$role'
- name: restart service
  service:
    name: your_service
    state: restarted
"@

    # Create meta/main.yaml with dependencies example
    Set-Content -Path "$RoleRoot\meta\main.yaml" -Value @"
dependencies: []
"@
}

Write-Host "⭐️ Ansible skeleton created at $Root with best practices!" -ForegroundColor Green
