# Lab 07 – Bicep Infrastructure Deployment & ARM Migration

## Overview

This lab modernized an existing Azure Resource Manager (ARM) JSON deployment by migrating it to Bicep.

The original ARM template from Lab 06 was decompiled into Bicep, reviewed, cleaned up, validated, deployed, and then modified using a declarative Infrastructure as Code workflow.

The deployment supports the fictional **Dishmon Technologies** environment and demonstrates practical Azure Administrator skills including Bicep, ARM deployments, dependency management, Azure What-If, VM extensions, parameter handling, troubleshooting, and resource verification.

---

## Objectives

- Migrate an existing ARM JSON template to Bicep
- Review a decompiled Bicep file before deployment
- Understand explicit and implicit resource dependencies
- Use secure parameters for sensitive values
- Understand Bicep parameter precedence
- Validate Bicep syntax and best practices
- Validate the deployment with Azure Resource Manager
- Preview infrastructure changes using Azure What-If
- Deploy Azure infrastructure using Bicep
- Verify configuration inside an Azure VM
- Perform a declarative update to an existing resource
- Investigate What-If differences caused by Azure resource providers

---

## Azure Resources

The Bicep deployment created the following infrastructure in `RG-Compute`:

| Resource | Name |
|---|---|
| Virtual Network | `VNET-Lab07` |
| Subnet | `SNET-Servers` |
| Network Security Group | `NSG-VM-Lab07-01` |
| Public IP Address | `PIP-VM-Lab07-01` |
| Network Interface | `NIC-VM-Lab07-01` |
| Virtual Machine | `VM-Lab07-01` |
| VM Extension | `CustomScriptExtension` |

The VM was deployed to **East US 2** using the `Standard_D2_v3` VM size.

---

## ARM to Bicep Migration

The existing ARM template was copied from the previous ARM deployment lab and converted using:

```bash
az bicep decompile --file azuredeploy.json
```

The command generated:

```text
azuredeploy.bicep
```

Bicep displayed a warning explaining that decompilation is a **best-effort process** and that generated Bicep should be reviewed before deployment.

This demonstrated an important migration lesson:

> Successful decompilation does not guarantee that the generated Bicep is optimized, clean, or ready for production.

---

## Bicep Review and Cleanup

The migrated Bicep was reviewed before deployment.

Several values still referenced Lab 06 and the previous ARM deployment.

For example:

```text
VM-ARM-01
VNET-Lab06
NSG-VM-ARM-01
PIP-VM-ARM-01
NIC-VM-ARM-01
Lab06.txt
```

These were updated for Lab 07:

```text
VM-Lab07-01
VNET-Lab07
NSG-VM-Lab07-01
PIP-VM-Lab07-01
NIC-VM-Lab07-01
Lab07.txt
```

The subnet name remained:

```text
SNET-Servers
```

because it describes the purpose of the subnet rather than the deployment technology or lab number.

---

## Secure Parameters

The administrator password was preserved as a secure Bicep parameter:

```bicep
@secure()
param adminPassword string
```

No password was stored in the Bicep file or committed to the repository.

The password was supplied at deployment time using a shell variable.

This helps prevent the password from being handled like a normal deployment parameter value.

---

## Parameter Precedence

The Bicep file contained a default VM size:

```bicep
param vmSize string = 'Standard_B2s'
```

However, the parameter file specified:

```json
"vmSize": {
  "value": "Standard_D2_v3"
}
```

Because the parameter file explicitly supplied a value, Azure used:

```text
Standard_D2_v3
```

This demonstrated parameter precedence:

> An explicitly supplied deployment parameter overrides the default value declared in the Bicep template.

The `Standard_D2_v3` size was intentionally retained because it had already been confirmed to work with the subscription and deployment region.

---

## Resource Dependencies

The migrated template demonstrated both **explicit** and **implicit** dependencies.

### Explicit Dependency

The NIC retained an explicit dependency on the virtual network:

