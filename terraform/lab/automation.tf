resource "azurerm_automation_account" "lab_auto" {
  name                = "LabAutomation"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.lab_rg.name}"
  sku {
    name = "Basic"
  }
}
