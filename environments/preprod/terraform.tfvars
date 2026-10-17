rgs = {
  rg1 = {
    name     = "rg-preprod"
    location = "central india"
  }
   rg2 = {
    name     = "rg-ajadi"
    location = "East US"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "stpreprod97187"
    resource_group_name      = "rg-preprod"
    location                 = "central india"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
