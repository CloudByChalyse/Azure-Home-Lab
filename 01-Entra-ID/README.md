# Microsoft Entra ID

## Project Summary

This lab focused on administering identities in **Microsoft Entra ID** as part of an Azure Administrator environment.

The project covered the core identity-management tasks an Azure administrator may perform, including creating and managing users and groups, working with administrative units, reviewing device identities, configuring external access, and evaluating Self-Service Password Reset (SSPR).

The lab also reinforced the relationship between **identity, authentication, administrative scope, and access management** in Azure.

---

## Scenario

An organization is preparing its Microsoft Entra ID environment for day-to-day identity administration.

As the Azure administrator, I was responsible for configuring and reviewing the identity components needed to support employees, administrative delegation, devices, and external users.

The environment needed to support the following requirements:

- Create and manage organizational user accounts.
- Organize users through Microsoft Entra groups.
- Understand assigned and dynamic group membership.
- Delegate administration to a limited portion of the directory.
- Review how devices are represented in Microsoft Entra ID.
- Evaluate Self-Service Password Reset for users.
- Provide controlled access for an external guest user.
- Verify that the completed identity configurations were visible and functioning as expected.

---

## Workflow

### 1. Created and Managed Microsoft Entra ID Users

Created and reviewed user accounts within Microsoft Entra ID.

Activities included:

- Creating new users.
- Reviewing user properties.
- Managing account information.
- Verifying that users were successfully created in the tenant.

**Result:** Established the user identities required for the remaining identity-management tasks.

---

### 2. Created and Managed Groups

Configured Microsoft Entra groups to organize users and simplify access management.

Reviewed:

- Security groups.
- Assigned membership.
- Dynamic membership concepts.
- Group-based administration.

**Result:** Demonstrated how groups can be used to manage collections of users rather than assigning access individually.

---

### 3. Reviewed Administrative Units

Worked with **Administrative Units** to understand how administrative responsibility can be delegated to a limited portion of the Microsoft Entra directory.

This demonstrated how an organization can provide administrators with authority over specific users or groups without granting unnecessary tenant-wide administrative access.

**Result:** Reinforced scoped administration and least-privilege access.

---

### 4. Reviewed Device Identity

Reviewed how devices are represented and managed within Microsoft Entra ID.

The lab covered the distinction between managed and unmanaged devices and how device identities can participate in an organization's identity environment.

**Result:** Expanded identity administration beyond users and groups to include organizational devices.

---

### 5. Evaluated Self-Service Password Reset (SSPR)

Reviewed the configuration process for **Self-Service Password Reset**.

During the hands-on configuration, the required SSPR functionality was unavailable in the training environment because the feature required a licensing level that was not included with the lab subscription.

Rather than treating the configuration as successfully completed, I identified and documented the licensing dependency.

**Result:** Confirmed that Microsoft Entra feature availability can depend on licensing and that licensing should be validated during troubleshooting.

---

### 6. Configured External / Guest User Access

Reviewed and practiced the process for inviting an external user into the Microsoft Entra tenant.

The exercise reinforced:

- Business-to-Business (B2B) collaboration.
- Guest identities.
- External user invitations.
- Limiting access based on business requirements.
- Least-privilege access for external identities.

**Result:** Demonstrated how external users can be incorporated into an organization's identity environment without creating a standard internal employee account.

---

### 7. Verified the Configuration

Validated the completed identity-management work through the Azure portal.

Verification included reviewing:

- Created users.
- Group membership.
- Administrative scope.
- Device-related identity settings.
- External guest-user configuration.
- Available SSPR settings and licensing limitations.

**Result:** Confirmed that the completed configurations were present and documented any functionality that could not be completed because of licensing.

---

## Workflow Summary

```text
Create Users
     ↓
Create & Configure Groups
     ↓
Review Administrative Units
     ↓
Review Device Identities
     ↓
Evaluate SSPR
     ↓
Configure External / Guest User
     ↓
Verify Identity Configuration
```

---

## Skills Demonstrated

- Microsoft Entra ID administration
- User and group management
- Administrative Units
- Identity and authentication concepts
- Device identity concepts
- Self-Service Password Reset
- External / guest user management
- B2B collaboration concepts
- Least-privilege administration
- Azure portal administration
- Troubleshooting licensing dependencies

---

## Project Outcome

The lab established a foundational Microsoft Entra ID environment and demonstrated the identity-management responsibilities commonly performed by an Azure administrator.

By completing the workflow, I gained hands-on experience managing internal and external identities, organizing users through groups, reviewing delegated administration, validating device identity concepts, and troubleshooting a licensing-related SSPR limitation.

---

## Related Reconstructed Lab

- [Microsoft Entra ID Tenants & Custom Domains](./reconstructed-tenants-custom-domains/) — Tenant relationships, tenant-creation restrictions, custom-domain TXT verification, troubleshooting, and verification.

---

[← Back to Azure Home Lab Portfolio](../README.md)

