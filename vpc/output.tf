output "vpc_id" {
  description = "Id of VPC"
  value       = aws_vpc.main.id
}

output "vpc_name" {
  description = "Name of VPC"
  value       = aws_vpc.main.tags
}