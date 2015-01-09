resource "aws_instance" "db" {
  key_name = "${var.key_name}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "t1.micro"
  tags {
    Name = "tf-demo-db"
    Project = "${var.project}"
  }
  #subnet_id = "${aws_subnet.tf-demo-net.id}"
  security_groups = ["${aws_security_group.default.name}"]
  
}

resource "aws_route53_record" "tf-demo-db-record" {
  name = "${concat("db",".", aws_route53_zone.primary.name)}"
  zone_id = "${aws_route53_zone.primary.zone_id}"
  type = "A"
  records = [ "${aws_instance.db.public_ip}" ]
  ttl = "1"
}
