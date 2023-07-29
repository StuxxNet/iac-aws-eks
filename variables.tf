variable "name" {
  description = "The default name for the majority of resources"
  type        = string
  default     = "devops"
}

variable "subnets" {
  description = "List of subnets where cluster will spin it's nodes"
  type        = list(string)
  default = [
    "subnet-07679ba9b8dee988f",
    "subnet-0127fe1a3ce8e320a",
    "subnet-02655d15792b5a3d6"
  ]
}

variable "eks_version" {
  description = "Cluster version"
  type        = string
  default     = "1.25"
}