
provider "aws" {
  region = "us-east-1"
}
# ------------------------------
# VPC ad Subnet
# ------------------------------

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet"
  }
}

# ------------------------------
# Security Group for HTTP Access
# ------------------------------
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (restrict for better security)
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH"
  }
}

# ------------------------------
# Ubuntu Instances
# ------------------------------

resource "aws_instance" "linux_server" {
  count           = 4
  ami             = "ami-0e2c8caa4b6378d8c" # Free-tier Ubuntu 24.04 LTS AMI ID for us-east-1
  instance_type   = "t2.micro"              # Free-tier eligible instance type
  subnet_id       = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "LinuxServer-${count.index + 1}"
  }

  # Key pair for SSH access (update with your key name)
  key_name = "mk" # Replace this with your existing key pair name mine is mk
}

output "server_ips" {
  value = aws_instance.linux_server.*.public_ip
}
