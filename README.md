# SLC Terraform Demo

## Managing Cloud Infrastructure with Code

This is a demo repository showcasing Infrastructure as Code (IaC) using Terraform, YAML, and GitHub Actions to provision resources in Google Cloud.

I view IaC as an extension of the object-oriented principles we use in software development. When you abstract a method or create a class in programming, the same thought processes apply to managing infrastructure.

**If you're doing something once, a literal string or hardcoded solution may be quick and easy. However, if you're doing something a thousand times, it makes sense to invest time in creating a more efficient, repeatable, and observable solution.**

This approach not only saves time in the long run but also ensures consistency and scalability.

## Overview

In this project, Terraform is used to manage cloud resources on **Google Cloud Platform (GCP)**. The configuration is driven by environment-specific **YAML** files. This combination of:

##### `YAML => HCL => GCP`

allow for a declarative approach to managing resources, making the setup more maintainable and flexible.

This setup also demonstrates the use of **child modules**, which allows for better code organization and reusability, especially when managing similar resources (like Cloud Storage buckets) across different environments.

## File Structure

- `main.tf`: The main Terraform configuration file where resources, modules, and data sources are defined.
- `apps/prod.yaml` and `apps/pilot.yaml`: Environment-specific YAML files used to configure application settings like IAM members and Cloud Storage buckets.
- `modules/cloud-storage`: A child module that configures Cloud Storage buckets using values passed from the parent Terraform configuration.
- `.github/workflows`: Contains GitHub Actions workflows for automating tasks such as `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply` in **CI/CD pipelines**.

## Key Concepts

### Using YAML Files for Configuration

The project uses **YAML files** to store environment-specific configurations. These YAML files define settings such as:

- **IAM members**: The users or service accounts and their roles.
- **Cloud Storage buckets**: The configuration for creating and managing Cloud Storage buckets, including bucket names, lifecycle rules, and IAM members for each bucket.

By using YAML, configurations are easily customizable for different environments without changing the Terraform code itself. YAML is also very readable, so we can get a clear overview of our configuration.

### Terraform Resources

In the `main.tf` file, Terraform resources are defined to create and manage GCP services:

1. **Enabling Cloud Resource Manager API**: This ensures that the Cloud Resource Manager API is enabled for the project.
2. **IAM Members**: The `google_project_iam_member` resource is used to assign IAM roles to members based on the YAML configuration.
3. **Cloud Storage Buckets**: The `cloud-storage-from-yaml` module creates Cloud Storage buckets using the configuration defined in the YAML files.

### Child Modules

Child modules in Terraform are used to encapsulate and reuse resource configurations. In this project, the `cloud-storage-from-yaml` module is used as a child module to configure Cloud Storage buckets. The module is designed to accept parameters like bucket names, lifecycle rules, IAM members, and objects to be managed within the buckets.

By using child modules, we can define complex resources once and reuse them in multiple places, making the configuration more modular, maintainable, and scalable.

### Terraform Backend

The configuration uses **Google Cloud Storage (GCS)** as the backend for storing Terraform state. This allows multiple team members to collaborate on the infrastructure while keeping the state consistent. The backend configuration ensures that Terraform's state is stored in a centralized GCS bucket.

---
# TL;DR

- **Objective**: Use **Terraform**, **YAML**, and **GitHub Actions** to manage **Google Cloud** resources.
- **IaC Philosophy**: Automate infrastructure with reusable, scalable, and maintainable code.

### Key Concepts:
- **YAML → HCL → GCP**: YAML files drive Terraform configuration to manage resources in Google Cloud.
- **File Structure**:
  - `main.tf`: Main Terraform configuration.
  - `apps/*.yaml`: Environment-specific settings.
  - `modules/cloud-storage`: Reusable Cloud Storage module.
  - `.github/workflows`: GitHub Actions for CI/CD automation.
- **Benefits**: Use child modules for modularity, Google Cloud Storage for centralized Terraform state, and YAML for flexible, readable configuration.

---
