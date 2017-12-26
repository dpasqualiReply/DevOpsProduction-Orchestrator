
provider "google" {
  credentials = "${file("/home/dario_pasquali93/.config/gcloud/terraform-admin.json")}"
  project     = "mondadorici"
  region      = "us-east1-b"
}

resource "google_compute_instance" "default" {
 project = "mondadorici"
 zone = "us-east1-b"
 name = "tf-compute-1"
 machine_type = "g1-small"

 tags = ["cloudera", "http", "https"]
 
 boot_disk {
   initialize_params {
     image = "centos-7-v20171213"
     size = "20"
   }
 }
 
 network_interface {
   network = "default"
   access_config {
   }
 }
}

output "instance_id" {
 value = "${google_compute_instance.default.self_link}"
}
