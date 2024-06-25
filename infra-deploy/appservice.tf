
## vnet and subnet config
module "vnet" {
    source = "./modules/vnet"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
  
}

module "dns" {
  source = "./modules/dns"
  vnetid = module.vnet.vnetid
  resource_group_location = module.vnet.rg_location
  resource_group_name = module.vnet.resource_group_name
  private_ip_address = module.appservice.private_endpoint_address
  appsvc_name =  module.appservice.appsvc_name
}

module "appservice" {
    source = "./modules/appsvc"
    resource_group_location = module.vnet.rg_location
    resource_group_name = module.vnet.resource_group_name
    subnet_id = module.vnet.pepsnet

  
}

# module "firewall" {
#     source = "./modules/firewall"
#     resource_group_name      = module.vnet.resource_group_name
#     resource_group_location  = module.vnet.rg_location
#     private_endpoint_address = module.appservice.private_endpoint_address
#     fw_snetid = module.vnet.fwsnet
  
# }

module "application_gateway" {
  source = "./modules/appgw"
  resource_group_name = module.vnet.resource_group_name
  resource_group_location = module.vnet.rg_location
  agw_subnet_id = module.vnet.agwsnet
  app_service_hostname = module.appservice.appsvc_host_name
}