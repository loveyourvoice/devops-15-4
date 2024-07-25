resource "yandex_mdb_mysql_cluster" "my_mysql_cluster" {
  name        = "loveyourvoice-mysql-cluster"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.develop.id
  version     = "8.0"
  timeouts {
    create = "1h"
  }
  maintenance_window {
    type = "ANYTIME"
  }

  host {
    zone = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.private_a.id
    assign_public_ip = false
  }

  host {
    zone = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.private_b.id
    assign_public_ip = false
  }


  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = "20"
  }

  backup_window_start {
    hours = 23
    minutes = 59
  }

  deletion_protection = true
}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.my_mysql_cluster.id
  name = "netology_db"
}

resource "yandex_mdb_mysql_user" "dbuser" {
  cluster_id = yandex_mdb_mysql_cluster.my_mysql_cluster.id
  name       = "dbuser"
  password   = "password123"

  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}