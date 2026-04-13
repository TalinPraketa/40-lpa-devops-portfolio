# Week 3: Kubernetes SRE Demo Platform

## Overview
This project demonstrates how I deployed a Python application on Kubernetes with SRE-focused practices such as health checks, readiness/liveness probes, autoscaling, resource management, and automation.

## Key Features
- Python Flask application
- Dockerized workload
- Kubernetes Deployment, Service, Ingress, ConfigMap
- Liveness and readiness probes
- HPA for horizontal scaling
- Python health check automation
- CI pipeline for container build

## SRE Practices Implemented
- Self-healing through probes
- Scalability through HPA
- Reliability through multi-replica deployment
- Config externalization using ConfigMap
- Automation using Python and GitHub Actions

## Interview Talking Points
- Why liveness vs readiness probes matter
- How HPA works
- How I would extend this with Prometheus and Grafana
- How I would deploy this on EKS using Terraform
