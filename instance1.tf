resource "aws_instance" "nginx" {
ami                         = "ami-0b419c3a4b01d1859"
instance_type               = "t2.micro"
key_name                    = "tamizh"
monitoring                  = true
vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
subnet_id                   = "${aws_subnet.public_subnet.id}"

#provisioner "file" {
#    source      = "nginx.conf"
#    destination = "/home/ec2-user/"
#  }




associate_public_ip_address = true  tags {
  Name        = "tamizh"
  }

user_data = <<HEREDOC
#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
yum update -y
yum install wget -y
yum install nginx -y 

yum install git -y


service nginx start

rm -rf /etc/nginx/nginx.conf

cd /etc/nginx/
wget https://raw.githubusercontent.com/Tamilvananb/nginx.conf/master/nginx.conf
#git clone https://github.com/Tamilvananb/nginx.conf.git

systemctl restart nginx 

HEREDOC

}
