# Kubernetes Monitoring Lab

Hands-on Kubernetes observability lab combining a "fragile" API with Prometheus monitoring, custom metrics, and Grafana dashboards. Demonstrates ServiceMonitor CRDs, Helm-based monitoring stack, and local Kubernetes workflows with Kind/Colima.

## Contents

- **fragile-api/**: Python Flask API instrumented with Prometheus client for custom metrics
- **To-Do API K8s-Ready/**: Kubernetes-ready To-Do API manifests

## Stack

- **Orchestration**: Kubernetes (Kind)
- **Monitoring**: kube-prometheus-stack (Prometheus, Grafana, Alertmanager)
- **Metrics**: Prometheus custom metrics + ServiceMonitor
- **Visualization**: Grafana dashboards
- **Container Runtime**: Docker + Colima
- **Package Manager**: Helm
- **IaC/Manifests**: Kubernetes YAML

## What This Demonstrates

- Deploying applications to Kubernetes with Deployments/Services
- Setting up kube-prometheus-stack via Helm
- Creating ServiceMonitors for automatic service discovery
- Exposing and scraping custom Prometheus metrics
- Building custom Grafana dashboards for application observability
- Local K8s development workflow with Kind
- Container image building and loading into Kind clusters

## Quick Start

```bash
# Start Colima
colima start --cpu 4 --memory 6

# Create cluster
kind create cluster --name sre-lab

# Build and load image
cd fragile-api
docker build -t fragile-api:v1 .
kind load docker-image fragile-api:v1 --name sre-lab

# Deploy app
kubectl apply -f deployment.yaml

# Install monitoring stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```

## Key Learnings

- Kubernetes service discovery and Prometheus Operator patterns
- Custom application instrumentation
- Observability-first mindset for reliability engineering
- Troubleshooting in containerized/Kubernetes environments

## Author

[Christopher Cardozo](https://github.com/christ634)