```bicep
dependsOn: [
  vnet
]
```

The subnet ID was generated using `resourceId()`, so the Bicep compiler could not infer the virtual network dependency from a symbolic resource reference alone.

### Implicit Dependency

The VM references the NIC using:

```bicep
id: nic.id
```

Because the VM symbolically references `nic`, Bicep automatically understands that the NIC must exist before the VM can be deployed.

The Custom Script Extension uses:

```bicep
parent: vm
```

This establishes the VM as the parent resource and creates the required dependency.

The effective deployment chain was:

```text
VNet / NSG / Public IP
          |
          v
         NIC
          |
          v
          VM
          |
          v
Custom Script Extension
```

---

## Bicep Validation

Before sending the deployment to Azure, the Bicep template was compiled locally:

```bash
az bicep build \
  --file azuredeploy.bicep \
  --stdout > /dev/null
```

The `--stdout` option was used to avoid overwriting the original `azuredeploy.json` ARM template.

The Bicep linter was also executed:

```bash
az bicep lint \
  --file azuredeploy.bicep
```

Both commands completed successfully.

### Validation Layers

This lab demonstrated several different validation stages:

```text
Bicep Build
    ↓
Bicep Lint
    ↓
ARM Deployment Validation
    ↓
Azure What-If
    ↓
Actual Deployment
    ↓
Post-Deployment Verification
```

Each stage answers a different question.

**Build:** Can the Bicep file compile?

**Lint:** Are there Bicep best-practice or quality issues?

**Deployment Validate:** Will Azure Resource Manager accept the deployment?

**What-If:** What changes does Azure expect to make?

**Deployment:** Can Azure actually provision the resources?

**Verification:** Did the deployed infrastructure behave as intended?

---

## ARM Deployment Validation

Before creating resources, the deployment was validated against Azure Resource Manager:

```bash
az deployment group validate \
  --resource-group RG-Compute \
  --template-file azuredeploy.bicep \
  --parameters @azuredeploy.parameters.json \
  adminPassword="$ADMIN_PASSWORD"
```

The command completed successfully with exit code:

```text
0
```

No Azure resources were created during validation.

---

## Azure What-If

Azure What-If was used before deployment:

```bash
az deployment group what-if \
  --resource-group RG-Compute \
  --template-file azuredeploy.bicep \
  --parameters @azuredeploy.parameters.json \
  adminPassword="$ADMIN_PASSWORD"
```

The initial result showed:

```text
Resource changes: 6 to create, 10 to ignore.
```

This confirmed that the Lab 07 resources would be created while unrelated resources already in `RG-Compute` would remain untouched.

This was an **incremental deployment**, so existing resources not declared in the template were not automatically deleted.

---

## Bicep Deployment

The infrastructure was deployed using:

```bash
az deployment group create \
  --name Lab07-Bicep-Deployment \
  --resource-group RG-Compute \
  --template-file azuredeploy.bicep \
  --parameters @azuredeploy.parameters.json \
  adminPassword="$ADMIN_PASSWORD"
```

Azure returned:

```text
"provisioningState": "Succeeded"
```

This confirmed that the Bicep deployment completed successfully.

---

## Custom Script Extension

The deployment included a Custom Script Extension for the Windows VM.

The extension created the directory:

```text
C:\DishmonTech
```

and the file:

```text
C:\DishmonTech\Lab07.txt
```

The file was configured with the following contents:

```text
Configured by Azure Custom Script Extension - Lab 07
```

---

## Guest OS Verification

A successful ARM deployment does not automatically prove that the intended configuration exists inside the guest operating system.

The VM configuration was therefore verified using Azure Run Command:

```bash
az vm run-command invoke \
  --resource-group RG-Compute \
  --name VM-Lab07-01 \
  --command-id RunPowerShellScript \
  --scripts "Get-Content 'C:\DishmonTech\Lab07.txt'"
```

Azure returned:

```text
Configured by Azure Custom Script Extension - Lab 07
```

