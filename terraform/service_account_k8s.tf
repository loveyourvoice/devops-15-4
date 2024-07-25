
resource "yandex_iam_service_account" "k8s" {
  name = "k8s"
}

resource "yandex_iam_service_account_key" "k8s-key" {
  service_account_id = yandex_iam_service_account.k8s.id
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-admin-binding" {
  folder_id = var.folder_id
  role      = "admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.k8s.id}"
  ]
}