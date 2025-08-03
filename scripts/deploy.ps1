param(
    [string]$AppName = "airtasker"
)

Write-Host "Starting deployment..." -ForegroundColor Green

if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    Write-Host "Error: kubectl not found. Please install kubectl first." -ForegroundColor Red
    exit 1
}

if (-not (docker info 2>$null)) {
    Write-Host "Error: Docker not running. Please start Docker first." -ForegroundColor Red
    exit 1
}

if (-not (kubectl cluster-info 2>$null)) {
    Write-Host "Error: Cannot connect to Kubernetes cluster." -ForegroundColor Red
    exit 1
}

Write-Host "Building Docker image..." -ForegroundColor Yellow
docker build -t http-server:latest ./app

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to build Docker image" -ForegroundColor Red
    exit 1
}

Write-Host "Docker image built successfully" -ForegroundColor Green

Write-Host "Deploying to Kubernetes..." -ForegroundColor Yellow

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

Write-Host "Waiting for pods to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=http-server -n http-servers --timeout=300s

Write-Host "Deployment completed!" -ForegroundColor Green

Write-Host "`nDeployment Status:" -ForegroundColor Cyan
kubectl get pods -n http-servers
kubectl get services -n http-servers
kubectl get ingress -n http-servers

Write-Host "`nAccess the application at: http://localhost/" -ForegroundColor Green
Write-Host "Health check: http://localhost/healthcheck" -ForegroundColor Green 
