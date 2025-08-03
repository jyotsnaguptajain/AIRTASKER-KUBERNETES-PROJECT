# Airtasker Kubernetes Project

Simple HTTP server deployed on Kubernetes.

## Quick Start

1. Build and deploy:
```powershell
.\scripts\deploy.ps1
```

2. Access the application:
- Main endpoint: http://localhost/
- Health check: http://localhost/healthcheck

## Project Structure

- `app/` - Flask application and Dockerfile
- `k8s/` - Kubernetes manifests
- `scripts/` - Deployment script

## Requirements

- Docker Desktop
- kubectl
- Kubernetes cluster (Docker Desktop, minikube, etc.) 