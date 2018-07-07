resource "azurerm_network_interface" "webvm_nic" {
    name                = "webvm1nic"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"

    ip_configuration {
        name                          = "webvmnicconfig"
        subnet_id                     = "${azurerm_subnet.web_subnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_managed_disk" "webvm_datadisk" {
    name                 = "webvm_datadisk"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1023"
}

resource "azurerm_virtual_machine" "webvm_vm" {
  name                  = "webvm"
  location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    network_interface_ids = ["${azurerm_network_interface.webvm_nic.id}"]
  vm_size               = "Standard_DS1_v2"

  
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "webvm_osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }


  storage_data_disk {
    name            = "${azurerm_managed_disk.webvm_datadisk.name}"
    managed_disk_id = "${azurerm_managed_disk.webvm_datadisk.id}"
    create_option   = "Attach"
    lun             = 1
    disk_size_gb    = "${azurerm_managed_disk.webvm_datadisk.disk_size_gb}"
  }

  os_profile {
    computer_name  = "${var.webvmhostname}"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_windows_config {
      provision_vm_agent = true      
  }
}

resource "azurerm_virtual_machine_extension" "webdsc" {
  name = "webdsc"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.lab_rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.webvm_vm.name}"
  publisher = "Microsoft.PowerShell"
  type = "DSC"
  type_handler_version = "2.76"
  depends_on = ["azurerm_virtual_machine.webvm_vm"]

  settings = <<SETTINGS
  {
    "Privacy": {
      "DataCollection": ""
    },
    "Properties": {
      "RegistrationKey": {
        "UserName": "PLACEDHOLDER_DONOTUSE",
        "Password": "PrivateSettingsRef:registrationKeyPrivate"
      },
      "RegistrationUrl": "${var.dsc_endpoint}",
      "NodeConfigurationName": "${var.dsc_config}",
      "ConfigurationMode": "${var.dsc_mode}",
      "ConfigurationModeFrequencyMins": 15,
      "RefreshFrequencyMins": 30,
      "RebootNodeIfNeeded": true,
      "ActionAfterReboot": "continueConfiguration",
      "AllowModuleOverwrite": false
      }
    }
    SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "Items": {
      "registrationKeyPrivate": "${var.dsc_key}"
    }
  }
  PROTECTED_SETTINGS
}
