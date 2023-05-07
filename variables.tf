variable "project_name" {
  type    = string
  default = "GDubSpecial"
}

variable "short_project_name" {
  type    = string
  default = "GDub"
}

variable "default_tags" {
  default = {
    Terraform = "true"
    Project   = "GDubSpecial"
  }
  description = "Additional resource tags"
  type        = map(string)
}

variable "sso_account" {
  type = string
  description = "AWS account ID for SSO account"
}