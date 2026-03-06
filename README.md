# AI SOC Assistant Lab

A private cloud security lab focused on building an **AI-powered cybersecurity assistant** for real SOC analyst workflows.

This project combines **cloud infrastructure, security hardening, automation, and AI services** to create a platform that assists with:

- Alert triage
- MITRE ATT&CK mapping
- IOC extraction
- Investigation guidance
- Case note generation
- Detection engineering support

The goal is to develop a **practical AI security copilot** that can assist with day-to-day cybersecurity analyst tasks.

---

# Architecture

The lab runs in **DigitalOcean** with a segmented VPC architecture.

Windows Desktop
│
▼
Bastion (Control Plane / SOC CLI)
│
│ Internal VPC
▼
AI Node (SOC Assistant API)
│
├── Web-1 (telemetry / workload node)
└── Web-2 (telemetry / attack simulation node)

VPC CIDR: 10.20.0.0/16

Hosts:

| Host | Role |
|-----|-----|
| Bastion | Public entry point, Ansible control node, SOC CLI host |
| Web-1 | Private workload node |
| Web-2 | Private workload / attack simulation node |
| AI Node | Internal SOC Assistant API |

---

# Security Controls Implemented

The environment is hardened using several security best practices:

- Bastion-only SSH access
- Dedicated Bastion automation SSH key
- Ansible managed infrastructure
- Non-root automation user (`sysadmin`)
- UFW host-level firewall
- Fail2ban intrusion protection
- Unattended security updates
- SSH password authentication disabled
- Root SSH login disabled (break-glass via DO console)

---

# Operational Model

Access path: Windows → Bastion → Private Nodes

The Bastion host serves as the:

- management plane
- Ansible automation controller
- SOC CLI operator console

---

# Phase 3 — SOC Assistant (FastAPI)

The **AI Node** hosts an internal SOC assistant API built with FastAPI.

Host: ai-node (10.20.0.13)

Service: soc-assistant.service

Runs as a **systemd service**.

The API is **only reachable inside the VPC**.

http://10.20.0.13:8000

---

# API Endpoints

### Health Check

GET /heatlh
Example:  curl http://10.20.0.13:8000/health

---

### Alert Triage

POST /triage

The endpoint returns structured JSON including:

- severity
- confidence
- summary
- MITRE ATT&CK mapping
- IOC candidates
- recommended queries
- recommended response actions

Example request:

```json
{
  "source": "wazuh",
  "title": "Mimikatz credential dumping detected",
  "raw_event": {
    "user": "admin",
    "process": "mimikatz.exe",
    "src_ip": "192.168.1.22"
  }
}

SOC CLI (Analyst Interface)

The Bastion host runs a local CLI tool called soc which interacts with the SOC Assistant API.

Example commands:
soc health
soc triage alert.json
soc note alert.json
soc triage-stdin

Example workflow:
cat alert.json | soc triage-stdin

Output includes:

severity

MITRE ATT&CK mapping

IOC extraction

investigation queries

recommended actions

This simulates an internal SOC automation tool used by security teams.

Check service status
sudo systemctl status soc-assistant --no-pager

View Logs
sudo journalctl -u soc-assistant -n 50 --no-pager

Restart Service
sudo systemctl restart soc-assistant

Project Goals

This lab focuses on building an AI-powered cybersecurity assistant that helps analysts:

triage alerts faster

understand suspicious activity

map detections to MITRE ATT&CK

generate investigation queries

create case notes

support detection engineering workflows

Future enhancements will include LLM-based reasoning and RAG knowledge retrieval.

Future Roadmap

Planned improvements:

SOC CLI enhancements

soc explain

soc hunt

soc mitre

Detection engineering assistant

LLM-based alert analysis

RAG integration with MITRE ATT&CK

Automatic alert ingestion

Wazuh integration

Real telemetry from workload nodes

🧑‍💻 Author

Sydney McGee
Cloud Security | SOC | Detection Engineering | DevSecOps
