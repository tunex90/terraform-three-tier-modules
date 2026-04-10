output "vpc_id" {
  value = aws_vpc.this.id
}

output "web_public_a_id" {
  value = aws_subnet.web_public_a.id
}

output "web_public_b_id" {
  value = aws_subnet.web_public_b.id
}

output "app_private_a_id" {
  value = aws_subnet.app_private_a.id
}

output "db_private_a_id" {
  value = aws_subnet.db_private_a.id
}
