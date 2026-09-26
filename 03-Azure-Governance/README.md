# Azure Governance & Policy

## Project Summary

This lab focused on implementing **Azure governance controls** used to organize, protect, standardize, and manage cloud resources.

The project covered subscription administration, Cost Management, resource locks, tags, Azure Policy, moving resources, PowerShell-based governance tasks, and management groups.

The lab reinforced how Azure administrators use governance services to control both **how resources are organized** and **which configurations are allowed within the environment**.

---

## Scenario

An organization needs a consistent governance model for its Azure environment.

As the Azure administrator, I was responsible for reviewing the subscription structure and implementing governance controls that would help protect resources, organize them for administration and cost reporting, enforce configuration standards, and prepare the environment for governance across multiple subscriptions.

The environment needed to support the following requirements:

- Review subscription-level administration and cost information.
- Protect important resources from accidental deletion or modification.
- Organize resources using standardized metadata.
- Enforce or audit configuration requirements with Azure Policy.
- Understand how governance scope affects child resources.
- Review requirements for moving Azure resources.
- Use PowerShell to perform governance-related administration.
- Understand how management groups extend governance above the subscription level.

---

## Workflow

### 1. Reviewed Subscription Administration

Reviewed the Azure subscription dashboard and the role a subscription plays in:

- Billing.
- Resource organization.
- Access control.
- Policy assignment.
- Cost management.

**Result:** Established the subscription as a key administrative and governance boundary in Azure.

---

### 2. Reviewed Azure Cost Management

Reviewed Azure Cost Management capabilities used to monitor resource consumption and cloud spending.

Evaluated how administrators can use subscription and resource information to understand where Azure costs are being generated.

**Result:** Reinforced cost awareness as part of normal Azure administration.

---

### 3. Configured Resource Locks

Worked with Azure resource locks to protect resources from accidental administrative actions.

Reviewed the primary lock types:

- **CanNotDelete** — allows modification but blocks deletion.
- **ReadOnly** — blocks modification and deletion.

Also reviewed how locks applied at higher scopes can affect child resources.

**Result:** Demonstrated how Azure administrators can add an additional protection layer to critical resources.

---

### 4. Applied Resource Tags

Used Azure tags to organize resources through metadata.

Reviewed common tagging categories such as:

- Environment.
- Department.
- Owner.
- Application.
- Cost center.

**Result:** Demonstrated how tagging can improve organization, reporting, ownership tracking, and cost allocation.

---

### 5. Implemented Azure Policy

Worked with **Azure Policy** to understand how configuration standards can be audited or enforced.

Reviewed policy behavior such as:

- Auditing resources.
- Denying noncompliant deployments.
- Requiring organizational settings.
- Evaluating resources within the assigned scope.

**Result:** Demonstrated how governance rules can control what configurations are allowed in an Azure environment.

---

### 6. Used PowerShell for Governance Administration

Performed governance-related tasks with PowerShell when command-line administration provided a repeatable alternative to portal-only configuration.

This reinforced the value of automation when governance controls must be applied consistently.

**Result:** Added command-line administration to the governance workflow.

---

### 7. Reviewed Resource Movement

Reviewed how Azure resources can be moved between resource groups and the dependencies administrators should validate before initiating a move.

Considered how resource relationships and service support can affect whether a move is permitted.

**Result:** Reinforced the need to validate resource dependencies before reorganizing production resources.

---

### 8. Reviewed Management Groups

Reviewed **Management Groups** and how they extend Azure governance above individual subscriptions.

```text
Management Group
      ↓
Subscriptions
      ↓
Resource Groups
      ↓
Resources
```

Reviewed how policies and access controls can be inherited through this hierarchy.

**Result:** Demonstrated how larger organizations can apply governance consistently across multiple Azure subscriptions.

---

### 9. Verified Governance Configuration

Validated the governance concepts and configurations by reviewing:

- Subscription organization.
- Cost Management information.
- Resource lock settings.
- Resource tags.
- Azure Policy assignment and scope.
- Resource group placement.
- Management group hierarchy.

**Result:** Confirmed how the individual governance controls work together to manage an Azure environment.

---

## Workflow Summary

```text
Review Subscription
        ↓
Review Cost Management
        ↓
Configure Resource Locks
        ↓
Apply Tags
        ↓
Implement Azure Policy
        ↓
Use PowerShell
        ↓
Review Resource Movement
        ↓
Review Management Groups
        ↓
Verify Governance Controls
```

---

## Skills Demonstrated

- Azure subscriptions
- Azure Cost Management
- Resource Groups
- Azure Resource Locks
- Azure Tags
- Azure Policy
- Policy scope and inheritance
- Resource movement concepts
- Management Groups
- Azure PowerShell
- Governance hierarchy
- Azure Policy vs Azure RBAC concepts

---

## Project Outcome

The lab established a practical understanding of how Azure governance controls are used to organize resources, reduce administrative risk, enforce standards, and manage environments at scale.

By completing the workflow, I gained hands-on experience with resource locks, tags, Azure Policy, subscription administration, PowerShell-based governance, resource organization, and the management-group hierarchy used to extend governance across multiple subscriptions.

---

## Related Reconstructed Lab

- [Azure Governance, Policy, Locks & Cost Management](./reconstructed-policy-locks-cost-management/) — Required-tag policy enforcement, policy troubleshooting, CostCenter tagging, delete locks, Cost Analysis, subscriptions, and management-group governance.

---

[← Back to Azure Home Lab Portfolio](../README.md)
