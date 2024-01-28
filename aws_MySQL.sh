#!/bin/bash

# Define Variables
TF_DIR="/home/sharan/Documents/vs_code/Mediam_Blog/AWS_Instance"
ANSIBLE_DIR="/home/sharan/Documents/vs_code/Mediam_Blog/mysql_replication_set"
INVENTORY_FILE="$ANSIBLE_DIR/hosts.ini"

# Terraform execution
cd "$TF_DIR"
terraform init
terraform apply -auto-approve

# Extract instance IPs and create inventory file
echo "[mysql_servers]" > "$INVENTORY_FILE"
INSTANCE_PUBLIC_IPS=$(terraform output -json instance_public_ips | jq -r '.[]')
INSTANCE_PRIVATE_IPS=$(terraform output -json instance_private_ips | jq -r '.[]')

# Use paste to merge the lines from the two commands
paste <(echo "$INSTANCE_PUBLIC_IPS") <(echo "$INSTANCE_PRIVATE_IPS") | while IFS=$'\t' read -r IP_PUBLIC IP_PRIVATE; do
    echo "$IP_PUBLIC ansible_user=ubuntu ansible_ssh_private_key_file=/home/sharan/Documents/vs_code/Mediam_Blog/DBtest.pem" >> "$INVENTORY_FILE"
done

# Check if inventory file is created
if [ ! -f "$INVENTORY_FILE" ]; then
    echo "Inventory file not created"
    exit 1
fi

# Ansible playbook execution
cd "$ANSIBLE_DIR"
ansible-playbook mysql_replication_setup.yml