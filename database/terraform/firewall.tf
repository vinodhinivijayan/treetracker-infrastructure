variable tag1{}
variable tag2{}
variable droplet_name{}
variable droplet_node{}
variable ip_address1{}
variable  ip_address2{}
resource "digitalocean_database_firewall" "treetracker-database-fw" {
  cluster_id = digitalocean_database_cluster.treetracker-postgres-cluster.id

  rule {
    type  = "tag"
    value = var.tag1
  }

  rule {
    type  = "tag"
    value = var.tag2
  }

  rule {
    type  = "droplet"
    value = var.droplet_name
  }

  rule {
    type  = "droplet"
    value = var.droplet_node
  }

   rule {
    type  = "ip_addr"
    value = var.ip_address1
  }

  rule {
    type  = "ip_addr"
    value = var.ip_address2
  }




}