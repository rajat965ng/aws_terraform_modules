resource "aws_vpc" "main" {
  cidr_block = var.cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
    Environment = var.env
  }
}

resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}_${var.region}b_private_subnet"
    Environment = var.env
  }
}


resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.region}c"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}_${var.region}c_public_subnet"
    Environment = var.env
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.env}_private_route_table"
    Environment = var.env
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.env}_public_route_table"
    Environment = var.env
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  subnet_id = "${aws_subnet.private_subnet.id}"
}


resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
}

resource "aws_eip" "nat_eip" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "${var.env}_igw"
    Environment = var.env
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat"
    Environment = var.env
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_route" "public_internet_gateway" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  gateway_id = "${aws_internet_gateway.igw.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_security_group" "main" {
  vpc_id = "${aws_vpc.main.id}"
  name = "${var.name}_default_sg"
  depends_on  = [aws_vpc.main]

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    self = true
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "ssh"
  }

  tags = {
    Environment = var.env
  }
}
