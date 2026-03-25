
# 🚀 Week 1: Production-Grade AWS 3-Tier Architecture (Terraform)

## 📌 Overview
This project demonstrates a **production-style 3-tier architecture on AWS** built using **Terraform modules**.

The goal was to design a **secure, scalable, and highly available infrastructure** while solving real-world cloud and networking issues.



## 🏗️ Architecture
   
   Internet
   ↓
   Application Load Balancer (Public Subnets)
   ↓
   Auto Scaling Group (Private Subnets)
   ↓
   RDS (MySQL - Private Subnets)

    * Bastion Host (Secure SSH Access)
    * NAT Gateway (Outbound Internet for private instances)


## ⚙️ Technologies Used

- AWS (VPC, EC2, ALB, ASG, RDS, NAT Gateway)
- Terraform (Modular Architecture)
- Linux (Ubuntu)
- Apache (Web Server)



## 🔥 Key Features

### ✅ Modular Terraform Design
- Reusable modules:
  - VPC
  - ALB
  - ASG
  - Security Groups
  - Bastion
  - RDS

### ✅ Secure Networking
- No public IP for application servers
- Private subnets for EC2 and RDS
- Bastion host for controlled SSH access

### ✅ High Availability
- Multi-AZ deployment
- Auto Scaling Group across private subnets
- Load balancing via ALB

### ✅ Infrastructure as Code (IaC)
- Entire infrastructure provisioned using Terraform


## 🧠 Real-World Issues Solved

### 🔧 ALB Target Group Unhealthy
- Cause: Missing HTTP access from ALB to EC2
- Fix: Updated security group to allow ALB → EC2 (port 80)

### 🔧 Private EC2 Could Not Install Packages
- Cause: Incorrect route table configuration
- Fix: Associated private subnets with NAT Gateway route table

### 🔧 No Internet Access in Private Subnet
- Cause: NAT Gateway misconfiguration
- Fix: Corrected routing and subnet associations

### 🔧 Terraform State Conflict
- Cause: Resource already existed outside Terraform
- Fix: Used unique naming / manual cleanup

### 🔧 Module Refactoring Errors
- Cause: Direct resource references inside modules
- Fix: Implemented proper variable and output passing

---

## 📂 Project Structure


terraform/
├── modules/
│ ├── vpc/
│ ├── alb/
│ ├── asg/
│ ├── security-groups/
│ ├── bastion/
│ ├── rds/
│
├── main.tf
├── variables.tf
├── outputs.tf


---

## 🚀 How to Deploy

terraform init
terraform plan
terraform apply


📊 Key Learnings
  
  * AWS VPC design (public vs private subnets)
  * NAT Gateway and routing concepts
  * Load balancing and auto scaling
  * Terraform module design
  * Debugging real-world infrastructure issues

🎯 Next Steps

  * CI/CD pipeline using GitHub Actions
  * HTTPS setup using ACM
  * Monitoring with CloudWatch
  * Docker-based deployment

👨‍💻 Author

Talin Praketa Kunuku
AWS & DevOps Engineer
