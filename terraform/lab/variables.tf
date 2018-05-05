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

variable "subnet1_cidr" {
    description = "Enter a CIDR block for subnet 1"
}

variable "subnet2_cidr" {
    description = "Enter a CIDR block for subnet 2"
}

variable "vm_username" {
    description = "Enter the default vm username"
}

variable "vm_password" {
    description = "Enter the default vm password"
}

