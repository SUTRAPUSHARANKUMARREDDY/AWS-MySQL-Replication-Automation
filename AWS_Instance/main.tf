resource "aws_instance" "instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.volume_type
  }

  disable_api_termination = var.disable_api_termination
}

resource "null_resource" "instance_ready" {
  count = var.instance_count

  depends_on = [aws_instance.instance]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = aws_instance.instance[count.index].public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Instance is up and running'"
    ]
  }
}
