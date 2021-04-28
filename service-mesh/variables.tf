variable "init_sample_app" {
  default     = false
  description = "Initialize starter bookInfo app"
  type        = bool
}

variable "enable_monitoring" {
  default     = false
  description = "Initialize Prometheus and Grafana"
  type        = bool
}

variable "enable_logging" {
  default     = false
  description = "Initialize ELK"
  type        = bool
}