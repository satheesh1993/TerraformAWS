resource "aws_cloudwatch_log_group" "vpc_flow_log_np_gp" {
    name = "/aws/vpc/flowlogs"
    retention_in_days = 7
  
}