## Terraform(IaC Tool) using Azure
### Terraform basics
- Terraform is a tool that helps you manage and automate the setup of your infrastructure (like virtual machines, databases, networks, etc.) using code.
- Tool for infrastructure provisioning
  
🔧 `Purpose`
Terraform: Builds and provisions infrastructure (servers, networks, cloud resources).
Ansible: Configures and manages software and settings on infrastructure.

⚙️ `How They Work`
Terraform: Uses declarative language (you describe the desired state).
Ansible: Mostly procedural (you write the steps to reach the state).

🔁 `State Management`
Terraform: Maintains a state file to track resources.
Ansible: Stateless; it checks the current state during each run.

☁️ `Use Cases`
Terraform: Ideal for cloud provisioning (AWS, Azure, GCP).
Ansible: Best for configuration management (installing packages, setting configs).

![image](https://github.com/user-attachments/assets/8784567f-6f62-47b2-bb1c-3e836dc8ac90)


### Terraform files
- State File (terraform.tfstate)
 - The state file is crucial for tracking the current state of your infrastructure. Terraform maintains a record of all the resources it manages in this file. It is automatically generated and updated as Terraform applies changes to the infrastructure.

`Issues in tfstate file`
- If two people are working on the same project and making changes at the same time, a conflict may occur.

`Resolve`
- To resolve this conflict, we can enable state locking so that only one operation can modify the tfstate file at a time.

### Terraform versions
- `=` Exaact version
- `!=` Exclude the exact version
- `>, >=, <, <=` Allow version when comparision is true.
- `~>` Only allow the right most increment
	Eg: ~> 1.0.4 (Tf can install 1.0.5, 1.0.10 But not 1.1.0)
	    ~? 1.1 (Tf can install 1.2, 1.10 but not 2.0)



### Terraform basic commands
- **`terraform init`**    - Initializes the Terraform working directory.
- **`terraform plan`** - Creates an execution plan (dry run).
	-    **Created**: Resources that don’t exist yet, according to the configuration, are marked as `+ create`.
    -   **Updated**: Resources that need changes are marked as `~ update`.
    -   **Destroyed**: Resources that are no longer in the configuration are marked as `- destroy`.
      
- **`terraform apply`**: Applies the changes to your infrastructure.
- **`terraform destroy`**: -   Destroys all resources defined in your configuration.
- **`terraform fmt`** -   Formats the Terraform configuration files to standardize them.
- **`terraform validate`** - Validates the syntax of the configuration files
- **`terraform show`**  - Displays the Infrastructure

### What Happens When You Run terraform init?
- Validates backend configuration
  	- Checks if a remote backend is configured (e.g., Azure Blob, S3, Terraform Cloud).
  	- If so, it initializes and connects to the backend for storing state remotely.

- Initializes the working directory
	- Prepares the folder containing your `.tf` files for use.
   	- Creates the `.terraform/` subdirectory (for internal data).

- Downloads provider plugins
  - Based on the provider blocks (e.g., `azurerm, aws, google`), Terraform downloads the required provider binaries.
  - These plugins are stored locally in `.terraform/providers/`

### Terraform Lifecycle
- In Terraform, the lifecycle block is a way to control how resources are managed during their lifecycle—specifically when Terraform is `planning, creating, updating, or destroying infrastructure`. It provides settings that let you override the default behavior.
 1. `create_before_destroy`
    - This ensures that a `new resource` is `created before the old one is destroyed` when a change requires replacement.
    - This is useful to `avoid downtime`, especially for resources like compute instances, load balancers, or DNS records.
 2. `prevent_destroy`

    - The prevent_destroy lifecycle argument `protects a resource from accidental or intentional destruction`.
    - With `prevent_destroy = true`: Terraform will refuse to destroy the resource, protecting critical infrastructure like databases, load balancers, or production servers
3. `ignore_changes`

    - The ignore_changes setting tells Terraform to ignore changes to specific arguments of a resource after it has been created — even if those arguments differ from what's in your .tf configuration. This is useful when:
    - A setting is managed outside Terraform (e.g., manually or by another tool).
    - A setting frequently changes (e.g., tags or user-assigned IPs) and you don’t want Terraform to constantly try to revert it.
      ## Example Use Case: Azure Virtual Machine Tags
	- Imagine you're using Azure Virtual Machines, and a monitoring tool automatically adds or modifies tags. You don’t want Terraform to reset those tags every time you apply.
