# AWS 3-Tier Highly Available Architecture

## Overview
Designed and implemented a production-grade 3-tier architecture on AWS ensuring high availability, scalability, and security.

## Architecture
- Web Tier: ALB + Auto Scaling EC2 (Public Subnets)
- App Tier: Private EC2 instances behind internal load balancing
- Data Tier: RDS MySQL (Multi-AZ)
- Secure access via Bastion host

## Key Design Decisions
- Used private subnets for application and DB layers to enhance security
- Implemented NAT Gateway for controlled outbound internet access
- Enabled Auto Scaling to handle variable traffic
- Used ALB for traffic distribution across AZs

## High Availability
- Multi-AZ deployment across ap-south-1a and ap-south-1b
- Auto Scaling Groups for resilience

## Security
- Tier-based security groups
- No public access to DB
- Bastion host for controlled SSH access

## Improvements Planned
- Convert infra to Terraform (Week 1)
- Move app to Kubernetes (Week 2)
- Implement CI/CD pipeline (Week 4)
