# Lab 10 - Azure Containers: ACR Import Scripts
# Dishmon Technologies
# Run in Azure Cloud Shell (PowerShell) or a PowerShell session with Azure CLI installed and authenticated.

# Step 1 - Import public NGINX image into ACR as v1
az acr import `
  --name acrdishmon06 `
  --source docker.io/library/nginx:latest `
  --image dishmon-nginx:v1

# Step 2 - Create a v2 tag from the existing ACR image
az acr import `
  --name acrdishmon06 `
  --source acrdishmon06.azurecr.io/dishmon-nginx:v1 `
  --image dishmon-nginx:v2
