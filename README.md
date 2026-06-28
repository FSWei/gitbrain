# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**Give your Agent a Git brain — auto-sync Skills and Memory across devices using Git.**

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

## ⚡ Quick Start

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
| **claude-brain** | 66 | ✅ Git | Files | Claude Code | npm install |
| **memex** | 134 | ✅ Git | Markdown | Multi-agent | npm install |
| **Memory-Like-A-Tree** | 124 | ✅ Obsidian | Markdown | Multi-agent | pip install |
| **sqlite-memory** | 74 | ✅ SQLite | Markdown | Multi-agent | npm install |
| **Helixir** | 83 | ❌ | Weights | Multi-agent | pip install |
| **ArcRift** | 243 | ❌ | SQLite | Multi-agent | Extension + MCP |
| **knowledge-base-server** | 174 | ❌ | SQLite | Multi-agent | MCP server |

### Key Differentiators

| Feature | GitBrain | claude-brain | memex |
|---------|----------|--------------|-------|
| **Git-native** | ✅ | ✅ | ✅ |
| **Zero dependencies** | ✅ | ❌ (Node.js) | ❌ (Node.js) |
| **One-command setup** | ✅ | ❌ | ❌ |
| **Device-aware** | ✅ | ❌ | ❌ |
| **Hermes integration** | ✅ Deep | ❌ | ❌ |
| **Chinese market** | ✅ | ❌ | ❌ |

### Why GitBrain?

1. **Zero dependencies** — No Node.js, Python, or extra servers needed
2. **One-command setup** — Just say "Enable GitBrain sync"
3. **Device-aware** — Distinguish shared vs device-private memory
4. **Hermes native** — Deep integration with Hermes Skill/Memory/SOUL
5. **Git-native** — Leverage Git's existing infrastructure (GitHub, Gitee)

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

# Start auto sync in background
bash ~/.hermes/gitbrain/scripts/sync.sh auto

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

The GitBrain repo must be at `~/.hermes/gitbrain/`, NOT at `~/.hermes/`. Using `git init` at `~/.hermes/` will push secrets (`.env`) and session database (`state.db`).

### Pitfall #2: Large files

Don't sync:
- Session logs (`*.log`)
- Audio/image cache
- Database files (`*.db`)

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

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
- [hermes-git-backup](https://github.com/FSWei/hermes-git-backup) — Manual backup (GitBrain precursor)
