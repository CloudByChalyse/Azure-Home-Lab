param(
    [Parameter(Mandatory = $false)]
    [string]$Location = "centralus"
)

Write-Host "`nAzure VM vCPU quota status for region: $Location`n"

$quota = Get-AzVMUsage -Location $Location |
    Where-Object { $_.Name.LocalizedValue -like "*vCPU*" } |
    Select-Object `
        @{Name="Quota";Expression={$_.Name.LocalizedValue}},
        @{Name="CurrentUsage";Expression={$_.CurrentValue}},
        @{Name="Limit";Expression={$_.Limit}},
        @{Name="Available";Expression={$_.Limit - $_.CurrentValue}}

$quota | Sort-Object Quota | Format-Table -AutoSize

Write-Host "`nVM families with available quota:`n"

$quota |
    Where-Object {
        $_.Available -gt 0 -and
        $_.Quota -notlike "Total Regional*"
    } |
    Sort-Object Available -Descending |
    Format-Table -AutoSize
