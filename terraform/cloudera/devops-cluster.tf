
provider "google" {
  credentials = "${file("/home/dario_pasquali93/.config/gcloud/terraform-admin.json")}"
  project     = "mondadorici"
  region      = "us-east1-b"
}

resource "google_compute_instance" "cloudera" {
 project = "mondadorici"
 zone = "us-east1-b"
 name = "tf-cloudera"
 machine_type = "n1-standard-4"

 tags = ["jenkins", "cloudera", "http", "https"]
 
 boot_disk {
   initialize_params {
     image = "centos-7-v20171213"
     size = "30"
   }
 }
 
 network_interface {
   network = "default"
   access_config {
   }
 }

 provisioner "local-exec" {
 
  command = "sleep 90; ansible-playbook -i '${google_compute_instance.cloudera.name},' --private-key=~/.ssh/ansible_rsa /opt/ansible/cloudera.yml -e 'ansible_ssh_user=dario_pasquali93' -e 'host_key_checking=False'"
 }
}

output "cloudera" {
 value = "${google_compute_instance.cloudera.self_link}"
}

