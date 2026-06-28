# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**The simplest way to sync your Agent's memory across devices — zero dependencies, just Git.**

[中文文档](README.zh-CN.md)

---

## 🎯 What is GitBrain?

GitBrain lets multiple devices share the same Agent knowledge base using Git — no separate cloud server needed.

### Before GitBrain

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC (Win)    │   │  MacBook    │   │  Server     │
│  Agent A     │   │  Agent B    │   │  Agent C    │
│  Memory: ❌  │   │  Memory: ❌  │   │  Memory: ❌  │
│  Skills: ❌  │   │  Skills: ❌  │   │  Skills: ❌  │
└──────────────┘   └──────────────┘   └──────────────┘
       │                  │                  │
       ▼                  ▼                  ▼
   Different          Different          Different
   knowledge          knowledge          knowledge
```

**Problem:** Each device has its own isolated Agent. You repeat yourself, forget context, lose consistency.

### After GitBrain

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC (Win)    │   │  MacBook    │   │  Server     │
│  Agent A     │   │  Agent B    │   │  Agent C    │
│  Memory: ✅  │   │  Memory: ✅  │   │  Memory: ✅  │
│  Skills: ✅  │   │  Skills: ✅  │   │  Skills: ✅  │
└──────┬───────┘   └──────┬───────┘   └──────┬───────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                          ▼
                   ┌─────────────┐
                   │  Git Repo   │
                   │  (GitHub)   │
                   │  Shared     │
                   │  Memory +   │
                   │  Skills     │
                   └─────────────┘
```

**Result:** All devices share the same knowledge. Your Agent remembers everything, everywhere.

---

## 📖 Real-World Example

### Scenario: You're building a project across multiple devices

**Monday morning, PC:**
```
You: "What's the status of my-webapp?"
Agent: [Reads from shared memory]
       "my-webapp — React+Node.js e-commerce platform.
        Server: 10.0.1.100. Status: In development.
        Last update: Added JWT authentication."
```

**Monday evening, MacBook:**
```
You: "What's the status of my-webapp?"
Agent: [Same answer! Memory synced from PC]
       "my-webapp — React+Node.js e-commerce platform.
        Server: 10.0.1.100. Status: In development.
        Last update: Added JWT authentication."
```

**Tuesday, Server (via SSH):**
```
You: "Deploy the latest version"
Agent: [Already knows the project details]
       "Deploying my-webapp to 10.0.1.100...
        Using JWT authentication from yesterday's implementation."
```

**No repeated explanations. No lost context. Just seamless continuity.**

---

## 🆚 GitBrain vs GBrain

GitBrain is a **lightweight alternative to GBrain** for users who want simplicity.

| | GBrain (Garry Tan, 24k⭐) | GitBrain |
|---|---|---|
| **Setup time** | ~30 minutes | ~1 minute |
| **Dependencies** | PGLite/Postgres + API keys | Zero |
| **Core feature** | Knowledge graph + synthesis | Git sync |
| **Best for** | Enterprise knowledge management | Personal multi-device sync |
| **Learning curve** | Steep | Gentle |

**Choose GitBrain if you:**
- Want to sync Agent memory across devices quickly
- Don't want to set up databases or API keys
- Prefer simplicity over features

**Choose GBrain if you:**
- Need knowledge graph and synthesis
- Have 100K+ pages to manage
- Want production-grade features

---

## ⚡ Quick Start (1 minute)

### Option 1: One-Command Install (Recommended)

Say to Hermes:
```
Install skill from https://github.com/FSWei/gitbrain
```

Or use CLI:
```bash
hermes skills install https://github.com/FSWei/gitbrain
```

Then say: `Enable GitBrain sync`

### Option 2: Manual Install

1. Copy `SKILL.md` to `~/.hermes/skills/gitbrain.md`
2. Say to Hermes: `Enable GitBrain sync`

---

## 🔧 How It Works

### Auto Sync
- **On startup**: `git pull` to get latest changes
- **On change**: `git commit && push` to save changes

### Device Awareness
Each device has a unique ID. Memory entries are tagged:
- `shared` — synced across all devices
- `device: pc-win` — only on this device

### Conflict Resolution
- Timestamp priority: latest change wins
- Device ID markers prevent accidental overwrites
- Manual merge for critical conflicts

---

## 📊 Competitive Analysis

### Agent Memory Solutions Comparison

| Solution | Stars | Sync | Storage | Agent Support | Install |
|----------|-------|------|---------|---------------|---------|
| **GitBrain** | 🆕 | ✅ Git | Files | Hermes | `hermes skills install` |
| **GBrain** | 24k | ✅ Postgres | DB | Multi-agent | npm/bun |
| **claude-brain** | 66 | ✅ Git | Files | Claude Code | npm install |
| **memex** | 134 | ✅ Git | Markdown | Multi-agent | npm install |

### Key Differentiators

| Feature | GitBrain | GBrain | claude-brain |
|---------|----------|--------|--------------|
| **Zero dependencies** | ✅ | ❌ | ❌ |
| **One-command setup** | ✅ | ❌ | ❌ |
| **Knowledge graph** | ❌ | ✅ | ❌ |
| **Synthesis layer** | ❌ | ✅ | ❌ |
| **Device-aware** | ✅ | ❌ | ❌ |

---

## 🛠️ Commands

```bash
# Manual sync
bash ~/.hermes/gitbrain/scripts/sync.sh sync

# Pull only
bash ~/.hermes/gitbrain/scripts/sync.sh pull

# Push only
bash ~/.hermes/gitbrain/scripts/sync.sh push

# Show status
bash ~/.hermes/gitbrain/scripts/sync.sh status

# Register sync hooks in SOUL.md
bash ~/.hermes/gitbrain/scripts/sync.sh register
```

---

## 📁 Directory Structure

```
~/.hermes/gitbrain/
├── skills/
│   ├── project-a/
│   │   └── SKILL.md
│   └── project-b/
│       └── SKILL.md
├── memories/
│   ├── shared/
│   │   ├── user_prefs.md
│   │   └── SOUL.md
│   ├── pc-win/
│   │   └── local_projects.md
│   └── server-linux/
│       └── deployments.md
└── config/
```

---

## ⚠️ Pitfalls

### Pitfall #1: Never git init at ~/.hermes/

The GitBrain repo must be at `~/.hermes/gitbrain/`, NOT at `~/.hermes/`.

### Pitfall #2: Large files

Don't sync session logs, audio/image cache, or database files.

### Pitfall #3: Credential security

Store Git credentials securely:
```bash
git config --global credential.helper store
chmod 600 ~/.git-credentials
```

---

## 📄 License

MIT

## 🔗 Related Projects

- [GBrain](https://github.com/garrytan/gbrain) — Production-grade knowledge graph (24k⭐)
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
