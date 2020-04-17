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

resource "google_compute_health_check" "rpc-hc" {
  name = "rpc-health"
  http_health_check {
    port = "5500"
  }
}

resource "google_compute_target_pool" "this" {
  count = var.use_external_lb ? 1 : 0
  name  = "rpc-target"

  health_checks = [google_compute_health_check.rpc-hc.self_link]
}

resource "google_compute_region_backend_service" "this" {
  count         = var.use_external_lb ? 0 : 1
  health_checks = [google_compute_health_check.rpc-hc.self_link]
  name          = "rpc-target"
  region        = var.region
  backend {
    group = var.instance_group_id

  }
}

resource "google_compute_forwarding_rule" "external" {
  count    = var.use_external_lb ? 1 : 0
  provider = google-beta

  name                  = var.lb_name
  target                = google_compute_target_pool.this[0].self_link
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "9933"
}

resource "google_compute_forwarding_rule" "internal" {
  count    = var.use_external_lb ? 0 : 1
  provider = google-beta

  name                  = var.lb_name
  backend_service       = google_compute_region_backend_service.this[0].self_link
  load_balancing_scheme = "INTERNAL"
  ip_protocol           = "TCP"
  all_ports             = true
  region                = var.region
  network               = var.public_vpc_id
  subnetwork            = var.public_subnet_id
  service_label         = "api-internal"
}
