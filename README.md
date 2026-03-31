# Terraform AWS ECS Modular Infrastructure

This repository contains a modular Terraform project for deploying AWS infrastructure with:

- a custom VPC  
- 2 public subnets  
- 2 private subnets  
- an Internet Gateway  
- route tables  
- security groups  
- an Application Load Balancer  
- a target group  
- Route53 DNS  
- an ECS Fargate service  

This project is designed as both a **learning repository** and a **foundation for future projects**.

---

## Architecture Overview

The infrastructure is split into reusable Terraform modules:

- **vpc**  
  Creates the VPC, subnets, route tables, Internet Gateway, ECS service security group, and VPC endpoints.

- **alb**  
  Creates the Application Load Balancer, ALB security group, listener, and target group.

- **ecs**  
  Creates the ECS cluster, task definition, ECS service, CloudWatch log group, and IAM roles.

- **dns**  
  Creates the Route53 DNS record that points to the ALB.

---

## Project Structure

```text
terraform-aws-ecs-modular/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules
    ├── vpc
    ├── alb
    ├── ecs
    └── dns
```
---

## What This Configuration Creates

### Networking

- 1 VPC  
- 2 public subnets across 2 AZs  
- 2 private subnets across 2 AZs  
- Internet Gateway  
- public and private route tables  

### Load Balancing

- Application Load Balancer (ALB)  
- ALB listener  
- target group  

### Compute

- ECS cluster  
- ECS task definition  
- ECS Fargate service  

### Security

- ALB security group  
- ECS service security group  
- VPC endpoint security group  

---

## Private Architecture (No NAT Gateway)

This project **intentionally does not use a NAT Gateway**.

Instead, it uses **VPC endpoints** for:

- ECR API  
- ECR Docker  
- CloudWatch Logs  
- S3  

### Why this matters

- ECS tasks run in **private subnets**
- No direct internet access
- AWS service communication happens privately inside the VPC

---

## How to Use

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```
---

## Repository Purpose

- a learning lab for Terraform and AWS
- a baseline template for future infrastructure projects
