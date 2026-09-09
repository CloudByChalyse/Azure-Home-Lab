<#
.SYNOPSIS
    Lab 11 - Azure Windows VM RDP troubleshooting checks.

.DESCRIPTION
    Run this script from Azure VM Run Command (RunPowerShellScript) or from an
    elevated PowerShell session inside the Windows VM.

    It checks:
      - Remote Desktop Services (TermService)
      - TCP 3389 listener
      - Windows Firewall Remote Desktop rules
      - fDenyTSConnections registry setting
      - Local TCP connectivity to port 3389

.NOTES
    Dishmon Technologies - AZ-104 Lab 11
#>

Write-Host "=== RDP Service ==="
Get-Service TermService

Write-Host "`n=== Port 3389 Listener ==="
Get-NetTCPConnection -LocalPort 3389 -State Listen -ErrorAction SilentlyContinue

Write-Host "`n=== Windows Firewall RDP Rules ==="
Get-NetFirewallRule -DisplayGroup "Remote Desktop" |
    Select-Object DisplayName, Enabled, Direction, Action

Write-Host "`n=== RDP Registry Setting ==="
Get-ItemProperty `
    'HKLM:\System\CurrentControlSet\Control\Terminal Server' `
    -Name fDenyTSConnections

Write-Host "`n=== Local RDP Port Test ==="
Test-NetConnection -ComputerName 127.0.0.1 -Port 3389
