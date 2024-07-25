resource "yandex_kms_symmetric_key" "secret-key" {
  name              = "key-1"
  description       = "Ключ для шифрования"
  default_algorithm = "AES_128"
  rotation_period   = "24h"
  folder_id         = var.folder_id
}