resource "azurerm_sql_server" "tacitsqlserver" {
    name = "tacitsqlserver"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    location            = "${var.location}"
    version = "12.0"
    administrator_login = "${var.sql_username}"
    administrator_login_password = "${var.sql_password}"
}

resource "azurerm_sql_elasticpool" "tacitsqlpool" {
    name = "tacitsqlpool"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    location            = "${var.location}"
    server_name = "${azurerm_sql_server.tacitsqlserver.name}"
    edition = "Basic"
    dtu = 50
    db_dtu_min = 0
    db_dtu_max = 5
    pool_size = 5000
}

resource "azurerm_sql_database" "tacitsqldb" {
    name = "tacitsqldb"
    resource_group_name = "${azurerm_resource_group.lab_rg.name}"
    location            = "${var.location}"
    elastic_pool_name = "${azurerm_sql_elasticpool.tacitsqlpool.name}"
    server_name = "${azurerm_sql_server.tacitsqlserver.name}"
}
