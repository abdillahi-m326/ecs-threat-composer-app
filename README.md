# Production-Grade Deployment of AWS Threat Composer on AWS ECS Fargate

Production-ready deployment of the **AWS Threat Composer web application** on **AWS ECS Fargate** using **Terraform** for Infrastructure as Code. This project demonstrates real-world **DevOps, Cloud, and Platform Engineering** practices including modular Terraform, container orchestration, secure networking, and CI/CD-ready workflows.

> **Note:** This repository serves as a **portfolio and learning project**. Infrastructure may be created and destroyed as part of experimentation.

---

## 🏗️ Infrastructure Highlights

- Modular **Terraform** design with remote state management (S3 backend)
- Containerized frontend application using **Docker**
- **Nginx** as a reverse proxy and web server
- **AWS ECS Fargate** for serverless container orchestration
- IAM roles with least-privilege permissions
- Designed for high availability and scalability

---

## 🧭 Architecture Overview

High-level request flow:

```
User → Application Load Balancer → ECS Service → Docker Container → Nginx → Frontend App
```

This architecture follows cloud-native best practices and is suitable for production-style workloads.

---

## 📊 What This Project Demonstrates

| Domain | Implementation |
|------|----------------|
| Infrastructure as Code | Modular Terraform with reusable components and remote backend |
| Container Orchestration | ECS Fargate services, task definitions, health checks |
| Networking & Security | VPC-based networking, security groups, IAM roles |
| DevOps Practices | GitHub-ready structure, CI/CD extensibility |
| Cloud Architecture | Stateless services, scalable compute, managed infrastructure |

---

## 📁 Project Structure

```
.
├── app/
│   ├── Dockerfile              # Docker image definition
│   ├── nginx.conf              # Nginx configuration
│   ├── src/                    # Frontend source code
│   ├── public/                 # Static assets
│   └── package.json            # Application dependencies
│
├── terraform/
│   ├── backend.tf              # Remote state configuration
│   ├── provider.tf             # AWS provider setup
│   ├── main.tf                 # Core infrastructure resources
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Output values
│   └── modules/                # Reusable Terraform modules
│
├── .gitignore
└── README.md
```

---

## 🛠️ Prerequisites

### Tools

- Terraform >= 1.4
- Docker Engine
- AWS CLI configured
- AWS Account
- Node.js (for local development)

---

## 💻 Local Development

### Clone Repository

```bash
git clone <repo-url>
cd app
```

### Build Docker Image

```bash
docker build -t ecs-frontend-app .
```

### Run Container Locally

```bash
docker run -p 80:80 ecs-frontend-app
```

Access the application at:

```
http://localhost
```

---

## ☁️ AWS Deployment (Terraform)

### Configure Backend

Navigate to the Terraform directory:

```bash
cd terraform
```

Create `backend.tf` with your S3 bucket details:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "ecs-project/terraform.tfstate"
    region = "your-region"
  }
}
```

### Initialize Terraform

```bash
terraform init
```

### Plan Infrastructure

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```

---

## 🔁 CI/CD (Extensible)

This project is structured to support CI/CD pipelines such as **GitHub Actions**, including:

| Workflow | Trigger | Purpose |
|--------|--------|---------|
| Docker Build | App changes | Build & push container images |
| Terraform Plan | Pull Request | Validate infrastructure changes |
| Terraform Apply | Merge to main | Deploy infrastructure |
| Terraform Destroy | Manual | Tear down resources |

Security best practices such as **OIDC authentication** and **container vulnerability scanning (Trivy)** can be easily integrated.

---

## ✅ Deployment Verification

After deployment, verify:

- ECS service is running and healthy
- Task definition is active
- Application Load Balancer DNS resolves correctly
- Application is accessible via ALB endpoint

---

## 🎯 Learning Outcomes

- Hands-on experience with ECS Fargate deployments
- Practical Terraform usage for AWS infrastructure
- Docker and Nginx integration
- Production-style project structuring for DevOps roles

---

## 🚀 Future Improvements

1. **CI/CD Enhancements**
   - Add full GitHub Actions workflows
   - Implement blue-green deployments

2. **Security**
   - Add HTTPS using ACM
   - Store secrets in AWS Secrets Manager

3. **Scalability & Reliability**
   - Auto Scaling policies (CPU / Memory)
   - Multi-AZ networking enhancements

4. **Observability**
   - CloudWatch dashboards and alarms
   - Centralized logging and metrics

---

## 👤 Author

**Your Name**  
DevOps / Cloud Engineer

---

## 📄 License

This project is intended for educational and portfolio purposes.

