
# --------- Route Table ------------

resource "azurerm_route_table" "route_table" {
  for_each                      = local.route_table
  name                          = each.value.name
  resource_group_name           = var.resource_group_output[each.value.resource_group_name].name
  location                      = each.value.location == null ? var.default_values.location : each.value.location
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  tags                          = each.value.tags == null ? var.default_values.tags : each.value.tags
  dynamic "route" {
    for_each = each.value.routes
    content {
      name                   = route.value.route
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_type == "VirtualAppliance" ? route.value.next_hop_in_ip_address : null
    }
  }
}

