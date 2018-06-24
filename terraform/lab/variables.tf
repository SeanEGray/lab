provider azurerm {
    subscription_id  = "${var.subscription_id}"
    client_id = "${var.client_id}"
    client_secret = "${var.client_secret}"
    tenant_id = "${var.tenant_id}"
}

variable "subscription_id" {
    description = "Enter Azure subscription id"
}

variable "client_id" {
    description = "Enter client id of the Azure AD app to authenticate as"
}

variable "client_secret" {
    description = "Enter client secret of the Azure AD app to authenticate as"
}

variable "tenant_id" {
    description = "Enter Azure tenant id"
}

variable "location" {
    description = "Enter Azure location"
}

variable "resource_group_name" {
    description = "Enter a name for the Azure resource group"
}

variable "vnet_cidr" {
    description = "Enter a CIDR block for the virtual network"
}

variable "adds_subnet_cidr" {
    description = "Enter a CIDR block for the Azure AD Domain Services subnet"
}

variable "web_subnet_cidr" {
    description = "Enter a CIDR block for the web tier subnet"
}

variable "vm_username" {
    description = "Enter the default vm username"
}

variable "vm_password" {
    description = "Enter the default vm password"
}

variable "sql_username" {
    description = "Enter the default sql username"
}

variable "sql_password" {
    description = "Enter the default sql password"
}
variable "dns_servers" {
    type = "list"
    description = "Enter DNS servers for the Lab VNET"
}

variable "domain_name" {
    description = "Enter the name of the Active Directory domain"
}

variable "test_blob_upload_name" {
    description = "Enter the name of a file to upload"
}

variable "test_blob_upload_path" {
    description = "Enter the path of a file to upload"
}

variable "vmwebhostname" {
    description = "Enter the hostname of the web server VM"
}