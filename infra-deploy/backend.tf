terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-statefile"  
    storage_account_name = "terraformstatefileapp"                     
    container_name       = "terraformstatefile"                      
    key                  = "terraform.tfstate"        
  }
}
