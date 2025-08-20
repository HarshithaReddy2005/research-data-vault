# Research Data Vault on Azure

A secure, automated landing zone for Contoso University's genomics research data using Terraform and Azure services.

## Overview

This project implements a mini secure landing zone for research data that complies with university policies:
- Network segregation from public campus network
- Customer-managed encryption for all data at rest
- Least privilege access controls
- Complete audit logging to centralized workspace

## Architecture

The solution deploys:
- **Virtual Network**: `vnet-research` (10.10.0.0/20) with 3 subnets
- **Security**: Network Security Groups with explicit outbound internet denial
- **Data Services**: Storage account with CMK encryption, Key Vault with RSA-4096 keys
- **Private Connectivity**: Private endpoints for storage and key vault
- **Management**: Log Analytics workspace for centralized logging
- **Compute**: Windows jumphost for secure administration

## Quick Start

### Prerequisites
- Azure subscription with contributor access
- Terraform >= 1.0 installed
- Azure CLI installed and authenticated

### Deployment Steps

1. **Clone the repository**
