terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "pet_name_length" {
  type        = number
  description = "Number of words in pet name"
  default     = 5
}

data "tfe_outputs" "pet-name-workspace1" {
  organization = "puget-sound-energy"
  workspace    = "pet-name-workspace1"
}


module "pet" {
  source = "./terraform-random-petname"

  pet_name_length = var.pet_name_length
}

output "combined_pet_name" {
  sensitive   = false
  description = "Here is the name of your new pet!"
  value       = [format("%s-%s", data.tfe_outputs.pet-name-workspace1.outputs.pet_name, module.pet.name)]

}
