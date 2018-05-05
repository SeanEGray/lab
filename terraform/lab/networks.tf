resource "azurerm_resource_group" "lab_rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_virtual_network" "lab_vnet" {
    name = "lab_vnet"
    address_space = ["${var.vnet_cidr}"]
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"

    tags {
        group = "Terraform lab"
    }
}

resource "azurerm_subnet" "lab_subnet_1" {
    name = "lab_subnet_1"
    address_prefix = "${var.subnet1_cidr}"
    virtual_network_name = "${azurerm_virtual_network.lab_vnet.name}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
}

resource "azurerm_subnet" "lab_subnet_2" {
    name = "lab_subnet_2"
    address_prefix = "${var.subnet2_cidr}"
    virtual_network_name = "${azurerm_virtual_network.lab_vnet.name}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
}
