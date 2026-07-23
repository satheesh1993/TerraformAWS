# Create VPC
resource "aws_vpc" "non_prod_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "non_prodvpc"

    }
      
}

resource "aws_flow_log" "np_flow_log" {
    log_destination_type = "cloud-watch-logs"
    iam_role_arn = aws_iam_role.vpc_flowlogs.arn
    log_destination = aws_cloudwatch_log_group.vpc_flow_log_np_gp.arn


    traffic_type = "ALL"
    max_aggregation_interval = "60"

 

    vpc_id = aws_vpc.non_prod_vpc.id

    tags = {
      name = "np-flowlogs"
    }
}

resource "aws_subnet" "public_subnet_np" {
    vpc_id = aws_vpc.non_prod_vpc.id
    cidr_block = var.public_subnet_webserver
    availability_zone = "ap-southeast-2a"
    tags = {
      "Name" = "WebServerSubnet"
    }
  
}

resource "aws_subnet" "private_subnet_np" {
    vpc_id = aws_vpc.non_prod_vpc.id
    cidr_block = var.private_subnet_db
    availability_zone = "ap-southeast-2b"
    tags = {
      Name = "DBServerSubnet"
    }
  
}

resource "aws_internet_gateway" "IGW_np" {
    vpc_id = aws_vpc.non_prod_vpc.id
    tags = {
      Name = "IGW-Np"
    }
  
}

resource "aws_route_table" "public_sub_rt" {
    vpc_id = aws_vpc.non_prod_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW_np.id
    }
    tags = {
      Name = "publicRT"
    }
  
}

resource "aws_route_table_association" "public_sub_rt_a" {
    subnet_id = aws_subnet.public_subnet_np.id
    route_table_id = aws_route_table.public_sub_rt.id
  
}