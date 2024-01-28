variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of instance to start."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instance."
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
  # Replace with a default subnet ID as per your AWS setup
  default     = "subnet-0fbd1677d8c4ec715"
}

variable "instance_name" {
  description = "The name tag of the instance."
  type        = string
  default     = "UbuntuInstance"
}

variable "user_data" {
  description = "User data to be used on this instance."
  type        = string
  default     = <<EOF
                #!/bin/bash
                apt-get update
                apt-get install -y vim
                EOF
}

variable "root_volume_size" {
  description = "The size of the root EBS volume in GB."
  type        = number
  default     = 30
}

variable "volume_type" {
  description = "The type of EBS volume."
  type        = string
  default     = "gp3"
}

variable "disable_api_termination" {
  description = "Enable or disable termination protection for the instance."
  type        = bool
  default     = true
}

variable "key_pair_name" {
  description = "The name of the existing key pair to be used for the EC2 instance."
  type        = string
  default     = "DBtest"
}

variable "security_group_id" {
  description = "The ID of the existing security group to be attached to the EC2 instance."
  type        = string
  default     = "sg-0df697b8fd2b2cdab"
}

variable "instance_count" {
  description = "Number of instances to create."
  type        = number
  default     = 3  # You can change this default value as needed
}

variable "private_key_path" {
  description = "Path to the private key file used for SSH connection"
  type        = string
  default     = "/home/sharan/Documents/vs_code/Mediam_Blog/DBtest.pem"
}

