resource "aws_instance" "www" {
  connection {
    # The default username for our AMI
    user = "ubuntu"
    # The path to your keyfile
    key_file = "${var.key_path}"
  }

  count = "${var.www_count}"
  key_name = "${var.key_name}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "t1.micro"
  tags {
    Name = "tfdemo-www-${count.index}"
    Project = "tf-demo"
  }

  security_groups = ["${aws_security_group.default.name}"]

  provisioner "remote-exec" {
    inline = [
    "sudo apt-get -y update",
    "sudo apt-get -y install nginx",
    "sudo service nginx start"
    ]
  }

}

resource "aws_route53_record" "tf-demo-www-record" {
  name = "${concat("www", count.index,".", aws_route53_zone.primary.name)}"
  count = "${var.www_count}"
  zone_id = "${aws_route53_zone.primary.zone_id}"
  type = "A"
  records = ["${element(aws_instance.www.*.public_ip, count.index)}"]
  ttl = "1"
}
