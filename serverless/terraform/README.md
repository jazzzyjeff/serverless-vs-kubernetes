## Usage
1. Copy the template variables file:

    ```bash
    cp serverless/terraform/variables.auto.tfvars.tmpl serverless/terraform/variables.auto.tfvars
    ```
2. Update the variables in variables.auto.tfvars:

    | Variable  | Description                       | Type   |
    | --------- | --------------------------------- | ------ |
    | `region`  | AWS region (e.g., `eu-west-2`)    | String |
    | `service` | Service name / project identifier | String |
    | `host`    | Docker daemon address             | String |
    | `domain`  | Domain Route53 zone name          | String |
3. Run the following Terraform commands to deploy infrastructure

    ```bash
    cd serverless/terraform

    terraform init
    terraform plan
    terraform apply -auto-approve
    ```
