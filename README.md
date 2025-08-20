# Research Data Vault on Azure

A secure, automated Azure landing zone for Contoso University’s genomics research, fully managed by Terraform.  
Compliant with network segregation, encryption, least privilege, and auditability mandates.

---

## Overview

**Project Goal:**  
- Design a secure “mini landing zone” for research data using only Terraform.
- No Azure Portal manual steps.
- Meet all stated university policy and security requirements.

**Key Features:**  
- Segregated VNet with three subnets (backend, jumphost, hpc)
- Strict NSGs to enforce least privilege and block outbound Internet
- Storage account and Key Vault using Customer Managed Keys (CMK, RSA-4096)
- Private endpoints for all data (no public egress)
- Centralized diagnostics via Log Analytics
- Automated deployment with GitHub Actions
- Stretch: Jumphost demo for outbound block (PowerShell + Logging proof)

---

## Architecture

| Resource           | Name/Example                          | Purpose                               |
|--------------------|---------------------------------------|---------------------------------------|
| Resource Group     | `rg-research`                         | Project boundary                      |
| VNet               | `vnet-research` (10.10.0.0/20)        | Segregated research network           |
| Subnets            | `sn-backend`, `sn-jumphost`, `sn-hpc` | Isolation for data/endpoints/jumphost |
| NSGs               | `nsg-backend`, `nsg-jumphost`, `nsg-hpc` | Network security enforcement       |
| Storage Account    | `stggenomics...`                      | Hot+cool, encrypted, private endpoint |
| Key Vault          | `kv-genomics`                         | Holds secrets, encryption keys        |
| Log Analytics      | `law-research`                        | Central audit and monitoring          |
| Jumphost VM        | `jumphost-vm`                         | Secure admin entrypoint               |

---

## Deployment Instructions

### Prerequisites

- Azure subscription
- Terraform 1.x
- Azure CLI logged in
- (Optional) GitHub repo for CI/CD

 ### Steps

1. **Clone the repository:**
2. **Set your variables:**
- Copy and edit `terraform.tfvars.example` → `terraform.tfvars` with your values, especially your public IP for the jumphost.
3. **Deploy:**
terraform init
terraform plan
terraform apply
4. **Grab outputs:**  
Review the Terraform output for:
- `jumphost_public_ip` (for RDP)
- Storage account, key vault names, etc.

---

## Secure Networking & Policy Enforcement

- **nsg-backend**:  
- Allows only Azure Monitor (443) and Azure DNS (53) outbound.
- Explicitly *denies all other Internet outbound*.
- **nsg-jumphost**:  
- Allows Admin RDP from your IP.
- *Denies all other outbound Internet*.
- **nsg-hpc**:  
- (Empty/future use, but protected)

---

## Storage & Key Vault Security

- **Storage account**:
- Only accessible via private endpoint (in `sn-backend`)
- CMK encryption from Key Vault
- HTTPS required, soft-delete enabled
- **Key Vault**:
- CMK (RSA-4096), access via private endpoint, no public access

---

## Audit Logging & Diagnostics

- **All resources send logs to** `law-research` **Log Analytics workspace**.
- Diagnostic settings applied via Terraform for:
- Storage Account
- Key Vault
- Jumphost VM

---

## Outputs Example

jumphost_public_ip = "20.2.159.62"
key_vault_name = "kv-genomics"
storage_account_name = "stggenomics..."
log_analytics_name = "law-research"
resource_group_name = "rg-research"
vnet_name = "vnet-research"

---

## Stretch Demo: Jumphost Outbound Block & Logging

### Outbound Internet Block

- **Tested from jumphost-vm:**
Test-NetConnection -ComputerName www.google.com -Port 80
- Result:  
  ![PowerShell Failure](./screenshots/jumphost_blocked.png)

> **Connection fails, proving outbound block is enforced by NSG.**

### Log Analytics - Jumphost Activity

- **Diagnostics sent to Log Analytics workspace:**
- Example (no results found yet? This is normal due to log delay, config, or inactivity; screenshot included for process):

  ![Log Analytics](./screenshots/loganalytics_jumphost.png)

- **Explain this in documentation** if logs are delayed (“Diagnostic settings configured; logs may take 15+ minutes to appear or may require activity such as logins or reboots”).

---

## Tags & Naming

All resources assigned:
- `Project = Genomics`
- `Owner = <YourName>`
- `Env = PoC`

---

## CI/CD Automation

- GitHub Actions pipeline runs `terraform fmt`, `tflint`, `plan`, and `apply` on PRs and main branch.
- Uses Azure OIDC login (No long-lived secrets).

---

## Troubleshooting

- If public IP creation fails, use SKU = Standard and allocation = Static.
- If logs don’t show, verify that diagnostic settings are linked and you wait 15+ minutes.
- NSGs must be confirmed attached to correct subnets.

---

## License

MIT License

---

## Contact

For questions, please contact the project owner:  
<harshithamoola99@gmail.com>

---


