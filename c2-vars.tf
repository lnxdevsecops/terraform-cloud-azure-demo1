# defining variable 
# https://developer.hashicorp.com/terraform/language/values/variables
# 1. environment 
# variable "environment_var" {
#   type        = string
#   description = "This is environment variable"
#   default     = "dev01"
# }

# 2. resource group name 
variable "resource_group_name_var" {
  type        = string
  description = "This is resource group name variable"
  default     = "rg01"
}

# 3. resrouce group location 
variable "resource_group_location_var" {
  type        = string
  description = "This is resource group location variable"
  default     = "westus"
}

# 4. virtual network name 
variable "virtual_network_name_var" {
  type        = string
  description = "this is virtual network name variable"
}

# 5. virtual network address space 
variable "virtual_network_address_space_var" {
  type        = list(string)
  description = "This is virtual network address space variable"
}

# 6. subnet name 
variable "subnet_name_var" {
  type        = string
  description = "This is subnet name variable"
}

# 7. subnet subnet address prefix 
variable "subnet_address_prefix_var" {
  type        = list(string)
  description = "This is subnet address prefix variable"
}

# 8. network security group 
variable "network_security_group_name_var" {
  type        = string
  description = "This is network security group name variable"
}

# 9. public ip address name 
variable "public_ip_address_name_var" {
  type        = string
  description = "This is public ip address name variable"

}

# 10. network interface 
variable "network_interface_name_var" {
  type        = string
  description = "This is network interface name variable"
}

# 11. virtual machine name 
variable "vm_name_var" {
  type        = string
  description = "This is virtual machine name variable"
}