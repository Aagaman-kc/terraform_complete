<div align="center">

# 🏗️ Terraform Complete

### Mastering Infrastructure as Code with Terraform & LocalStack

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-purple.svg?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Provider-orange.svg?style=for-the-badge&logo=amazon-aws)
![LocalStack](https://img.shields.io/badge/LocalStack-Simulated-Green.svg?style=for-the-badge)
![HCL](https://img.shields.io/badge/HCL-Language-blue.svg?style=for-the-badge)

*A comprehensive journey through Terraform concepts — from basics to production-ready infrastructure patterns.*

</div>

---

## 📋 Overview

This repository demonstrates **9 progressive modules** covering Terraform's core concepts, implemented using **LocalStack** for local AWS service simulation. Each module builds upon the previous, creating a complete learning path from beginner to advanced infrastructure-as-code patterns.

### 🎯 Key Learning Outcomes

- **Provider Configuration** — AWS provider setup with version constraints
- **Remote State Management** — S3 backend with DynamoDB locking
- **Resource Provisioning** — EC2, S3, RDS, ALB, Route53, Security Groups
- **Variables & Outputs** — Typed variables, sensitive data handling, output exports
- **Modular Architecture** — Reusable module design with separation of concerns
- **Multi-Environment Management** — Workspaces and file-structure approaches
- **Infrastructure Testing** — Terratest integration and static analysis
- **Security Best Practices** — Encryption, least-privilege access, state protection

---

## 🗂️ Project Structure

```
terraform_complete/
├── 01-cloud-and-iac/           # Cloud evolution concepts
├── 02-overview/                # EC2 instance provisioning
├── 03-basics/                  # Web app architecture
│   ├── aws-backend/           # S3 + DynamoDB backend setup
│   └── web-app/               # Full stack: EC2, ALB, RDS, S3, Route53
├── 04-variables-and-outputs/   # Parameterized configurations
│   ├── examples/              # Variable types & validation
│   └── web-app/               # Refactored with variables
├── 05-language-features/       # HCL advanced features
├── 06-organization-and-modules/ # Reusable modules
│   ├── web-app-module/        # Module with compute, network, storage, dns, database
│   └── consul/                # Module instantiation example
├── 07-managing-multiple-environments/ # Environment strategies
│   ├── workspaces/            # Terraform workspaces approach
│   └── file-structure/        # Directory-based separation
├── 08-testing/                 # Quality assurance
│   ├── modules/               # Testable module definitions
│   ├── examples/              # Example configurations
│   ├── tests/                 # Terratest & static tests
│   └── deployed/              # Staging & production configs
├── 09-developer-workflows/     # CI/CD patterns
└── localstack-ui/             # LocalStack management interface
```

---

## 🏛️ Architecture Patterns Demonstrated

### Module 03 — Complete Web Application Stack

```
                    ┌─────────────────────────────────────────┐
                    │              Route 53 DNS               │
                    │         (domain alias → ALB)            │
                    └──────────────────┬──────────────────────┘
                                       │
                    ┌──────────────────▼──────────────────────┐
                    │        Application Load Balancer        │
                    │    (HTTP listener, path-based routing)  │
                    └──────┬─────────────────────────┬───────┘
                           │                         │
              ┌────────────▼───────────┐  ┌──────────▼────────────┐
              │    EC2 Instance 1      │  │    EC2 Instance 2      │
              │  (Ubuntu 20.04 LTS)    │  │  (Ubuntu 20.04 LTS)    │
              │  user_data: web server │  │  user_data: web server │
              └────────────┬───────────┘  └──────────┬────────────┘
                           │                         │
                    ┌──────▼─────────────────────────▼───────┐
                    │          Security Groups               │
                    │   (HTTP 8080 inbound, ALB rules)       │
                    └───────────────────┬────────────────────┘
                                        │
                    ┌───────────────────▼────────────────────┐
                    │     S3 Bucket (App Data)               │
                    │  (Versioned, AES256 encryption)        │
                    └────────────────────────────────────────┘
                    
                    ┌────────────────────────────────────────┐
                    │     RDS PostgreSQL (db.t2.micro)       │
                    │  (Engine v12, 20GB storage)            │
                    └────────────────────────────────────────┘
```

### Module 06 — Modular Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    web-app-module/                           │
├─────────────────────────────────────────────────────────────┤
│  variables.tf    │ Input definitions & validation           │
│  main.tf         │ Provider & terraform block               │
│  compute.tf      │ EC2 instances, auto-scaling              │
│  networking.tf   │ VPC, subnets, security groups            │
│  storage.tf      │ S3 buckets, encryption, versioning       │
│  database.tf     │ RDS instances, parameter groups          │
│  dns.tf          │ Route53 zones and records                 │
│  outputs.tf      │ Exported values for consumption          │
└─────────────────────────────────────────────────────────────┘
```

---

## 💻 Technical Skills Demonstrated

### Infrastructure Components

| Resource | Concepts Covered |
|----------|-----------------|
| **EC2** | Instance provisioning, user_data scripts, AMI selection, security groups |
| **S3** | Bucket creation, versioning, server-side encryption, bucket policies |
| **ALB** | Load balancer setup, target groups, listeners, health checks, routing rules |
| **RDS** | Database provisioning, engine configuration, storage allocation |
| **Route53** | DNS zones, alias records, domain routing |
| **Security Groups** | Ingress/egress rules, CIDR blocks, port configuration |

### Terraform Features

| Feature | Implementation |
|---------|---------------|
| **Remote Backend** | S3 bucket with DynamoDB state locking |
| **Variables** | String, number, bool, sensitive variables with descriptions |
| **Outputs** | Exported resource attributes for cross-module reference |
| **Data Sources** | VPC lookup, subnet discovery, AMI queries |
| **Modules** | Reusable, parameterized infrastructure components |
| **Workspaces** | Environment isolation (staging/production) |
| **Providers** | AWS provider with version constraints |

### Code Examples

**Remote State Configuration** (`03-basics/web-app/main.tf:1-18`):
```hcl
terraform {
  backend "s3" {
    bucket         = "devops-directive-tf-state"
    key            = "03-basics/web-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
```

**Variable Type Definitions** (`04-variables-and-outputs/web-app/variables.tf`):
```hcl
variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true  # Prevents logging in plan/apply output
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}
```

**Modular Resource Definition** (`08-testing/modules/hello-world/instance.tf`):
```hcl
resource "aws_instance" "instance" {
  ami             = "ami-011899242bb902164"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              python3 -m http.server 8080 &
              EOF
}

output "instance_ip_addr" {
  value = aws_instance.instance.public_ip
}
```

**Security Group Rules** (`03-basics/web-app/main.tf:75-87`):
```hcl
resource "aws_security_group" "instances" {
  name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
```

**Application Load Balancer** (`03-basics/web-app/main.tf:89-151`):
```hcl
resource "aws_lb" "load_balancer" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default_subnet.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_target_group" "instances" {
  name     = "example-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
```

---

## 🎓 Learning Path

| Module | Topic | Key Concepts |
|--------|-------|--------------|
| **01** | Cloud Evolution | IaC fundamentals, cloud computing history |
| **02** | First Steps | `terraform init`, `plan`, `apply`, `destroy` |
| **03** | Real-World Setup | Remote state, multi-resource architecture, load balancing |
| **04** | Flexibility | Input variables, output values, sensitive data |
| **05** | HCL Mastery | Expressions, functions, conditional logic |
| **06** | Code Organization | Module development, separation of concerns |
| **07** | Scale | Workspaces vs file-structure for multi-env |
| **08** | Quality | Terratest, static analysis, validation |
| **09** | Operations | CI/CD pipelines, team workflows |

---

## 🛠️ Tools & Technologies

<div align="center">

| Category | Technologies |
|----------|-------------|
| **IaC** | Terraform, HCL |
| **Cloud** | AWS (EC2, S3, ALB, RDS, Route53, VPC) |
| **Local Dev** | LocalStack (AWS simulation) |
| **Testing** | Terratest, static analysis |
| **Version Control** | Git, GitHub |
| **Backend** | S3, DynamoDB (state management) |

</div>

---

## 🚀 Getting Started

### Prerequisites

- Terraform >= 1.0
- AWS CLI configured (or LocalStack running)
- Git

### Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/terraform_complete.git
cd terraform_complete

# Initialize a module
cd 03-basics/web-app
terraform init

# Plan infrastructure changes
terraform plan

# Apply configuration
terraform apply

# Destroy when done
terraform destroy
```

### LocalStack Setup

```bash
# Start LocalStack
localstack start

# Configure AWS provider for LocalStack
export AWS_ENDPOINT_URL=http://localhost:4566
```

---

## 📚 Concepts Mastered

### State Management
- Remote state storage in S3
- State locking with DynamoDB
- State encryption at rest
- Workspace-based state isolation

### Security Practices
- Sensitive variable handling (`sensitive = true`)
- S3 bucket encryption (AES256)
- Least-privilege security group rules
- No hardcoded credentials

### Code Organization
- Single-file to multi-file progression
- Reusable module development
- Environment separation strategies
- Clear input/output contracts

### Testing Approaches
- Unit testing with Terratest
- Static code analysis
- Example-based validation
- Deployment verification

---

## 🏆 Achievements

- ✅ Built production-ready infrastructure patterns
- ✅ Implemented remote state management
- ✅ Created reusable, parameterized modules
- ✅ Managed multiple environments effectively
- ✅ Applied security best practices
- ✅ Developed testing strategies
- ✅ Understood CI/CD integration points

---

## 🙏 Acknowledgments

- **LocalStack UI** — [github.com/localstack-ui/localstack-ui](https://github.com/localstack-ui/localstack-ui) — Open-source LocalStack management interface
- **LocalStack** — AWS cloud simulation for local development and learning
- **HashiCorp** — Terraform and excellent documentation

---

## 📄 License

This project is for **educational and learning purposes**. Built with LocalStack to avoid AWS costs while mastering Infrastructure as Code concepts.

---

<div align="center">

**Built with ❤️ using Terraform & LocalStack**

*Demonstrating Infrastructure as Code mastery through practical implementation*

</div>
