# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**Give your Agent a Git brain — auto-sync Skills and Memory across devices using Git.**

[中文文档](README.zh-CN.md)

## What is GitBrain?

GitBrain lets multiple devices share the same Agent knowledge base using Git — no separate cloud server needed.

**Key difference from cloud deployment:**
- **Cloud**: Brain and hands are coupled, limited to cloud-accessible resources
- **GitBrain**: Brain and memory shared, hands stay local, each device can access its own software

## Quick Start

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

## How It Works

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  Device A    │   │  Device B    │   │  Device C    │
│  Local Agent │   │  Local Agent │   │  Local Agent │
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │ pull/push       │ pull/push       │ pull/push
       └────────┬────────┴────────┬────────┘
         ┌──────▼──────────────────▼──────┐
         │     Git Repo (GitHub/Gitee)    │
         │  Skills/  Memories/  Config/   │
         └────────────────────────────────┘
```

## Core Features

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

## GitBrain vs MIS

| | MIS | GitBrain |
|---|---|---|
| Problem | Single-instance memory expansion | Multi-device sync |
| Solution | Memory index + Skill storage | Git-based sync |
| Scope | One device | Multiple devices |

**Use together:**
1. MIS optimizes memory on each device (100x expansion)
2. GitBrain syncs optimized memory across devices

## License

MIT

## Related Projects

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
- [Hermes MIS](https://github.com/FSWei/hermes-mis) — Single-instance memory optimization
