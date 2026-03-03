🚀 DO Secure AI Lab
Overview

This project is a production-style Cloud Security & AI lab environment built on 
DigitalOcean using:

Terraform (Infrastructure as Code)

Secure Bastion Architecture

Private VPC Networking

Cloud Firewalls (Least Privilege)

SSH Agent Forwarding

Ubuntu 22.04

Portfolio-ready Security Engineering practices

The lab is designed to simulate a realistic cloud security environment suitable for:

SOC workflows

Detection engineering

Secure infrastructure design

AI-assisted security tooling

Automation-first DevSecOps practices

🏗 Architecture

MacBook (Terraform Control Plane)
        │
        │ SSH (Agent Forwarding)
        ▼
Bastion Host (Public Entry Point)
        │
        │ Private VPC Network (10.20.0.0/16)
        ▼
 ├── web-1 (10.20.0.10)
 ├── web-2 (10.20.0.11)
 └── ai-node (10.20.0.13)

Key Design Principles

🔒 Bastion is the ONLY public entry point

🔒 Web and AI nodes are private-only

🔒 DigitalOcean Cloud Firewalls enforce least privilege

🔒 No private keys stored on servers

🔒 SSH agent forwarding used for secure access

🔒 Infrastructure managed entirely via Terraform

☁ Infrastructure Components
1️⃣ VPC

CIDR: 10.20.0.0/16

Region: nyc3

Isolated private networking

2️⃣ Bastion Host

Ubuntu 22.04

Public IP

SSH hardened

UFW enabled

Fail2Ban configured

Root login disabled

Password authentication disabled

SSH agent forwarding enabled

3️⃣ Private Nodes

web-1

web-2

ai-node

Private-only IPs

Accessible only via bastion

4️⃣ Firewalls
Bastion Firewall

Allows SSH from trusted public IP only

Private Firewall

Allows SSH only from bastion (via tag-based rule)

Allows internal VPC traffic

Outbound allowed

🛠 Terraform Structure

Key Design Principles

🔒 Bastion is the ONLY public entry point

🔒 Web and AI nodes are private-only

🔒 DigitalOcean Cloud Firewalls enforce least privilege

🔒 No private keys stored on servers

🔒 SSH agent forwarding used for secure access

🔒 Infrastructure managed entirely via Terraform

☁ Infrastructure Components
1️⃣ VPC

CIDR: 10.20.0.0/16

Region: nyc3

Isolated private networking

2️⃣ Bastion Host

Ubuntu 22.04

Public IP

SSH hardened

UFW enabled

Fail2Ban configured

Root login disabled

Password authentication disabled

SSH agent forwarding enabled

3️⃣ Private Nodes

web-1

web-2

ai-node

Private-only IPs

Accessible only via bastion

4️⃣ Firewalls
Bastion Firewall

Allows SSH from trusted public IP only

Private Firewall

Allows SSH only from bastion (via tag-based rule)

Allows internal VPC traffic

Outbound allowed

🛠 Terraform Structure

terraform/
├── providers.tf
├── variables.tf
├── main.tf
├── firewall.tf
├── outputs.tf
├── terraform.tfvars.example

Sensitive values are excluded from version control.

🔐 Security Controls Implemented

SSH key-only authentication

Root SSH disabled

Password authentication disabled

UFW host firewall enabled

Fail2Ban brute-force protection

Cloud firewall segmentation

VPC network isolation

Bastion-only ingress model

SSH agent forwarding (no key storage on bastion)

🧠 Control Plane Design

Terraform runs from a dedicated control workstation (MacBook), not from infrastructure 
nodes.

This ensures:

Clean separation of control plane and infrastructure

Replaceable bastion

IaC state integrity

Professional engineering workflow

📈 Current Status

✅ VPC created
✅ 4-node architecture deployed
✅ Cloud firewalls configured
✅ Bastion hardened
✅ SSH agent forwarding configured
✅ Secure private-node access working
✅ GitHub repository initialized

🔜 Next Phases

Ansible bootstrap for private nodes

Standardized hardening across all hosts

AI SOC Assistant deployment

FastAPI-based alert analysis API

Structured JSON security responses

Detection engineering integrations

Optional Terraform remote state backend

🎯 Purpose

This lab demonstrates real-world cloud security engineering practices, including:

Secure architecture design

Infrastructure as Code discipline

Network segmentation

Identity and access management

Automation-first security operations

Foundation for AI-assisted SOC tooling

Phase 2 – Bastion Control Plane & Node Hardening
Architecture

Bastion: Public entry point

Web-1, Web-2: Private nodes

AI Node: Private SOC automation host

VPC CIDR: 10.20.0.0/16

Security Controls Implemented

Dedicated Bastion automation SSH key

Ansible managed infrastructure

Non-root automation user (sysadmin)

UFW host-level firewall

Fail2ban intrusion protection

Unattended security updates

SSH password authentication disabled

Root SSH login disabled (break-glass via DO console)

Operational Model

Windows → Bastion → Private Nodes

Phase 3 — SOC Assistant (FastAPI)

Host: ai-node (10.20.0.13)

Service: soc-assistant.service (systemd)

API: http://10.20.0.13:8000 (VPC-only; restricted by UFW)

Endpoints:

GET /health

POST /triage (structured JSON)

Operations

Status: sudo systemctl status soc-assistant --no-pager

Logs: sudo journalctl -u soc-assistant -n 50 --no-pager

Restart: sudo systemctl restart soc-assistant

🧑‍💻 Author

Sydney McGee
Cloud Security | SOC | Detection Engineering | DevSecOps
