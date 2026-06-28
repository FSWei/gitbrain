---
name: gitbrain
description: "Use when user says enable GitBrain, sync memory, 多设备同步, Git同步. Give your Agent a Git brain — auto-sync Skills and Memory across devices using Git. One-command setup, automatic pull/push on change, device-aware memory."
---

# GitBrain

**Give your Agent a Git brain.**

Auto-sync Skills and Memory across devices using Git — no separate cloud server needed.

## Quick Start

### One-Command Install

Say to Hermes:
```
Enable GitBrain sync
```

Or:
```
Install skill from https://github.com/FSWei/gitbrain
```

## Execution Flow

When user says "Enable GitBrain sync" or "Sync memory":

### Step 1: Check Prerequisites

```bash
# Check if git is installed
command -v git && echo "Git OK" || echo "Git not installed"

# Check if Hermes directory exists
ls -la ~/.hermes/
```

### Step 2: Get Configuration

Ask user:
1. **Git repository URL** (GitHub/Gitee)
2. **Device ID** (e.g., pc-win, macbook, server-linux)

### Step 3: Clone Repository

```bash
# Clone to ~/.hermes/gitbrain/
git clone <repo_url> ~/.hermes/gitbrain

# If already exists, pull latest
cd ~/.hermes/gitbrain && git pull
```

### Step 4: Create Config

Write config to `~/.hermes/gitbrain.yaml`:

```yaml
repo_url: <user_provided_url>
device_id: <user_provided_id>
auto_pull: true
auto_push: true
sync_interval: 300
```

### Step 5: Register Sync Hooks

Add to SOUL.md:

```markdown
## GitBrain Sync
On session start: pull latest from GitBrain repo
After Memory/Skill change: push to GitBrain repo
```

## Sync Commands

When user says "sync memory" or "pull/push memory":

### Pull (Get Latest)

```bash
cd ~/.hermes/gitbrain
git stash 2>/dev/null || true
git pull --rebase origin master 2>/dev/null || git pull --rebase origin main 2>/dev/null || git pull
git stash pop 2>/dev/null || true
```

### Push (Save Changes)

```bash
cd ~/.hermes/gitbrain

# Copy current skills and memories
cp -r ~/.hermes/skills/* skills/ 2>/dev/null || true
cp -r ~/.hermes/memories/* memories/shared/ 2>/dev/null || true
cp ~/.hermes/SOUL.md memories/shared/SOUL.md 2>/dev/null || true

# Commit and push
git add -A
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DEVICE_ID=$(grep 'device_id:' ~/.hermes/gitbrain.yaml | sed 's/.*: //')
git commit -m "GitBrain sync [$DEVICE_ID] — $TIMESTAMP" --allow-empty
git push origin master 2>/dev/null || git push origin main
```

### Full Sync

```bash
# Pull first, then push
cd ~/.hermes/gitbrain
git stash 2>/dev/null || true
git pull --rebase origin master 2>/dev/null || git pull --rebase origin main 2>/dev/null || git pull
git stash pop 2>/dev/null || true

# Copy and push
cp -r ~/.hermes/skills/* skills/ 2>/dev/null || true
cp -r ~/.hermes/memories/* memories/shared/ 2>/dev/null || true
cp ~/.hermes/SOUL.md memories/shared/SOUL.md 2>/dev/null || true

git add -A
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DEVICE_ID=$(grep 'device_id:' ~/.hermes/gitbrain.yaml | sed 's/.*: //')
git commit -m "GitBrain sync [$DEVICE_ID] — $TIMESTAMP" --allow-empty
git push origin master 2>/dev/null || git push origin main
```

## Device-Aware Memory

### Shared Memory (Synced Across All Devices)

Memory entries with `device: shared` tag:
```
§user_prefs: see skill user-prefs. device: shared.
§identity: see skill fsw-identity. device: shared.
```

### Device-Private Memory (Only on This Device)

Memory entries with device-specific tag:
```
§local_project: see skill local-project. device: pc-win.
§server_config: see skill server-config. device: server-linux.
```

**Sync rules:**
- `shared` → bidirectional sync
- Device-private → backup only, don't overwrite other devices

## Directory Structure

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

## Auto Sync

To enable auto sync on every session start, add to SOUL.md:

```markdown
## GitBrain Auto Sync
At session start: run terminal command `cd ~/.hermes/gitbrain && git pull`
After any Memory change: run terminal command `cd ~/.hermes/gitbrain && git add -A && git commit -m "auto sync" && git push`
```

## Pitfalls

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

## Related Projects

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent Framework
