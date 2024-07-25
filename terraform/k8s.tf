resource "yandex_kubernetes_cluster" "my-k8s" {
  name = "my-k8s"
  network_id = yandex_vpc_network.develop.id

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.public.zone
        subnet_id = yandex_vpc_subnet.public.id
      }

      location {
        zone      = yandex_vpc_subnet.public2.zone
        subnet_id = yandex_vpc_subnet.public2.id
      }

      location {
        zone      = yandex_vpc_subnet.public3.zone
        subnet_id = yandex_vpc_subnet.public3.id
      }
    }


    version   = "1.27"
    public_ip = true

    master_logging {
      enabled = true
      folder_id = var.folder_id
      kube_apiserver_enabled = true
      cluster_autoscaler_enabled = true
      events_enabled = true
      audit_enabled = true
    }    
  }
  service_account_id      = yandex_iam_service_account.k8s.id
  node_service_account_id = yandex_iam_service_account.k8s.id
  kms_provider {
    key_id = yandex_kms_symmetric_key.secret-key.id
  }
}

resource "yandex_kubernetes_node_group" "worker-nodes-a" {
  cluster_id = yandex_kubernetes_cluster.my-k8s.id
  name       = "worker-nodes-a"
  version    = "1.27"
  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.public.id]
    }
    metadata = {
      ssh-keys = "ubuntu:${local.ssh-keys}"
    }
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 2
      initial = 1
  }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public.zone
    }
  }
}


resource "yandex_kubernetes_node_group" "worker-nodes-b" {
  cluster_id = yandex_kubernetes_cluster.my-k8s.id
  name       = "worker-nodes-b"
  version    = "1.27"
  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.public2.id]
    }
    metadata = {
      ssh-keys = "ubuntu:${local.ssh-keys}"
    }
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 2
      initial = 1
  }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public2.zone
    }
  }
}

resource "yandex_kubernetes_node_group" "worker-nodes-d" {
  cluster_id = yandex_kubernetes_cluster.my-k8s.id
  name       = "worker-nodes-d"
  version    = "1.27"
  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.public3.id]
    }
    metadata = {
      ssh-keys = "ubuntu:${local.ssh-keys}"
    }
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 2
      initial = 1
  }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public3.zone
    }
  }
}