This provided end-to-end verification:

```text
Bicep Template
     ↓
ARM Deployment
     ↓
Virtual Machine
     ↓
Custom Script Extension
     ↓
Guest OS Configuration
     ↓
Verified File
```

---

## Idempotency and Desired State

After the initial deployment, Azure What-If was executed again without intentionally changing the infrastructure.

The result showed:

```text
2 to modify
4 no change
11 to ignore
```

Further investigation showed that the two apparent modifications were:

```text
NIC-VM-Lab07-01
PIP-VM-Lab07-01
```

The VM, VNet, NSG, and Custom Script Extension were recognized as `NoChange`.

No duplicate resources were created.

---

## Investigating What-If Differences

The NIC and Public IP appeared as `Modify` even though no intentional changes had been made.

The What-If output was exported for further investigation:

```bash
az deployment group what-if \
  --resource-group RG-Compute \
  --template-file azuredeploy.bicep \
  --parameters @azuredeploy.parameters.json \
  adminPassword="$ADMIN_PASSWORD" \
  --no-pretty-print \
  -o json > whatif.json
```

The differences were inspected using `jq`.

### Public IP Differences

Azure returned properties such as:

```text
sku.tier = Regional
properties.ddosSettings.protectionMode = VirtualNetworkInherited
```

These values were added or normalized by Azure after deployment.

### NIC Differences

Azure returned properties such as:

```text
privateIPAddress = 10.60.1.4
privateIPAddressVersion = IPv4
```

The Bicep template specifies dynamic private IP allocation, so Azure chooses the actual IP address.

These properties were not hard-coded into Bicep.

### Lesson Learned

Azure What-If is extremely useful, but:

> `Modify` does not automatically mean that meaningful configuration drift exists.

Azure resource providers can populate default or calculated values after deployment.

An administrator should inspect the **property-level delta** before deciding whether a reported modification requires action.

---

## Declarative Infrastructure Update

To demonstrate declarative Infrastructure as Code, the existing VM definition was updated with tags:

```bicep
tags: {
  Environment: 'Lab'
  Workload: 'Dishmon Technologies'
  ManagedBy: 'Bicep'
}
```

The template was rebuilt and linted successfully.

Azure What-If then showed:

```text
VM-Lab07-01                         Modify
VM-Lab07-01/CustomScriptExtension  NoChange
```

The detailed What-If output confirmed that Azure intended to create the following tag configuration:

```json
{
  "Environment": "Lab",
  "ManagedBy": "Bicep",
  "Workload": "Dishmon Technologies"
}
```

The VM was not recreated.

The desired state was changed in Bicep, and Azure Resource Manager reconciled the existing resource to match it.

---

## Tag Verification

After redeployment, the VM tags were verified with:

```bash
az vm show \
  --resource-group RG-Compute \
  --name VM-Lab07-01 \
  --query tags \
  -o json
```

Azure returned:

```json
{
  "Environment": "Lab",
  "ManagedBy": "Bicep",
  "Workload": "Dishmon Technologies"
}
```

This verified the declarative update.

---

## Troubleshooting

### BCP007 Error While Editing Bicep

While adding tags, the tag block was accidentally inserted into the wrong location in the Bicep file.

The compiler returned multiple errors similar to:

```text
Error BCP007: This declaration type is not recognized.
```

The line numbers reported by Bicep were inspected.

This revealed:

- the tags had been inserted into the virtual network section instead of the VM resource
- an extra closing brace had prematurely ended the VNet resource

The Bicep structure was corrected and validation was run again.

Both:

```bash
az bicep build
```

and:

```bash
az bicep lint
```

then completed successfully.

### Terminal vs. Bicep Editor

Bicep declarations such as:

```bicep
param
var
resource
```

were initially pasted into the macOS terminal.

Zsh returned:

```text
command not found
```

because Bicep syntax belongs inside the `.bicep` file rather than the shell.

