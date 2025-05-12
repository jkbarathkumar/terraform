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
