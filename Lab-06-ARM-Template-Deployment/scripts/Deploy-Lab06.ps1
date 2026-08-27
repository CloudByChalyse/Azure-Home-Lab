param(
    [string]$ResourceGroupName = "RG-Lab06-ARM",
    [string]$TemplateFile = "./azuredeploy.json",
    [string]$TemplateParameterFile = "./azuredeploy.parameters.json",
    [string]$DeploymentName = "Lab06-ARM-Deployment"
)

Write-Host "`nLab 06 - ARM Template Deployment"
Write-Host "Resource group:  $ResourceGroupName"
Write-Host "Template file:   $TemplateFile"
Write-Host "Parameter file:  $TemplateParameterFile"
Write-Host "Deployment name: $DeploymentName`n"

if (-not (Test-Path $TemplateFile)) {
    throw "Template file not found: $TemplateFile"
}

if (-not (Test-Path $TemplateParameterFile)) {
    throw "Parameter file not found: $TemplateParameterFile"
}

$resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    throw "Resource group '$ResourceGroupName' does not exist."
}

$adminPassword = Read-Host "Enter the VM administrator password" -AsSecureString

Write-Host "`nRunning ARM preflight validation..."

Test-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParameterFile `
    -adminPassword $adminPassword `
    -ErrorAction Stop | Out-Null

Write-Host "Preflight validation passed."
Write-Host "Starting Incremental deployment...`n"

$deployment = New-AzResourceGroupDeployment `
    -Name $DeploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $TemplateParameterFile `
    -adminPassword $adminPassword `
    -Mode Incremental `
    -ErrorAction Stop

$deployment |
    Select-Object DeploymentName, ResourceGroupName, ProvisioningState, Mode, Timestamp

if ($deployment.ProvisioningState -eq "Succeeded") {
    Write-Host "`nDeployment succeeded."
}
else {
    Write-Host "`nDeployment finished with state: $($deployment.ProvisioningState)"
}
