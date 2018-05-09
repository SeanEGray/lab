resource "azurerm_storage_account" "lab_storage1" {
  name 			= "tacitstor1"
  resource_group_name 	= "${azurerm_resource_group.lab_rg.name}"
  location 		= "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "lab_storage2" {
  name 			= "tacitstor2"
  resource_group_name 	= "${azurerm_resource_group.lab_rg.name}"
  location 		= "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "lab_container" {
  name 			= "testcontainer"
  resource_group_name 	= "${azurerm_resource_group.lab_rg.name}"
  storage_account_name 	= "${azurerm_storage_account.lab_storage1.name}"
}

resource "azurerm_storage_blob" "testsb" {
  name = "${var.testblobuploadname}"
  resource_group_name    = "${azurerm_resource_group.lab_rg.name}"
  storage_account_name   = "${azurerm_storage_account.lab_storage1.name}"
  storage_container_name = "${azurerm_storage_container.lab_container.name}"
  source = "${var.testblobuploadpath}"
  type = "block"
}

resource "azurerm_storage_share" "testshare" {
  name = "testshare"
  resource_group_name    = "${azurerm_resource_group.lab_rg.name}"
  storage_account_name   = "${azurerm_storage_account.lab_storage2.name}"
  quota = 1
}