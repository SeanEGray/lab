resource "azurerm_resource_group" "lab_rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "azurerm_virtual_network" "lab_vnet" {
    name = "lab_vnet"
    address_space = ["${var.vnet_cidr}"]
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    dns_servers = "${var.dns_servers}"

    tags {
        group = "Terraform lab"
    }
}

resource "azurerm_subnet" "adds_subnet" {
    name = "adds_subnet"
    address_prefix = "${var.adds_subnet_cidr}"
    virtual_network_name = "${azurerm_virtual_network.lab_vnet.name}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    network_security_group_id = "${azurerm_network_security_group.adds_nsg.id}"
}

resource "azurerm_subnet" "web_subnet" {
    name = "web_subnet"
    address_prefix = "${var.web_subnet_cidr}"
    virtual_network_name = "${azurerm_virtual_network.lab_vnet.name}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    network_security_group_id = "${azurerm_network_security_group.web_nsg.id}"
}

resource "azurerm_network_security_group" "adds_nsg" {
  name                = "AADDS-${var.domain_name}-NSG"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.lab_rg.name}"

  security_rule {
    name                       = "AllowSyncWithAzureAD"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRD"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes      = ["207.68.190.32/27","13.106.78.32/27","13.106.174.32/27","13.106.4.96/27"]
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "AllowPSRemotingSliceP"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefixes      = ["52.180.179.108","52.180.177.87","13.75.105.168","52.175.18.134","52.138.68.41","52.138.65.157","104.41.159.212","104.45.138.161","52.169.125.119","52.169.218.0","52.187.19.1","52.187.120.237","13.78.172.246","52.161.110.169","52.174.189.149","40.68.160.142","40.83.144.56","13.64.151.161"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPSRemotingSliceT"
    priority                   = 302
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefixes      = ["52.180.183.67","52.180.181.39","52.175.28.111","52.175.16.141","52.138.70.93","52.138.64.115","40.80.146.22","40.121.211.60","52.138.143.173","52.169.87.10","13.76.171.84","52.187.169.156","13.78.174.255","13.78.191.178","40.68.163.143","23.100.14.28","13.64.188.43","23.99.93.197"]
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-NSG"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.lab_rg.name}"

  security_rule {
    name                       = "HTTPS"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes    = "*"
    destination_address_prefix = "*"
  }
}
