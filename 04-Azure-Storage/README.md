# Azure Storage

## Project Summary

This lab focused on administering **Azure Storage** and selecting the appropriate storage, security, access, data-management, and transfer options for different business requirements.

The project covered storage account configuration, Blob Storage, Azure Files, storage authorization, Shared Access Signatures (SAS), Microsoft Entra ID and RBAC, access keys, lifecycle management, object replication, AzCopy, Storage Browser / Storage Explorer, and file share snapshots.

The lab also included hands-on troubleshooting of storage configuration and effective permissions.

---

## Scenario

An organization needs Azure Storage for shared files, blob-based business data, temporary external access, and long-term data management.

As the Azure administrator, I was responsible for creating and configuring the storage environment, selecting appropriate authorization methods, validating access, and reviewing features that support data movement, lifecycle management, replication, and recovery.

The environment needed to support the following requirements:

- Configure an Azure Storage account.
- Create a blob container for finance-related data.
- Upload and verify stored data.
- Provide temporary scoped access when appropriate.
- Support identity-based access for organizational users.
- Understand when storage account access keys provide broader access.
- Configure and troubleshoot storage access settings.
- Review automated data-tiering and replication options.
- Review tools for file transfer and interactive storage management.
- Understand Azure Files and file share snapshots.

---

## Workflow

### 1. Created and Reviewed the Storage Account

Created and reviewed an Azure Storage account and evaluated configuration areas including:

- Redundancy.
- Performance.
- Access tiers.
- Networking.
- Data protection.
- Encryption.
- Authorization settings.

**Result:** Established the storage account that provided the foundation for the remaining storage exercises.

---

### 2. Created the Blob Container

Created a Blob Storage container named:

```text
finance-reports
```

Uploaded a file to the container and verified that the object was successfully stored.

**Result:** Demonstrated hands-on administration of Azure Blob Storage.

---

### 3. Troubleshot Anonymous Access Configuration

During the blob exercise, the anonymous-access option was initially unavailable at the container level.

Investigation showed that anonymous blob access first had to be enabled at the **storage account level**.

Enabled the required account-level setting before continuing with the container configuration.

**Result:** Identified an upstream storage-account dependency that controlled whether the lower-level container feature was available.

---

### 4. Compared Storage Authorization Methods

Reviewed and compared the primary authorization options used in Azure Storage.

#### Shared Access Signature (SAS)

Evaluated SAS for temporary and scoped access to a storage resource.

A SAS can restrict:

- Resource access.
- Allowed operations.
- Expiration time.

#### Microsoft Entra ID + Azure RBAC

Reviewed identity-based authorization for users and managed identities without distributing storage account keys.

#### Storage Account Access Keys

Reviewed access keys as a broad account-level authorization method that must be protected carefully.

**Result:** Matched authorization methods to different business and security requirements.

---

### 5. Tested RBAC-Based Storage Access

Tested storage permissions using Azure RBAC.

During validation, an account with a restrictive storage role was still able to perform write actions.

Investigation showed the test account also inherited **Owner** permissions from a higher Azure scope.

**Result:** Confirmed that effective storage authorization can be affected by RBAC assignments inherited from outside the storage resource itself.

---

### 6. Reviewed Azure Files

Reviewed **Azure Files** for SMB-based cloud file shares and scenarios where a share may be mapped and accessed similarly to a traditional file server.

**Result:** Distinguished Azure Files from Blob Storage based on workload and access method.

---

### 7. Reviewed Lifecycle Management

Reviewed Azure Blob Lifecycle Management for automatically managing stored data as it ages.

Evaluated scenarios such as:

- Moving older data to cooler tiers.
- Archiving infrequently accessed data.
- Deleting expired content.

**Result:** Demonstrated how storage costs and retention can be managed through automated lifecycle rules.

---

### 8. Reviewed Object Replication

Reviewed **Object Replication** for asynchronously copying block blobs between storage accounts.

Compared its purpose with Lifecycle Management:

```text
Lifecycle Management
→ Changes how data is stored over time

Object Replication
→ Copies data to another storage account
```

**Result:** Distinguished automated tier management from cross-account blob replication.

---

### 9. Reviewed Storage Transfer and Management Tools

Reviewed tools used to interact with Azure Storage.

#### AzCopy

Evaluated AzCopy for:

- Bulk transfers.
- Scripted data movement.
- Migration.
- Automation.

#### Storage Browser / Storage Explorer

Reviewed graphical tools for interactively managing storage data.

**Result:** Identified appropriate tools for command-line and graphical storage administration.

---

### 10. Reviewed File Share Snapshots

Reviewed Azure Files snapshots as point-in-time copies that can support recovery from accidental changes or deletion.

**Result:** Added file-level recovery concepts to the storage administration workflow.

---

### 11. Verified the Storage Configuration

Validated the completed storage work by reviewing:

- Storage account settings.
- The `finance-reports` container.
- Successful blob upload.
- Authorization configuration.
- RBAC behavior.
- Lifecycle management options.
- Object replication options.
- Azure Files and snapshot concepts.

**Result:** Confirmed the configured storage environment and documented the access-control behavior discovered during testing.

---

## Workflow Summary

```text
Create Storage Account
        ↓
Create finance-reports Container
        ↓
Upload & Verify Blob
        ↓
Troubleshoot Account-Level Access Setting
        ↓
Compare SAS / Entra RBAC / Access Keys
        ↓
Test Effective RBAC Access
        ↓
Review Azure Files
        ↓
Review Lifecycle Management
        ↓
Review Object Replication
        ↓
Review AzCopy & Storage Explorer
        ↓
Review File Share Snapshots
        ↓
Verify Storage Configuration
```

---

## Skills Demonstrated

- Azure Storage Accounts
- Azure Blob Storage
- Azure Files
- Storage redundancy and tiers
- Shared Access Signatures (SAS)
- Microsoft Entra ID authorization
- Azure RBAC
- Storage account access keys
- Storage networking and data protection
- Lifecycle Management
- Object Replication
- AzCopy
- Storage Browser / Storage Explorer
- File share snapshots
- Permissions troubleshooting
- Configuration dependency troubleshooting

---

## Project Outcome

The lab established a working understanding of Azure Storage administration across storage configuration, data access, authorization, data movement, lifecycle management, replication, and recovery.

By completing the workflow, I gained hands-on experience creating and validating blob storage, troubleshooting account-level settings, evaluating storage authorization methods, identifying inherited RBAC permissions, and selecting Azure Storage features and tools based on business requirements.

---

## Related Reconstructed Lab

- [Azure Storage Security & Data Protection](./reconstructed-security-data-protection/) — ZRS, access tiers, soft delete, blob versioning, customer-managed keys, SAS, private endpoints, network restrictions, and Microsoft Entra storage authorization.

---

[← Back to Azure Home Lab Portfolio](../README.md)
