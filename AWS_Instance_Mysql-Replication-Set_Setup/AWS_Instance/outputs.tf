output "instance_ids" {
  value = [for inst in aws_instance.instance : inst.id]
}

output "instance_public_ips" {
  value = [for inst in aws_instance.instance : inst.public_ip]
}

output "instance_private_ips" {
  value = [for inst in aws_instance.instance : inst.private_ip]
}

# output for Terratest testing
output "aws_region" {
  value = var.aws_region
}

output "instance_ips" {
  value = [for inst in aws_instance.instance : inst.public_ip]
}