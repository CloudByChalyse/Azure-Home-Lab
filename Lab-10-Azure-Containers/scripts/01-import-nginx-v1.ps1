# Lab 10 - Import public NGINX image into Azure Container Registry
# Registry: acrdishmon06
# Repository/Tag: dishmon-nginx:v1

az acr import `
  --name acrdishmon06 `
  --source docker.io/library/nginx:latest `
  --image dishmon-nginx:v1
