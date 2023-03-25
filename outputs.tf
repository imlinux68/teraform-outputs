output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.myWebServer.public_ip
}

output "my_instance_id" {
  description = "InstanceID of our WebSite"
  value       = aws_instance.myWebServer.id
}

output "my_instance_arn" {
  description = "InstanceARN of our WebSite"
  value       = aws_instance.myWebServer.arn
}

output "my_sg_id" {
  description = "SecurityGroup of our WebSite"
  value       = aws_security_group.myWebServer.id
}
