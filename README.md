# 🏗️⚡ myinfra — Azure Infrastructure as Code with Terraform

> 🌐 A modular, scalable Terraform project for provisioning and managing Azure cloud infrastructure across multiple environments.

[![🔧 Terraform](https://img.shields.io/badge/Terraform-v1.0+-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![☁️ Azure](https://img.shields.io/badge/Cloud-Microsoft%20Azure-0078D4?logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![📍 Region](https://img.shields.io/badge/Region-Central%20India-FF6B35)](https://azure.microsoft.com/en-in/explore/global-infrastructure/geographies/)

---

## 📋 Table of Contents

- 🔍 [Overview](#-overview)
- 📁 [Repository Structure](#-repository-structure)
- 🧩 [Modules](#-modules)
  - 🗂️ [azurerm\_resource\_group](#️-azurerm_resource_group)
  - 💾 [azurerm\_storage\_account](#-azurerm_storage_account)
- 🌍 [Environments](#-environments)
  - 🧪 [Pre-Production (preprod)](#-pre-production-preprod)
  - 🚢 [Production (prod)](#-production-prod)
- ✅ [Prerequisites](#-prerequisites)
- 🚀 [Getting Started](#-getting-started)
- 📄 [Variables Reference](#-variables-reference)
- 🔒 [.gitignore](#-gitignore)
- 📝 [Notes](#-notes)

---

## 🔍 Overview

`myinfra` is a **reusable, modular** Terraform codebase designed to manage Azure cloud resources with consistency and scalability. It cleanly separates concerns into:

- 🧩 **Reusable Modules** — generic, environment-agnostic resource definitions
- 🌍 **Environment Configs** — `preprod` & `prod` with their own variable files

| 🏷️ Property       | 🔢 Value                                              |
|-------------------|-------------------------------------------------------|
| ☁️ Cloud Provider | Microsoft Azure (`azurerm`)                           |
| 🔧 IaC Tool       | [Terraform](https://www.terraform.io/) v1.0+          |
| 📍 Region         | Central India                                         |
| 🌿 Environments   | `preprod`, `prod`                                     |
| 🧱 Resources      | Resource Groups, Storage Accounts                     |

---

## 📁 Repository Structure

```
🏠 myinfra/
├── 🌍 environments/
│   ├── 🧪 preprod/
│   │   ├── 📄 main.tf              # Module calls for preprod
│   │   └── 📝 terraform.tfvars     # Environment-specific variable values
│   └── 🚢 prod/
│       ├── 📄 main.tf              # Module calls for prod
│       └── 📝 terraform.tfvars     # Environment-specific variable values
├── 🧩 modules/
│   ├── 🗂️ azurerm_resource_group/
│   │   ├── 📄 main.tf              # Resource group resource definition
│   │   └── 📝 variable.tf          # Input variables for the module
│   └── 💾 azurerm_storage_account/
│       ├── 📄 main.tf              # Storage account resource definition
│       └── 📝 variable.tf          # Input variables for the module
├── 🚫 .gitignore
└── 📖 README.md
```

---

## 🧩 Modules

### 🗂️ `azurerm_resource_group`

📂 Located at: `modules/azurerm_resource_group/`

Creates **one or more** Azure Resource Groups using a `for_each` loop — allowing multiple resource groups to be provisioned from a single map variable.

✨ **Resources Created:**
- 🗂️ `azurerm_resource_group`

📥 **Input Variables:**

| 🏷️ Variable        | 📖 Description                                       | 🔢 Type        |
|--------------------|------------------------------------------------------|----------------|
| `resource_groups`  | Map of resource group objects (`name`, `location`)   | `map(object)`  |

💡 **Example Usage:**
```hcl
module "resource_group" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.rgs
}
```

---

### 💾 `azurerm_storage_account`

📂 Located at: `modules/azurerm_storage_account/`

Creates **one or more** Azure Storage Accounts using a `for_each` loop — perfect for scaling storage across environments.

✨ **Resources Created:**
- 💾 `azurerm_storage_account`

📥 **Input Variables:**

| 🏷️ Variable         | 📖 Description                                                                                                          | 🔢 Type        |
|---------------------|-------------------------------------------------------------------------------------------------------------------------|----------------|
| `storage_accounts`  | Map of objects with `name`, `resource_group_name`, `location`, `account_tier`, `account_replication_type`              | `map(object)`  |

💡 **Example Usage:**
```hcl
module "storage_account" {
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}
```

---

## 🌍 Environments

### 🧪 Pre-Production (`preprod`)

📂 Located at: `environments/preprod/`

| 🏷️ Resource        | 📛 Name            | 📍 Location    |
|--------------------|--------------------|----------------|
| 🗂️ Resource Group  | `rg-preprod`       | Central India  |
| 💾 Storage Account | `stpreprod97187`   | Central India  |

⚙️ **Storage Account Configuration:**
- 💰 **Tier:** Standard
- 🔁 **Replication:** LRS _(Locally Redundant Storage)_

---

### 🚢 Production (`prod`)

📂 Located at: `environments/prod/`

| 🏷️ Resource        | 📛 Name     | 📍 Location    |
|--------------------|-------------|----------------|
| 🗂️ Resource Group  | `rg-prod`   | Central India  |
| 💾 Storage Account | `stprod`    | Central India  |

⚙️ **Storage Account Configuration:**
- 💰 **Tier:** Standard
- 🔁 **Replication:** LRS _(Locally Redundant Storage)_

---

## ✅ Prerequisites

🛠️ Before getting started, ensure you have the following installed and configured:

| #  | 🔧 Tool              | 📖 Details                                                                                           |
|----|----------------------|------------------------------------------------------------------------------------------------------|
| 1️⃣ | **Terraform** v1.0+  | [⬇️ Download here](https://developer.hashicorp.com/terraform/downloads)                              |
| 2️⃣ | **Azure CLI**        | [📖 Install Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)                    |
| 3️⃣ | **Azure Subscription** | An active Azure account with sufficient permissions                                               |
| 4️⃣ | **Authentication**   | Run `az login` to authenticate your session                                                          |

```bash
# 🔐 Authenticate with Azure
az login
```

---

## 🚀 Getting Started

Navigate to the desired environment and follow the **4-step Terraform workflow**:

### 🔄 Step 1 — Initialize Terraform

```bash
# 🧪 For Pre-Production
cd environments/preprod

# 🚢 For Production
cd environments/prod

# ⚡ Initialize providers & modules
terraform init
```

### 🔭 Step 2 — Review the Plan

```bash
# 👀 Preview what Terraform will create/change/destroy
terraform plan -var-file="terraform.tfvars"
```

### ✅ Step 3 — Apply the Configuration

```bash
# 🚀 Deploy your infrastructure
terraform apply -var-file="terraform.tfvars"
```

### 💥 Step 4 — Destroy Resources _(when needed)_

```bash
# ⚠️ Tears down all managed resources
terraform destroy -var-file="terraform.tfvars"
```

---

## 📄 Variables Reference

📝 Each environment's `terraform.tfvars` accepts the following top-level variables:

### 🗂️ `rgs` — Resource Groups Map

```hcl
rgs = {
  rg1 = {
    name     = "<resource-group-name>"   # 📛 Unique name for the RG
    location = "<azure-region>"          # 📍 e.g., "central india"
  }
}
```

### 💾 `storage_accounts` — Storage Accounts Map

```hcl
storage_accounts = {
  sa1 = {
    name                     = "<storage-account-name>"   # 📛 Globally unique name
    resource_group_name      = "<resource-group-name>"    # 🗂️ Parent resource group
    location                 = "<azure-region>"           # 📍 e.g., "central india"
    account_tier             = "Standard"                 # 💰 Standard or Premium
    account_replication_type = "LRS"                      # 🔁 LRS / GRS / ZRS / RAGRS
  }
}
```

---

## 🔒 .gitignore

🚫 This project uses a standard Terraform `.gitignore` to keep sensitive and generated files out of version control:

| 🚫 Pattern                    | 📖 Reason                                        |
|-------------------------------|--------------------------------------------------|
| `.terraform/`                 | 📦 Local provider plugins & module cache          |
| `*.tfstate`, `*.tfstate.*`    | 🗄️ State files — **never commit these!**          |
| `crash.log`, `crash.*.log`    | 💥 Terraform crash logs                           |
| `override.tf`, `*_override.tf`| 🔧 Local resource overrides                       |
| `.terraform.tfstate.lock.info`| 🔐 Transient apply lock files                     |
| `.terraformrc`, `terraform.rc`| ⚙️ CLI configuration files                        |

---

## 📝 Notes

> 💡 **Modular Design** — Each environment is self-contained and references shared modules via relative paths, keeping configurations DRY.

> ♻️ **Scalable with `for_each`** — Add more resource groups or storage accounts simply by appending new entries to the maps in `terraform.tfvars`.

> ⚠️ **Remote Backend Recommended** — State management via a remote backend (e.g., Azure Blob Storage) is not yet configured. For production workloads, set up a [remote backend](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm) to enable state locking and team collaboration.

---

<div align="center">

🏗️ **Built with Terraform** &nbsp;|&nbsp; ☁️ **Powered by Microsoft Azure** &nbsp;|&nbsp; 📍 **Central India**

*✨ myinfra — Infrastructure that scales with you ✨*

</div>
