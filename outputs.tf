output "target_pool_id" {
  value = join(",", google_compute_target_pool.this.*.self_link)
}

output "internal_lb_endpoint" {
  value = join(",", google_compute_forwarding_rule.internal.*.service_name)
}