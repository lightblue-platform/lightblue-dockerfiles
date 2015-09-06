[Terraform](https://www.terraform.io/intro/index.html) script to run lightblue using [docker provider](https://www.terraform.io/docs/providers/docker/index.html).

## Terraform

To install Terraform, just [download](https://www.terraform.io/downloads.html) and unpack it. No setup is needed.

## How to run

Assuming you have docker available via tcp://127.0.0.1:4243, just run in the terraform directory (where main.tf script is):
```
terraform apply
```

You can specify versions:
```
terraform apply -var 'lightblue_version:1.2.0' -var 'lightblue_apps_version:1.2.0'
```
By default, latest version is taken.

Once started, you will have following services available:

* Data endpoint: http://localhost:8080/rest/data
* Metadata endpoint: http://localhost:8080/rest/metadata
* Data Management App: http://localhost:8081/app/data
* Metadata Management App: http://localhost:8081/app/metadata
