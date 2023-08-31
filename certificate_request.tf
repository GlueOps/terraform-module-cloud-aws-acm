module "acm_request_certificate" {
  for_each                          = var.certificate_requests
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=0.16.3"
  domain_name                       = each.value.domain_name
  process_domain_validation_options = false
  subject_alternative_names         = each.value.subject_alternative_names
  tags = merge(
    { "friendly_name" = each.key },
    each.value.tags
  )
}

output "requested_certificates" {
  value = module.acm_request_certificate
}
