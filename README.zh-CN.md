# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**给 Agent 装个 Git 大脑 — 用 Git 自动同步多设备的 Skill 和 Memory。**

[English](README.md)

---

## 🎯 什么是 GitBrain？

GitBrain 让多台设备通过 Git 共享同一套 Agent 知识库——不需要单独的云服务器。

### 使用 GitBrain 之前

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC (Win)    │   │  MacBook    │   │  服务器      │
│  Agent A     │   │  Agent B    │   │  Agent C    │
│  记忆: ❌    │   │  记忆: ❌    │   │  记忆: ❌    │
│  技能: ❌    │   │  技能: ❌    │   │  技能: ❌    │
└──────────────┘   └──────────────┘   └──────────────┘
       │                  │                  │
       ▼                  ▼                  ▼
    不同的            不同的            不同的
    知识              知识              知识
```

**问题：** 每台设备的 Agent 都是孤立的。你需要重复解释，丢失上下文，失去一致性。

### 使用 GitBrain 之后

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC (Win)    │   │  MacBook    │   │  服务器      │
│  Agent A     │   │  Agent B    │   │  Agent C    │
│  记忆: ✅    │   │  记忆: ✅    │   │  记忆: ✅    │
│  技能: ✅    │   │  技能: ✅    │   │  技能: ✅    │
└──────┬───────┘   └──────┬───────┘   └──────┬───────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                          ▼
                   ┌─────────────┐
                   │  Git 仓库   │
                   │  (GitHub)   │
                   │  共享       │
                   │  记忆 +     │
                   │  技能       │
                   └─────────────┘
```

**结果：** 所有设备共享同一套知识。你的 Agent 无处不在都记得一切。

---

## 📖 真实场景示例

### 场景：你在多台设备上开发同一个项目

**周一早上，PC：**
```
你："my-webapp 项目进展如何？"
Agent：[从共享记忆中读取]
       "my-webapp — React+Node.js 电商平台。
        服务器：10.0.1.100。状态：开发中。
        最近更新：添加了 JWT 认证。"
```

**周一晚上，MacBook：**
```
你："my-webapp 项目进展如何？"
Agent：[同样的答案！记忆已从 PC 同步]
       "my-webapp — React+Node.js 电商平台。
        服务器：10.0.1.100。状态：开发中。
        最近更新：添加了 JWT 认证。"
```

**周二，服务器（通过 SSH）：**
```
你："部署最新版本"
Agent：[已经知道项目详情]
       "正在部署 my-webapp 到 10.0.1.100...
        使用昨天实现的 JWT 认证。"
```

**无需重复解释。没有丢失的上下文。无缝衔接。**

---

## ⚡ 快速开始

### 方式一：一句话安装（推荐）

对 Hermes 说：
```
从 https://github.com/FSWei/gitbrain 安装 skill
```

或使用命令行：
```bash
hermes skills install https://github.com/FSWei/gitbrain
```

然后说：`启用 GitBrain 同步`

### 方式二：手动安装

1. 把 `SKILL.md` 复制到 `~/.hermes/skills/gitbrain.md`
2. 在 Hermes 中说：`启用 GitBrain 同步`

---

## 🔧 工作原理

### 自动同步
- **启动时**：`git pull` 获取最新变更
- **变更后**：`git commit && push` 保存变更

### 设备感知
每台设备有唯一 ID，Memory 条目标记设备：
- `shared` — 全端同步
- `device: pc-win` — 仅本设备

### 冲突解决
- 时间戳优先：最新变更胜出
- 设备 ID 标记防止意外覆盖
- 关键冲突提示用户手动合并

---

## 📊 竞品分析

### Agent 记忆方案对比

| 方案 | Stars | 同步 | 存储 | Agent 支持 | 安装方式 |
|------|-------|------|------|-----------|---------|
| **GitBrain** | 🆕 | ✅ Git | 文件 | Hermes | `hermes skills install` |
| **claude-brain** | 66 | ✅ Git | 文件 | Claude Code | npm install |
| **memex** | 134 | ✅ Git | Markdown | 多 Agent | npm install |
| **Memory-Like-A-Tree** | 124 | ✅ Obsidian | Markdown | 多 Agent | pip install |
| **sqlite-memory** | 74 | ✅ SQLite | Markdown | 多 Agent | npm install |
| **Helixir** | 83 | ❌ | Weights | 多 Agent | pip install |
| **ArcRift** | 243 | ❌ | SQLite | 多 Agent | 扩展 + MCP |
| **knowledge-base-server** | 174 | ❌ | SQLite | 多 Agent | MCP 服务器 |

### 关键差异化

| 特性 | GitBrain | claude-brain | memex |
|------|----------|--------------|-------|
| **Git 原生** | ✅ | ✅ | ✅ |
| **零依赖** | ✅ | ❌ (Node.js) | ❌ (Node.js) |
| **一句话安装** | ✅ | ❌ | ❌ |
| **设备感知** | ✅ | ❌ | ❌ |
| **Hermes 集成** | ✅ 深度 | ❌ | ❌ |
| **中文市场** | ✅ | ❌ | ❌ |

### 为什么选择 GitBrain？

1. **零依赖** — 不需要 Node.js、Python 或额外服务器
2. **一句话安装** — 只需说"启用 GitBrain 同步"
3. **设备感知** — 区分共享记忆和设备私有记忆
4. **Hermes 原生** — 深度集成 Hermes Skill/Memory/SOUL
5. **Git 原生** — 利用 Git 现有基础设施（GitHub、Gitee）

---

## 🛠️ 命令

```bash
# 手动同步
bash ~/.hermes/gitbrain/scripts/sync.sh sync

# 仅拉取
bash ~/.hermes/gitbrain/scripts/sync.sh pull

# 仅推送
bash ~/.hermes/gitbrain/scripts/sync.sh push

# 查看状态
bash ~/.hermes/gitbrain/scripts/sync.sh status

# 后台自动同步
bash ~/.hermes/gitbrain/scripts/sync.sh auto

# 注册同步钩子到 SOUL.md
bash ~/.hermes/gitbrain/scripts/sync.sh register
```

---

## 📁 目录结构

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

## ⚠️ 注意事项

### Pitfall #1: 不要在 ~/.hermes/ 下 git init

GitBrain 仓库必须在 `~/.hermes/gitbrain/`，不能在 `~/.hermes/`。在 `~/.hermes/` 下使用 `git init` 会推送密钥（`.env`）和会话数据库（`state.db`）。

### Pitfall #2: 大文件

不要同步：
- 会话日志（`*.log`）
- 音频/图片缓存
- 数据库文件（`*.db`）

### Pitfall #3: 凭证安全

安全存储 Git 凭证：
```bash
git config --global credential.helper store
chmod 600 ~/.git-credentials
```

---

## 📄 许可证

MIT

## 🔗 相关项目

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent 框架
- [hermes-git-backup](https://github.com/FSWei/hermes-git-backup) — 手动备份（GitBrain 前身）
