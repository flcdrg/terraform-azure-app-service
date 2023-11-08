# Create an Azure App Service with Terraform

Example using Terraform to create Azure App Service

Uses [Terraform Cloud](https://app.terraform.io)

## Configure Terraform Cloud

1. Create a [Terraform Cloud](https://app.terraform.io) account
1. Create a new [Terraform Cloud API token](https://app.terraform.io/app/settings/tokens)
1. Create a new [Terraform Cloud workspace](https://app.terraform.io/app/organizations/new) linked to this GitHub repo
    1. Select "Version control workflow"
    1. Select GitHub App
    1. Select this repo (you may need to enter the repository id and search for it)
    1. In Advanced Options, select **Auto-apply API, CLI & VCS runs**
    1. Click **Create workspace**
1. Create an Azure resource group and a service principal with the Azure CLI

    ```bash
    az login
    az group create --location westus --resource-group MyResourceGroup
    az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>/resourceGroups/<resourceGroupName>
    ```

1. Add the following environment variables to your Terraform Cloud workspace:
    - `ARM_CLIENT_ID` - appId
    - `ARM_CLIENT_SECRET` - password (mark this as sensitive)
    - `ARM_SUBSCRIPTION_ID` - id from `az account show`
    - `ARM_TENANT_ID`

1. Run `terraform login`
1. Paste the token from the browser session into the terminal
1. Run `terraform init` to initialize the workspace locally
