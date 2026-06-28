# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**The simplest way to sync your Agent's memory across devices — zero dependencies, just Git.**

[中文文档](README.zh-CN.md)

---

## 🎯 What is GitBrain?

GitBrain is a **lightweight alternative to GBrain** for users who want multi-device memory sync without the complexity of databases, API keys, or 30-minute setup.

**GBrain** (by Garry Tan, 24k⭐) is a production-grade knowledge graph with 146K+ pages, synthesis layers, and 24/7 dream cycles. It's powerful but complex.

**GitBrain** is the simple version: **5 minutes, zero dependencies, just Git.**

| | GBrain | GitBrain |
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
- Are in the Chinese market (中文文档优先)

**Choose GBrain if you:**
- Need knowledge graph and synthesis
- Have 100K+ pages to manage
- Want production-grade features
- Need multi-agent support (Claude Code, Codex, etc.)

---

## ⚡ Quick Start (1 minute)

### Option 1: One-Command Install

Say to Hermes:
```
Enable GitBrain sync
```

### Option 2: Manual

```bash
# 1. Create a private Git repo (GitHub/Gitee)
gh repo create my-gitbrain --private

# 2. Tell Hermes
"Enable GitBrain sync with repo https://github.com/you/my-gitbrain.git"
```

Done. Your Agent's memory now syncs across all devices.

---

## 🔧 How It Works

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC          │   │  MacBook    │   │  Server     │
│  Agent       │   │  Agent      │   │  Agent      │
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                          ▼
                   ┌─────────────┐
                   │  Git Repo   │
                   │  (GitHub)   │
                   └─────────────┘
```

- **On startup**: `git pull` (get latest)
- **On change**: `git commit && push` (save)

That's it. No servers, no databases, no API keys.

---

## 📊 When to Use What

| Scenario | Recommendation |
|----------|----------------|
| Sync memory across 2-3 personal devices | ✅ GitBrain |
| Manage 100K+ pages of knowledge | ❌ Use GBrain |
| Team knowledge base with access control | ❌ Use GBrain |
| Quick setup, no technical complexity | ✅ GitBrain |
| Enterprise-grade synthesis and gap analysis | ❌ Use GBrain |
| Chinese market, 中文优先 | ✅ GitBrain |

---

## 📄 License

MIT

## 🔗 Related Projects

- [GBrain](https://github.com/garrytan/gbrain) — Production-grade knowledge graph (24k⭐)
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
