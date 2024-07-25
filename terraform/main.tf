locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  ssh-private-keys = file("~/.ssh/id_ed25519")
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.11.0/24"]
}

resource "yandex_vpc_subnet" "public2" {
  name           = var.public_subnet2
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.12.0/24"]
}

resource "yandex_vpc_subnet" "public3" {
  name           = var.public_subnet3
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.13.0/24"]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "my-private-subnet-a"
  network_id     = yandex_vpc_network.develop.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.0.14.0/24"]
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "my-private-subnet-b"
  network_id     = yandex_vpc_network.develop.id
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.0.15.0/24"]
}
