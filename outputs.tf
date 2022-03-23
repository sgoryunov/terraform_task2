output "ec2_instance_web" {
  value = aws_instance.web.id
}
output "instance_free_tier_types" {
  value = data.aws_ec2_instance_types.free_tier_inst_type.instance_types[0]
}
output "Public_ip_address" {
  value = resource.aws_instance.web.public_ip
}
output "Public_dns" {
  value = resource.aws_instance.web.public_dns
}
output "db_endpoint" {
  value = resource.aws_db_instance.my_db.endpoint
}