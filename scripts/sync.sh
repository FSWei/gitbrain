#!/bin/bash
# GitBrain Sync Script
# Usage: bash sync.sh [pull|push|sync|status]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Functions
log_info() { echo -e "${GREEN}[GitBrain]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[GitBrain]${NC} $1"; }
log_error() { echo -e "${RED}[GitBrain]${NC} $1"; }

# Load config
HERMES_DIR="$HOME/.hermes"
CONFIG_FILE="$HERMES_DIR/gitbrain.yaml"
GITBRAIN_DIR="$HERMES_DIR/gitbrain"

if [ ! -f "$CONFIG_FILE" ]; then
    log_error "Config not found at $CONFIG_FILE"
    log_error "Run: bash setup.sh <repo_url> <device_id>"
    exit 1
fi

# Parse config (simple YAML parser)
parse_config() {
    local key="$1"
    grep "^$key:" "$CONFIG_FILE" | sed 's/^[^:]*: //' | tr -d '"' | tr -d "'"
}

REPO_URL=$(parse_config "repo_url")
DEVICE_ID=$(parse_config "device_id")
AUTO_PULL=$(parse_config "auto_pull")
AUTO_PUSH=$(parse_config "auto_push")

# Ensure gitbrain directory exists
if [ ! -d "$GITBRAIN_DIR" ]; then
    log_error "GitBrain directory not found at $GITBRAIN_DIR"
    log_error "Run setup.sh first"
    exit 1
fi

cd "$GITBRAIN_DIR"

# Function: Pull from remote
do_pull() {
    log_info "Pulling latest changes..."
    
    # Stash local changes
    git stash 2>/dev/null || true
    
    # Pull
    if git pull --rebase origin master 2>/dev/null; then
        log_info "Pull successful"
    elif git pull --rebase origin main 2>/dev/null; then
        log_info "Pull successful"
    else
        log_warn "Pull failed, trying without rebase..."
        git pull origin master 2>/dev/null || git pull origin main 2>/dev/null || true
    fi
    
    # Pop stash
    git stash pop 2>/dev/null || true
}

# Function: Push to remote
do_push() {
    log_info "Pushing changes..."
    
    # Check for changes
    if git diff --quiet && git diff --cached --quiet; then
        log_info "No changes to push"
        return 0
    fi
    
    # Add all changes
    git add -A
    
    # Commit with device ID and timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    CHANGED_FILES=$(git diff --cached --name-only | wc -l)
    git commit -m "GitBrain sync [$DEVICE_ID] — $TIMESTAMP ($CHANGED_FILES files)"
    
    # Push
    if git push origin master 2>/dev/null; then
        log_info "Push successful"
    elif git push origin main 2>/dev/null; then
        log_info "Push successful"
    else
        log_error "Push failed"
        exit 1
    fi
}

# Function: Full sync (pull then push)
do_sync() {
    log_info "Starting full sync..."
    do_pull
    do_push
    log_info "Sync complete"
}

# Function: Show status
do_status() {
    echo -e "${BLUE}GitBrain Status${NC}"
    echo "================================"
    echo "Device ID: $DEVICE_ID"
    echo "Repository: $REPO_URL"
    echo "Local path: $GITBRAIN_DIR"
    echo
    
    cd "$GITBRAIN_DIR"
    
    echo -e "${BLUE}Git Status:${NC}"
    git status -s
    echo
    
    echo -e "${BLUE}Recent Commits:${NC}"
    git log --oneline -5
    echo
    
    echo -e "${BLUE}Directory Structure:${NC}"
    find . -maxdepth 2 -type d | grep -v ".git" | sort
}

# Function: Auto sync (for background running)
do_auto() {
    INTERVAL=$(parse_config "sync_interval")
    INTERVAL=${INTERVAL:-300}
    
    log_info "Starting auto sync (interval: ${INTERVAL}s)"
    
    while true; do
        do_sync
        sleep "$INTERVAL"
    done
}

# Function: Register sync hooks in SOUL.md
do_register() {
    SOUL_FILE="$HERMES_DIR/SOUL.md"
    
    if [ ! -f "$SOUL_FILE" ]; then
        log_error "SOUL.md not found at $SOUL_FILE"
        exit 1
    fi
    
    # Check if already registered
    if grep -q "GitBrain Sync" "$SOUL_FILE"; then
        log_warn "GitBrain sync already registered in SOUL.md"
        return 0
    fi
    
    # Add sync rules to SOUL.md
    cat >> "$SOUL_FILE" << 'EOF'

## GitBrain Sync
On session start: run `bash ~/.hermes/gitbrain/scripts/sync.sh pull`
After Memory/Skill change: run `bash ~/.hermes/gitbrain/scripts/sync.sh push`
EOF
    
    log_info "Registered sync hooks in SOUL.md"
}

# Main
case "${1:-sync}" in
    pull)
        do_pull
        ;;
    push)
        do_push
        ;;
    sync)
        do_sync
        ;;
    status)
        do_status
        ;;
    auto)
        do_auto
        ;;
    register)
        do_register
        ;;
    *)
        echo "Usage: bash sync.sh [pull|push|sync|status|auto|register]"
        echo
        echo "Commands:"
        echo "  pull      - Pull latest changes from remote"
        echo "  push      - Push local changes to remote"
        echo "  sync      - Full sync (pull then push)"
        echo "  status    - Show GitBrain status"
        echo "  auto      - Start auto sync in background"
        echo "  register  - Register sync hooks in SOUL.md"
        exit 1
        ;;
esac
