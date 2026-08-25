$vm = Get-AzVM -ResourceGroupName "RG-Compute" -Name "VM-Admin-01"

$vm | Select-Object `
    Name,
    Location,
    @{Name="VMSize";Expression={$_.HardwareProfile.VmSize}}
