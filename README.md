# AWS MySQL Replication Setup with Terraform and Ansible
This project automates the setup of a MySQL replication set on AWS EC2 instances. The provided shell script `aws_MySQL.sh` initializes and applies Terraform configurations, generates an Ansible inventory file with the provisioned EC2 instance details, and finally runs an Ansible playbook to configure MySQL replication.

## Prerequisites
Before you begin, ensure you have the following:
- An AWS account with permissions to create EC2 instances, security groups, and key pairs.
- Terraform (version that complies with the provider used in `Provider.tf`).
- Ansible (2.9 or later recommended).
- The `jq` command-line JSON processor installed on your system.
- The AWS CLI installed and configured with appropriate credentials.
- An existing SSH key pair for AWS EC2 instances.

## Configuration
You need to modify the following variables in the Terraform configuration to match your AWS environment:
- `aws_region`: AWS region where resources will be created.
- `instance_type`: Type of EC2 instance (e.g., `t2.micro`).
- `ami_id`: AMI ID of the instance image.
- `subnet_id`: Subnet ID where instances will be launched.
- `instance_name`: Name tag that will be assigned to the instances.
- `key_pair_name`: Name of the AWS EC2 key pair.
- `security_group_id`: Security group ID to be attached to instances.
- `instance_count`: Number of instances to create for replication set.
- `private_key_path`: Local path to your SSH private key file.

These variables are located in the `variables.tf` file within the `AWS_Instance` directory.

## Usage
To launch the setup, run the `aws_MySQL.sh` script from your terminal:

./aws_MySQL.sh

Ensure that the script has executable permissions. If not, run `chmod +x aws_MySQL.sh` to make it executable.

## What Does the Script Do?
1. Terraform Initialization and Application: The script changes into the Terraform directory and runs `terraform init` followed by `terraform apply -auto-approve` to provision the AWS resources.

2. nsible Inventory Creation: Once the instances are provisioned, the script extracts their public and private IP addresses and creates an Ansible inventory file `hosts.ini`.

3. Ansible Playbook Execution: With the inventory file in place, the script then runs the Ansible playbook `mysql_replication_setup.yml` to configure MySQL replication among the instances.

## Important Notes
- The security group associated with your instances must allow inbound traffic on port 3306 for MySQL and port 22 for SSH.
- Ensure that your SSH private key has the correct permissions set (`chmod 400`).
- The Terraform state is assumed to be local. If you're using remote state, you'll need to modify the script accordingly.
- Modify the `aws_MySQL.sh` script with the correct paths to your Terraform and Ansible directories.

## Troubleshooting
If you encounter any issues during the execution, check the following:

- AWS CLI is correctly configured with the necessary permissions.
- The specified SSH key pair exists in your AWS account and the private key is present at the specified `private_key_path`.
- The Terraform and Ansible configurations are correctly set for your AWS environment.
- Network connectivity to AWS is established.