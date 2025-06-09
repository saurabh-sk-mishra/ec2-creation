provider "aws" {
  region = "us-east-1" # change if needed
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"   # Amazon Linux 2 in us-east-1 (change per region)
  instance_type = "t2.micro"

  key_name = "your-key-pair-name"          # Replace with your actual key pair
  tags = {
    Name = "MyFirstEC2"
  }

  # Optional: Add a security group inline
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Be cautious with this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
