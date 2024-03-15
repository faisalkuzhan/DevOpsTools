output "control_node_ip" {
  value = aws_instance.amazon-linux-2[0].public_ip
}
output "node-1" {
  value = aws_instance.amazon-linux-2[1].public_ip
}
output "node-2" {
  value = aws_instance.amazon-linux-2[2].public_ip
}

output "node-3" {
  value = aws_instance.ubuntu.public_ip
}