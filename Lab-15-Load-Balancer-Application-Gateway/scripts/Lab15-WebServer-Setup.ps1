<#
.SYNOPSIS
    Lab 15 - Azure Load Balancer & Application Gateway web server setup.

.DESCRIPTION
    Installs IIS and creates the Dishmon Technologies test pages used in Lab 15.
    Run on the appropriate backend VM with -Role Sales or -Role Support.

.EXAMPLE
    .\Lab15-WebServer-Setup.ps1 -Role Sales

.EXAMPLE
    .\Lab15-WebServer-Setup.ps1 -Role Support
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Sales", "Support")]
    [string]$Role
)

Install-WindowsFeature -Name Web-Server -IncludeManagementTools

$serverName = $env:COMPUTERNAME
$rootPath = "C:\inetpub\wwwroot"

# Root page used for the Azure Load Balancer test.
$rootPage = @"
<html>
<head><title>Dishmon Technologies</title></head>
<body>
<h1>Dishmon Technologies</h1>
<h2>Server: $serverName</h2>
<p>Azure Load Balancer Lab 15</p>
</body>
</html>
"@

Set-Content -Path "$rootPath\index.html" -Value $rootPage

# Path-specific page used for Application Gateway path-based routing.
$folder = $Role.ToLower()
New-Item -Path "$rootPath\$folder" -ItemType Directory -Force | Out-Null

$rolePage = @"
<html>
<body>
<h1>Dishmon Technologies - $Role</h1>
<h2>Backend: $serverName</h2>
</body>
</html>
"@

Set-Content -Path "$rootPath\$folder\index.html" -Value $rolePage

Write-Host "IIS is installed and the $Role test page is ready on $serverName."
Write-Host "Root page: /"
Write-Host "Application Gateway page: /$folder/index.html"

# Health-probe test commands used during the lab:
# Stop-Service W3SVC
# Start-Service W3SVC
