# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**最简单的 Agent 记忆同步方案 — 零依赖，只需 Git。**

[English](README.md)

---

## 🎯 什么是 GitBrain？

GitBrain 是 **GBrain 的轻量级替代方案**，适合想要多设备同步但不想搭建复杂系统的用户。

**GBrain**（Garry Tan 创建，24k⭐）是生产级知识图谱，有 146K+ 页面、合成层、24/7 梦境循环。功能强大但复杂。

**GitBrain** 是简化版：**5 分钟，零依赖，只需 Git。**

| | GBrain | GitBrain |
|---|---|---|
| **搭建时间** | ~30 分钟 | ~1 分钟 |
| **依赖** | PGLite/Postgres + API keys | 零 |
| **核心功能** | 知识图谱 + 合成 | Git 同步 |
| **适合场景** | 企业知识管理 | 个人多设备同步 |
| **学习曲线** | 陡峭 | 平缓 |

**选择 GitBrain，如果你：**
- 想快速同步多设备的 Agent 记忆
- 不想搭建数据库或配置 API keys
- 偏好简单而非功能丰富
- 在中文市场（中文文档优先）

**选择 GBrain，如果你：**
- 需要知识图谱和合成层
- 有 100K+ 页面要管理
- 需要生产级功能
- 需要多 Agent 支持（Claude Code、Codex 等）

---

## ⚡ 快速开始（1 分钟）

### 方式一：一句话安装

对 Hermes 说：
```
启用 GitBrain 同步
```

### 方式二：手动

```bash
# 1. 创建私有 Git 仓库（GitHub/Gitee）
gh repo create my-gitbrain --private

# 2. 告诉 Hermes
"启用 GitBrain 同步，仓库地址 https://github.com/you/my-gitbrain.git"
```

搞定。你的 Agent 记忆现在在所有设备间同步。

---

## 🔧 工作原理

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  PC          │   │  MacBook    │   │  服务器      │
│  Agent       │   │  Agent      │   │  Agent      │
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                          ▼
                   ┌─────────────┐
                   │  Git 仓库   │
                   │  (GitHub)   │
                   └─────────────┘
```

- **启动时**：`git pull`（获取最新）
- **变更后**：`git commit && push`（保存）

就这样。没有服务器、没有数据库、没有 API keys。

---

## 📊 什么时候用什么

| 场景 | 推荐 |
|------|------|
| 同步 2-3 台个人设备的记忆 | ✅ GitBrain |
| 管理 100K+ 页面的知识 | ❌ 用 GBrain |
| 团队知识库 + 权限控制 | ❌ 用 GBrain |
| 快速搭建，无技术复杂度 | ✅ GitBrain |
| 企业级合成和差距分析 | ❌ 用 GBrain |
| 中文市场，中文优先 | ✅ GitBrain |

---

## 📄 许可证

MIT

## 🔗 相关项目

- [GBrain](https://github.com/garrytan/gbrain) — 生产级知识图谱（24k⭐）
- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent 框架
