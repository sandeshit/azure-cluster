module "rg" {
  source   = "../../modules/rg"
  resource_group_name = "toggle-rg-619"
  resource_group_location = "West Europe"
}

module "acr" {
  source              = "../../modules/acr"
  acr_name = "toggleacr619"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
}
