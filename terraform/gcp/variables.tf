variable "node_count" {
  default = 4
}

variable "region" {
  default = "europe-west1"
}

variable "preemptible_nodes" {
  default = "false"
}

variable "daily_maintenance_window_start_time" {
  default = "02:00"
}

variable "cprovider" {
  default = "gcp"
  description = "Terraform for Google Cloud"
}

variable project {
  type = "string"
  description = "The name of your GCP project to use"
}

