module "label" {
  source = "github.com/robc-io/terraform-null-label.git?ref=0.16.1"
  tags = {
    NetworkName = var.network_name
    Owner       = var.owner
    Terraform   = true
    VpcType     = "main"
  }

  environment = var.environment
  namespace   = var.namespace
  stage       = var.stage
}

resource "google_compute_http_health_check" "rpc-hc" {
  name = "rpc-health"
  port = "5500"
}

resource "google_compute_target_pool" "this" {
  name = "rpc-target"

  health_checks = [google_compute_http_health_check.rpc-hc.self_link]
}

resource "google_compute_forwarding_rule" "default" {
  provider = google-beta

  name                  = var.lb_name
  target                = google_compute_target_pool.this.self_link
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "9933"
}