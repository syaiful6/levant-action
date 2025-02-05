# Levant Action

This action uses [Hashicorp Levant](https://github.com/hashicorp/levant) to deploy [Nomad](https://github.com/hashicorp/nomad).

## Inputs

### `token`

Token used to authenticate to *Nomad* server.

### address

Nomad address to submit the job

### job

Nomad job template to deploy. Please refer to [Levant docs](https://github.com/hashicorp/levant/blob/main/docs/templates.md) for full details.

### var-file

Path to a file containing user variables used when rendering the job template.

## Example usage

uses: syaiful6/levant-action@main
with:
  address: <http://127.0.0.1:4646>
  job: awesome-app.nomad.hcl
  var-file: levant.yaml
