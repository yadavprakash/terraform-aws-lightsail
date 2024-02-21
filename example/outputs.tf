output "arn" {
  value       = module.lightsail.arn
  description = "The ARN of the Lightsail instance"
}

output "created_at" {
  value       = module.lightsail.created_at
  description = "The timestamp when the instance was created."
}

output "instance_ip" {
  value       = module.lightsail.instance_ip
  description = "The Public IP Address name of the Lightsail instance."
}

output "instance_name" {
  value       = module.lightsail.instance_name
  description = "The name of the Lightsail instance."
}