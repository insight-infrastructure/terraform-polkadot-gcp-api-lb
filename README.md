# terraform-polkadot-gcp-api-lb

[![open-issues](https://img.shields.io/github/issues-raw/insight-w3f/terraform-polkadot-gcp-api-lb?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-gcp-api-lb/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-w3f/terraform-polkadot-gcp-api-lb?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-gcp-api-lb/pulls)
[![build-status](https://img.shields.io/circleci/build/github/insight-w3f/terraform-polkadot-gcp-api-lb?style=for-the-badge)](https://circleci.com/gh/insight-w3f/terraform-polkadot-gcp-api-lb)


## Features

This module...

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "defaults" {
  source = "github.com/insight-w3f/terraform-polkadot-gcp-api-lb"
}

module "network" {
  source   = "github.com/insight-w3f/terraform-polkadot-gcp-network.git?ref=master"
  vpc_name = "cci-test"
}

module "asg" {
  source                 = "github.com/insight-w3f/terraform-polkadot-gcp-asg.git?ref=master"
  node_name              = "sentry"
  relay_node_ip          = "1.2.3.4"
  relay_node_p2p_address = "abcdefg"
  security_group_id      = module.network.sentry_security_group_id[0]
  vpc_id                 = module.network.vpc_id
  network_name           = "dev"
  private_subnet_id      = module.network.private_subnets[0]
  public_subnet_id       = module.network.public_subnets[0]
  public_key_path        = var.public_key_path
  use_lb                 = true
  target_pool_id         = module.defaults.target_pool_id

  zone    = var.gcp_zone
  region  = var.gcp_region
  project = var.gcp_project
}

```
## Examples

- [defaults](https://github.com/insight-w3f/terraform-polkadot-gcp-api-lb/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment | `string` | `""` | no |
| instance\_group\_id | n/a | `string` | n/a | yes |
| lb\_name | Name for load balancer | `string` | `"rpc-lb"` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| owner | n/a | `string` | `""` | no |
| public\_subnet\_id | n/a | `string` | n/a | yes |
| public\_vpc\_id | n/a | `string` | n/a | yes |
| region | n/a | `string` | `"us-east1"` | no |
| stage | The stage of the deployment | `string` | `""` | no |
| use\_external\_lb | Bool to switch between public (true) or private (false) | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| internal\_lb\_endpoint | n/a |
| target\_pool\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [Richard Mah](https://github.com/shinyfoil)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.