# Azure Role-Based Access Control (RBAC)

## Project Summary

This lab focused on administering access to Azure resources using **Azure Role-Based Access Control (RBAC)**.

The project covered the core authorization tasks an Azure administrator performs, including selecting built-in roles, assigning permissions at the appropriate scope, applying least-privilege access, using Azure PowerShell for role assignments, and evaluating effective permissions when access is inherited from higher levels in the Azure hierarchy.

The lab reinforced the distinction between **authentication through Microsoft Entra ID** and **authorization through Azure RBAC**.

---

## Scenario

An organization needs to provide users with access to Azure resources while preventing unnecessary administrative privileges.

As the Azure administrator, I was responsible for assigning the appropriate built-in roles to identities at the **resource group scope** and verifying that the resulting permissions matched the intended access requirements.

The environment needed to support the following requirements:

- Use Azure built-in roles instead of granting unnecessary full administrative access.
- Assign permissions at an appropriate Azure scope.
- Provide read access to storage data where modification was not required.
- Provide Contributor access where resource management was required.
- Use PowerShell to perform repeatable role assignments.
- Review inherited access when observed permissions exceeded the newly assigned role.
- Verify the effective access granted to the identity.

---

## Workflow

### 1. Reviewed Azure RBAC Components

Reviewed the three elements required to create an Azure role assignment:

```text
Security Principal
      +
Role Definition
      +
Scope
      =
Role Assignment
```

Identified how Microsoft Entra identities are authenticated first and then authorized to Azure resources through RBAC.

**Result:** Established the authorization model used throughout the remainder of the lab.

---

### 2. Reviewed Built-In Azure Roles

Reviewed commonly used Azure built-in roles, including:

- Reader
- Contributor
- Owner
- Storage Blob Data Reader

Compared the permissions provided by each role and identified when a narrower role would satisfy the access requirement.

**Result:** Reinforced role selection based on least privilege instead of convenience.

---

### 3. Evaluated Azure RBAC Scope

Reviewed the Azure scope hierarchy:

```text
Management Group
      ↓
Subscription
      ↓
Resource Group
      ↓
Resource
```

Selected the **resource group** as the working scope for the hands-on role assignments.

**Result:** Applied permissions at a scope that covered the required resources without unnecessarily assigning access across the entire subscription.

---

### 4. Assigned Storage Blob Data Reader

Assigned the **Storage Blob Data Reader** role at resource group scope using Azure PowerShell.

This role provides read access to blob data without granting broad resource-management permissions.

**Result:** Practiced assigning a data-plane role that matched a read-only storage requirement.

---

### 5. Assigned Contributor Access

Assigned the **Contributor** role at resource group scope using Azure PowerShell.

Reviewed how Contributor permits resource management while preventing the user from granting Azure RBAC permissions to other identities.

**Result:** Demonstrated the difference between resource administration and access-control administration.

---

### 6. Tested and Troubleshot Effective Permissions

During access testing, the account was still able to perform write actions even when a more restrictive role was being evaluated.

Investigation showed that the account already had **Owner** permissions inherited from a higher scope.

This demonstrated that a lower-level role assignment does not remove broader access already inherited from another assignment.

**Result:** Identified inherited RBAC permissions as the reason the observed access exceeded the permissions of the role being tested.

---

### 7. Verified Role Assignments

Validated the completed RBAC configuration by reviewing:

- Security principal.
- Assigned role.
- Assignment scope.
- Inherited permissions.
- Effective access behavior.

Compared the expected permissions with the access observed during testing.

**Result:** Confirmed that the role assignments were applied and correctly explained why inherited Owner access affected the test results.

---

## Workflow Summary

```text
Review RBAC Components
        ↓
Select Built-In Roles
        ↓
Choose Resource Group Scope
        ↓
Assign Storage Blob Data Reader
        ↓
Assign Contributor
        ↓
Test Effective Access
        ↓
Identify Inherited Owner Permission
        ↓
Verify Role Assignments
```

---

## Skills Demonstrated

- Azure Role-Based Access Control (RBAC)
- Microsoft Entra ID and Azure authorization concepts
- Built-in Azure roles
- Resource group scope
- Role inheritance
- Effective access analysis
- Least-privilege administration
- Storage Blob Data Reader
- Contributor role
- Azure PowerShell
- Permissions troubleshooting

---

## Project Outcome

The lab demonstrated how Azure RBAC can be used to provide controlled access to Azure resources through built-in roles and appropriately scoped assignments.

By completing the workflow, I gained hands-on experience assigning permissions with PowerShell, applying least-privilege principles, evaluating Azure scope and inheritance, and troubleshooting effective access when higher-level permissions affected the expected authorization behavior.

---

## Related Reconstructed Lab

- [Azure RBAC, Scope & Storage Authorization](./reconstructed-scope-storage-authorization/) — RBAC inheritance, management-plane vs. data-plane access, Storage Blob Data Reader/Contributor, custom roles, and least-privilege troubleshooting.

---

[← Back to Azure Home Lab Portfolio](../README.md)
