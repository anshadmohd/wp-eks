**Terraform structure**

- eks.tf: Contains code to create the EKS cluster.
- providers.tf: Specifies the providers used in the Terraform code.
- variables.tf: Stores all the configurable values for VPC and EKS.
- vpc.tf: Contains the Terraform code to create the VPC.

**Variable Management:**
- variables.tf:
Holds all the values used in vpc.tf and eks.tf.
Editing values here overrides the defaults in the main Terraform code.


**VPC Configuration:**
- vpc.tf:
Responsible for creating the VPC using Terraform.


**EKS Cluster Creation:**
- eks.tf:
Contains the Terraform code for creating the EKS cluster.

**Use commands**
```
terraform init
terraform plan
terraform apply
```
