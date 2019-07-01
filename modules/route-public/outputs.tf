output "route_table_id" {
  value       = aws_route_table.public.id
  description = "ID of the routing table used to access the public internet"
}

output "gateway_id" {
  value       = aws_internet_gateway.public.id
  description = "ID of the internet gateway used to access the public internet"
}

