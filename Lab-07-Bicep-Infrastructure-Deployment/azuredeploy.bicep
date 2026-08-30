param location string = resourceGroup().location
param vmName string = 'VM-Lab07-01'
param vmSize string = 'Standard_B2s'
param adminUsername string = 'azureadmin'

@secure()
param adminPassword string

var vnetName = 'VNET-Lab07'
var subnetName = 'SNET-Servers'
var nsgName = 'NSG-VM-Lab07-01'
var publicIpName = 'PIP-VM-Lab07-01'
var nicName = 'NIC-VM-Lab07-01'

resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.60.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.60.1.0/24'
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: []
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: nicName
  location: location
  properties: {
    networkSecurityGroup: {
      id: nsg.id
    }
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  tags: {
    Environment: 'Lab'
    Workload: 'Dishmon Technologies'
    ManagedBy: 'Bicep'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

resource vmName_CustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2023-09-01' = {
  parent: vm
  name: 'CustomScriptExtension'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -Command "New-Item -ItemType Directory -Path \'C:\\DishmonTech\' -Force; Set-Content -Path \'C:\\DishmonTech\\Lab07.txt\' -Value \'Configured by Azure Custom Script Extension - Lab 07\'"'
    }
  }
}

output vmResourceId string = vm.id