This reinforced the distinction between:

- Bicep source code
- Azure CLI commands
- shell commands

---

## Key Lessons Learned

- Bicep is a cleaner authoring language for Azure Resource Manager deployments than raw ARM JSON.
- Bicep still deploys through Azure Resource Manager.
- ARM-to-Bicep decompilation is a best-effort conversion and requires review.
- Explicit deployment parameters override Bicep default parameter values.
- Sensitive values should use `@secure()`.
- Bicep can infer dependencies through symbolic resource references.
- Explicit `dependsOn` is not required when an implicit dependency already exists.
- `az bicep build` verifies compilation but does not guarantee a successful Azure deployment.
- `az bicep lint` checks Bicep quality and best practices.
- ARM deployment validation checks the deployment without creating resources.
- Azure What-If previews infrastructure changes before deployment.
- What-If output should be investigated instead of accepted blindly.
- Declarative Infrastructure as Code describes the desired end state rather than a sequence of configuration commands.
- Redeploying Bicep does not automatically create duplicate resources.
- Post-deployment verification is necessary to prove that a workload actually functions as intended.

---

## AZ-104 Concepts Practiced

This lab reinforced the following Azure Administrator concepts:

- Azure Resource Manager
- ARM templates
- Bicep
- Resource group deployments
- Parameters and parameter files
- Secure parameters
- Parameter precedence
- Resource dependencies
- Explicit dependencies
- Implicit dependencies
- Virtual machines
- Managed disks
- Virtual networks
- Subnets
- Network interfaces
- Network security groups
- Public IP addresses
- VM extensions
- Azure Run Command
- Resource tags
- Azure What-If
- Deployment validation
- Incremental deployments
- Infrastructure as Code
- Declarative configuration
- Deployment troubleshooting

---

## Portfolio Evidence

Recommended screenshots for this lab:

1. **ARM to Bicep decompilation**  
   Shows the `az bicep decompile` command, generated `.bicep` file, and best-effort conversion warning.

2. **Initial Azure What-If**  
   Shows the planned Lab 07 resource creation before deployment.

3. **Successful Bicep deployment**  
   Shows `provisioningState: Succeeded`.

4. **Custom Script Extension verification**  
   Shows the contents of `C:\DishmonTech\Lab07.txt` returned from inside the VM.

5. **Declarative tag verification**  
   Shows the final VM tags:
   - `Environment: Lab`
   - `ManagedBy: Bicep`
   - `Workload: Dishmon Technologies`

---

## Repository Files

```text
Lab-07-Bicep-Infrastructure-Deployment/
├── README.md
├── azuredeploy.bicep
├── azuredeploy.json
├── azuredeploy.parameters.json
└── screenshots/
```

### `azuredeploy.json`

Original ARM JSON template used as the migration source.

### `azuredeploy.bicep`

Modernized Bicep version of the infrastructure deployment.

### `azuredeploy.parameters.json`

Deployment-specific parameter values.

No administrator password is stored in the repository.

---

## Cost Management

After deployment and verification, the virtual machine was deallocated:

```bash
az vm deallocate \
  --resource-group RG-Compute \
  --name VM-Lab07-01
```

The VM power state was verified as:

```text
VM deallocated
```

Deallocation stops VM compute charges.

Managed disks, public IP addresses, and other Azure resources may continue to incur charges until they are deleted.

---

## Result

Lab 07 successfully demonstrated the migration of an existing ARM deployment to Bicep and the full Infrastructure as Code workflow:

```text
ARM JSON
   ↓
Decompile
   ↓
Review and Refactor
   ↓
Build and Lint
   ↓
ARM Validation
   ↓
What-If
   ↓
Deploy
   ↓
Verify
   ↓
Change Desired State
   ↓
What-If
   ↓
Redeploy
   ↓
Verify Updated State
```

The resulting Bicep deployment provides a reusable and more maintainable Infrastructure as Code implementation for the Dishmon Technologies Azure environment.