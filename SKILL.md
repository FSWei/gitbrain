---
name: gitbrain
description: "Give your Agent a Git brain — auto-sync Skills and Memory across devices using Git. One-command setup, automatic pull/push on change, conflict resolution, device-aware memory."
---

# GitBrain

**Give your Agent a Git brain.**

Auto-sync Skills and Memory across devices using Git — no separate cloud server needed. Every device's local Agent shares the same Git memory bank.

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
│  (hands+brain)│  │  (hands+brain)│  │  (hands+brain)│
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │ pull/push       │ pull/push       │ pull/push
       └────────┬────────┴────────┬────────┘
         ┌──────▼──────────────────▼──────┐
         │     Git Repo (GitHub/Gitee)    │
         │  Skills/  Memories/  Config/   │
         └────────────────────────────────┘
```

## Core Features

### 1. Auto Sync

- **On startup**: `git pull` to get latest changes
- **On change**: `git commit && push` to save changes
- **Conflict detection**: Timestamp + device ID based resolution

### 2. Device Awareness

Each device has a unique ID. Memory entries are tagged:

```
# Shared memory (synced across all devices)
§user_prefs: see skill user-prefs. device: shared.

# Device-private memory (only on this device)
§local_project: see skill local-project. device: pc-win.
```

**Sync rules:**
- `shared` memory → bidirectional sync across all devices
- Device-private memory → backup to Git but don't overwrite other devices

### 3. Conflict Resolution

When two devices modify the same memory:

1. **Timestamp priority**: Latest change wins
2. **Device ID marker**: Prevents accidental overwrites
3. **Manual merge**: For critical conflicts, prompt user

### 4. Granular Sync

Unlike full backup, GitBrain syncs at the file level:
- Each memory entry = one file
- Each skill = one directory
- Changes are atomic per entry

## Setup

### Step 1: Create Git Repository

```bash
# GitHub (recommended)
gh repo create my-gitbrain --private --clone

# Or Gitee (for China users)
# Create repo at gitee.com
```

### Step 2: Configure GitBrain

Say to Hermes:
```
Configure GitBrain with repo https://github.com/your-username/my-gitbrain
```

Or manually create `~/.hermes/gitbrain.yaml`:
```yaml
repo_url: https://github.com/your-username/my-gitbrain
device_id: pc-win  # unique per device
auto_pull: true
auto_push: true
sync_interval: 300  # seconds
```

### Step 3: Initial Sync

```bash
# Clone repo
git clone https://github.com/your-username/my-gitbrain ~/.hermes/gitbrain

# Initial backup
hermes gitbrain sync
```

## Directory Structure

```
my-gitbrain/
├── skills/
│   ├── project-a/
│   │   └── SKILL.md
│   └── project-b/
│       └── SKILL.md
├── memories/
│   ├── shared/
│   │   ├── user_prefs.md
│   │   └── identity.md
│   ├── pc-win/
│   │   └── local_projects.md
│   └── server-linux/
│       └── deployments.md
├── config/
│   └── devices.yaml
└── .gitignore
```

## Commands

```bash
# Manual sync
hermes gitbrain sync

# Pull only
hermes gitbrain pull

# Push only
hermes gitbrain push

# Show status
hermes gitbrain status

# List devices
hermes gitbrain devices

# Resolve conflicts
hermes gitbrain resolve
```

## Integration with MIS

GitBrain and MIS are complementary:

| | MIS | GitBrain |
|---|---|---|
| Problem | Single-instance memory expansion | Multi-device sync |
| Solution | Memory index + Skill storage + SOUL rules | Git-based sync + conflict resolution |
| Scope | One device | Multiple devices |

**Combined usage:**
1. MIS optimizes memory on each device (100x expansion)
2. GitBrain syncs optimized memory across devices

## Pitfalls

### Pitfall #1: Never git init at ~/.hermes/

The GitBrain repo must be a SEPARATE clone, not inside `~/.hermes/`. Using `git init` at `~/.hermes/` will push secrets (`.env`) and session database (`state.db`).

### Pitfall #2: Large files

Git is not for large files. Don't sync:
- Session logs
- Audio/image cache
- Database files

### Pitfall #3: Credential security

Store Git credentials securely:
```bash
git config --global credential.helper store
chmod 600 ~/.git-credentials
```

### Pitfall #4: Conflict frequency

High-frequency changes cause conflicts. Solution:
- Batch changes locally
- Push at intervals (not on every change)
- Use device-private tags for volatile memory

## Related Projects

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
- [Hermes MIS](https://github.com/FSWei/hermes-mis) — Single-instance memory optimization
- [hermes-git-backup](https://github.com/FSWei/hermes-git-backup) — Manual backup (GitBrain precursor)
