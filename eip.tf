resource "aws_eip" "eip" {

  vpc                       = true
  depends_on                = ["aws_internet_gateway.gw"]
  associate_with_private_ip = "10.0.1.11"
}

