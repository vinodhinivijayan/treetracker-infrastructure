variable cluster_name {}
resource "digitalocean_database_cluster" "treetracker-postgres-cluster" {
  name       = var.cluster_name
  engine     = "pg"
  version    = "11"
  size       = "db-s-2vcpu-4gb"
  region     = "nyc1"
  node_count =   2
}

# TODO: set up dns to point to this database so it's easier to connect to db
#resource "digitalocean_record" "CNAME-database" {
#  domain = digitalocean_domain.ambassador-host.name
#  type = "CNAME"
#  name = "www"
#  value = "@"
#}

resource "digitalocean_database_replica" "treetracker-postgres-read-replica" {
  cluster_id = digitalocean_database_cluster.treetracker-postgres-cluster.id
  name       = "read-replica"
  size       = "db-s-2vcpu-4gb"
  region     = "nyc1"
}

#resource "digitalocean_database_replica_firewall" "treetracker-database-replica-fw" {
#  cluster_id = digitalocean_database_replica.treetracker-postgres-read-replica.id
#
#  rule {
#    type  = "tag"
#    value = "treetracker-database-access"
#  }
#}



resource "digitalocean_database_db" "treetracker-database" {
  cluster_id = digitalocean_database_cluster.treetracker-postgres-cluster.id
  name       = "treetracker_dev"
}

resource "digitalocean_database_db" "data-pipeline-database" {
  cluster_id = digitalocean_database_cluster.treetracker-postgres-cluster.id
  name       = "data_pipeline_dev"
}

