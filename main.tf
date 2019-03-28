resource "azurerm_resource_group" "test" {
  name     = "My-New-RG"
  location = "West US"

  tags {
    environment = "Production"
    //cource = "DevOpsflow"
  }
}