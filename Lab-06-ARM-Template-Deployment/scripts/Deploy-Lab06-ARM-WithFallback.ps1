param(
    [string]$ResourceGroupName = "RG-Lab06-ARM",
    [string]$TemplateFile = "./azuredeploy.json",
    [string]$TemplateParameterFile = "./azuredeploy.parameters.json",
    [string]$VmSize = "Standard_B1s",
    [string[]]$Regions = @(
        "westus2",
        "westus3",
        "eastus2",
        "eastus",
        "centralus",
        "southcentralus",
        "northcentralus"
    )
)

Write-Host "`nLab 06 ARM deployment with regional fallback"
Write-Host "Resource group: $ResourceGroupName"
Write-Host "VM size:        $VmSize"
Write-Host "Template:       $TemplateFile"
Write-Host "Parameters:     $TemplateParameterFile`n"

$adminPassword = Read-Host "Enter the VM administrator password" -AsSecureString
$deploymentSucceeded = $false

foreach ($region in $Regions) {

    Write-Host "`n============================================================"
    Write-Host "Testing $VmSize in $region"
    Write-Host "============================================================"

    try {
        Test-AzResourceGroupDeployment `
            -ResourceGroupName $ResourceGroupName `
            -TemplateFile $TemplateFile `
            -TemplateParameterFile $TemplateParameterFile `
            -location $region `
            -vmSize $VmSize `
            -adminPassword $adminPassword `
            -ErrorAction Stop | Out-Null

        Write-Host "PRECHECK PASSED: $region"
    }
    catch {
        $message = $_.Exception.Message

        if ($message -match "QuotaExceeded") {
            Write-Host "PRECHECK FAILED (quota): $region"
        }
        elseif ($message -match "SkuNotAvailable|capacity") {
            Write-Host "PRECHECK FAILED (capacity/SKU): $region"
        }
        else {
            Write-Host "PRECHECK FAILED: $region"
            Write-Host $message
        }

        continue
    }

    # Attempt deployment immediately after successful validation.
    $deploymentName = "Lab06-ARM-$region-$(Get-Date -Format 'yyyyMMddHHmmss')"

    Write-Host "Attempting deployment immediately in $region..."

    try {
        $deployment = New-AzResourceGroupDeployment `
            -Name $deploymentName `
            -ResourceGroupName $ResourceGroupName `
            -TemplateFile $TemplateFile `
            -TemplateParameterFile $TemplateParameterFile `
            -location $region `
            -vmSize $VmSize `
            -adminPassword $adminPassword `
            -Mode Incremental `
            -ErrorAction Stop

        Write-Host "`nDEPLOYMENT SUCCEEDED"
        Write-Host "Region:          $region"
        Write-Host "VM size:         $VmSize"
        Write-Host "Deployment name: $deploymentName"

        $deployment | Select-Object DeploymentName, ProvisioningState, Timestamp

        $deploymentSucceeded = $true
        break
    }
    catch {
        $message = $_.Exception.Message

        if ($message -match "QuotaExceeded") {
            Write-Host "DEPLOYMENT FAILED (quota): $region"
        }
        elseif ($message -match "SkuNotAvailable|capacity") {
            Write-Host "DEPLOYMENT FAILED (capacity/SKU changed): $region"
        }
        else {
            Write-Host "DEPLOYMENT FAILED: $region"
            Write-Host $message
        }

        Write-Host "Moving to the next region..."
    }
}

if (-not $deploymentSucceeded) {
    Write-Host "`nNo region in the candidate list completed the deployment."
    Write-Host "The ARM template may still be valid; Azure capacity can change between validation and deployment."
    Write-Host "Consider rerunning later or expanding the region list."
}
