resource "aws_instance" "web" {
ami                         = "ami-0b419c3a4b01d1859"
instance_type               = "t2.micro"
key_name                    = "tamizh"
monitoring                  = true
vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
subnet_id                   = "${aws_subnet.private_subnet.id}"
private_ip                  = "10.0.1.11"
associate_public_ip_address = false  tags {
  Name        = "tamizh2"
  }

# network_interface {
#    network_interface_id = "${aws_network_interface.web.id}"
#    device_index         = 0
#  }


user_data = <<HEREDOC
#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
sudo yum update -y
sudo amazon-linux-extras install -y php7.2
sudo yum install httpd -y
service start httpd 
yum install git -y
cd /var/www/html/
git clone https://github.com/Tamilvananb/phpcodelogin.git
cd phpcodelogin/
mv * /var/www/html/

yum install wget -y

#wget https://dev.mysql.com/get/mysql57-community-release-el6-11.noarch.rpm

#yum localinstall mysql57-community-release-el6-11.noarch.rpm -y
#yum remove mysql55 mysql55-common mysql55-libs mysql55-server -y

#yum install epel-release yum-utils -y
#yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
#yum-config-manager --enable remi-php70 -y


yum install mysql -y
yum install mysql-server -y
service mysqld restart




systemctl restart httpd
cd /var/www/html/
mysql -h wpdb.cdy9kerizbgn.ap-southeast-1.rds.amazonaws.com -u tamizh -pmypassword -D wordpress_db < table.sql

HEREDOC
}
