resource "azurerm_recovery_services_vault" "recoveryvault" {
    name                = "LabRecoveryVault"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    sku                 = "standard"
}
