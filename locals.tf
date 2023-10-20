locals {  
    route_table = {for route_table in var.route_table_list: route_table.name => route_table}
}