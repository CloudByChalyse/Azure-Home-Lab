# Lab 10 - Create a v2 tag from the existing private ACR image
# Registry: acrdishmon06
# Source: dishmon-nginx:v1
# New Tag: dishmon-nginx:v2

az acr import `
  --name acrdishmon06 `
  --source acrdishmon06.azurecr.io/dishmon-nginx:v1 `
  --image dishmon-nginx:v2
