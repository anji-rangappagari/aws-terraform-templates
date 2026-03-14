resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my_first_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    
    }
  ingress {
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
}

resource "aws_instance" "my_ec2_instance1" {
  ami           = var.ami_id # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet1.id
  security_groups = [aws_security_group.allow_ssh.id]
  user_data = file("${path.module}/user_data1.sh")

  tags = {
    Name = "MyFirstEC2Instance"
  }
}
resource "aws_instance" "my_ec2_instance2" {
  ami           = var.ami_id # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet2.id
  security_groups = [aws_security_group.allow_ssh.id]
  user_data = file("${path.module}/user_data2.sh")


  tags = {
    Name = "MyFirstEC2Instance"
  }
}

resource "aws_eip" "my_eip1" {
  instance = aws_instance.my_ec2_instance1.id
}
resource "aws_eip" "my_eip2" {
  instance = aws_instance.my_ec2_instance2.id
}
