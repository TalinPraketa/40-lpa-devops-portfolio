variable "aws_region" {
  description = "AWS Region for bootstrapping resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Platform Project Name"
  type        = string
  default     = "enterprise-event-streaming-platform"
}

variable "owner" {
  description = "Resource owner"
  type        = string

}
