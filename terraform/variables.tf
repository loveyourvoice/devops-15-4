variable "yandex_token" {
  type        = string
}

variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
}

variable "public_subnet" {
  type        = string
  default     = "public-subnet"
}
variable "public_subnet2" {
  type        = string
  default     = "public-subnet2"
}
variable "public_subnet3" {
  type        = string
  default     = "public-subnet3"
}