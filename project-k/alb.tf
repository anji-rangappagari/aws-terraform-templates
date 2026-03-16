
resource "aws_lb" "myalb" {
    name_prefix = "myalb"
    internal    = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.allow_ssh.id]
    subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

resource "aws_lb_target_group" "my_target_group" {
    name = "mytg"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.my_first_vpc.id
    
    health_check {
      path                = "/"
      interval            = 30
      timeout             = 10
      healthy_threshold   = 2
      unhealthy_threshold = 5
    }
}   

resource "aws_lb_listener" "my_listener" {
    load_balancer_arn = aws_lb.myalb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.my_target_group.arn
    }
}

resource "aws_lb_target_group_attachment" "my_attachment" {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    target_id        = aws_instance.my_ec2_instance1.id
    port             = 80
}

resource "aws_lb_target_group_attachment" "my_attachment2" {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    target_id        = aws_instance.my_ec2_instance2.id
    port             = 80
} 
