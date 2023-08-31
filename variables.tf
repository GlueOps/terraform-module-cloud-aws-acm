variable "certificate_requests" {
  type = map(object({
    domain_name               = string
    subject_alternative_names = list(string)
    tags                      = map(string)
  }))

  validation {
    condition = alltrue([
      for req in values(var.certificate_requests) :
      contains(keys(req.tags), "dns_provider")
    ])
    error_message = "Each certificate request must contain the 'dns_provider' tag."
  }
}
