resource "aws_instance" "default" {
  ami                    = data.aws_ami.arm64.id
  instance_type          = var.instance_type
  ebs_optimized          = true
  key_name               = aws_key_pair.default.key_name
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.default.id]

  root_block_device {
    delete_on_termination = false
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    encrypted             = false
  }

  tags = merge(var.common_tags, {
    Name = "${var.resource_prefix}-default"
  })
}

resource "aws_key_pair" "default" {
  key_name   = "${var.resource_prefix}-default-keypair"
  public_key = var.public_key
}

resource "aws_volume_attachment" "fvm_archive_pl_1" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.default.id
  volume_id   = aws_ebs_volume.fvm_archive_pl_1.id
}

resource "aws_volume_attachment" "fvm_archive_pl_2" {
  device_name = "/dev/sdg"
  instance_id = aws_instance.default.id
  volume_id   = aws_ebs_volume.fvm_archive_pl_2.id
}

resource "aws_volume_attachment" "fvm_archive_pl_3" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.default.id
  volume_id   = aws_ebs_volume.fvm_archive_pl_3.id
}

resource "aws_volume_attachment" "fvm_archive_pl_4" {
  device_name = "/dev/sdi"
  instance_id = aws_instance.default.id
  volume_id   = aws_ebs_volume.fvm_archive_pl_4.id
}
