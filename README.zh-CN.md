# GitBrain

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-blue.svg)](https://github.com/NousResearch/hermes-agent)

**给 Agent 装个 Git 大脑 — 用 Git 自动同步多设备的 Skill 和 Memory。**

[English](README.md)

## 什么是 GitBrain？

GitBrain 让多台设备通过 Git 共享同一套 Agent 知识库——不需要单独的云服务器。

**与云端部署的本质区别：**
- **云端整体部署**：大脑和手脚长在一起，只能操作云端能碰到的东西
- **GitBrain 模式**：大脑和记忆共享，手脚留在本地，每台设备能操作各自的本地软件

## 快速开始

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

## 工作原理

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│  设备 A      │   │  设备 B      │   │  设备 C      │
│  本地 Agent  │   │  本地 Agent  │   │  本地 Agent  │
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │ pull/push       │ pull/push       │ pull/push
       └────────┬────────┴────────┬────────┘
         ┌──────▼──────────────────▼──────┐
         │     Git 仓库（GitHub/Gitee）    │
         │  Skills/  Memories/  Config/   │
         └────────────────────────────────┘
```

## 核心功能

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

## 许可证

MIT

## 相关项目

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent 框架
