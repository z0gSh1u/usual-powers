# usual-powers

一组可在 Claude Code、Codex 和 OpenCode 中复用的 Agent Skills。

## 平台适配

### Claude Code 安装

```
/plugin marketplace add z0gSh1u/usual-powers
/plugin install usual-powers@usual-powers-marketplace
```

### OpenCode 安装

编辑 `~/.config/opencode/opencode.json`，在 `plugin` 中添加：

```json
"plugin": [
  "usual-powers@git+https://github.com/z0gSh1u/usual-powers"
]
```

## Skills 总览

### 基于 superpowers 的 Skills

- `brainstorming`：通过聚焦对话把想法澄清为已确认的设计和书面 spec。
- `writing-plans`：将已批准的 spec 转换为可独立执行的详细实现计划，并写入 `docs/plans/`。
- `subagent-driven-development`：使用独立 subagent 执行实现计划，进行任务级 Review 和最终整体 Review，并尽可能安全地并行执行。
- `dispatching-parallel-agents`：识别没有共享状态或顺序依赖的独立任务，并并行派遣 agent 处理。
- `test-driven-development`：先写测试并观察失败，再实现最小行为，最后在不改变行为的前提下重构。
- `requesting-code-review`：在任务、主要功能或合并前，带着需求和变更范围发起聚焦的代码 Review。

### 基于 mattpocock/skills 的 Skills

- `diagnosing-bugs`：通过紧反馈循环、最小复现、假设验证和回归测试，系统诊断困难 Bug 与性能问题。

### 其他有参考的 Skills

- `refactor-codebase`：在保持行为不变的前提下，移除死代码并现代化遗留模式；来源于 [ChatGPT use case: Refactor your codebase](https://learn.chatgpt.com/use-cases/refactor-your-codebase)。

### 自有 Skills

- `resolve-conflicts`：结合冲突双方的修改目的和用户补充背景，解决 Git merge、rebase 或 cherry-pick 中的现有冲突，并完成针对性验证。
- `know-how`：探究当前代码库中的功能或技术机制，追踪实现链路并基于证据说明其工作方式。
- `check-before-pr`：在创建或更新 PR 前运行所有相关验证命令，并合理修复可解决的问题。
- `commit-unstaged`：提交所有 unstaged 改动，必要时按逻辑拆分为多个 commit。

## 来源与改造说明

### superpowers

本仓库参考并选取了 [obra/superpowers](https://github.com/obra/superpowers) 中的工作流 Skills，并进行了适当的微调：

- Brainstorming 产物统一写入 `docs/specs/`，Writing plans 产物统一写入 `docs/plans/`
- Brainstorming 现在需要用户显式唤起，不再要求模型必须触发
- Writing plans 结束后只使用 `subagent-driven-development` 执行，不再保留多种执行路径
- 引入 `test-driven-development` 和 `requesting-code-review`，并将它们接入实现与验证流程
- `subagent-driven-development` 不限制只能派遣一个 subagent；模型根据依赖、冲突、共享状态和宿主能力自行决定并行策略，并尽可能最大化安全且有价值的并行
- 验证和 Review 以实际影响为准：minor 问题可以忽略，Critical/Important 问题才需要修复；同一变更最多进行两轮 Review/Fix，避免在细枝末节上原地打转
- 保留 brainstorming 的 visual companion、必要脚本和交互协议，但移除对特定宿主 CLI 工具的依赖，改为平台中立的启动约定
- 保留任务 Brief、实现报告、Review package、状态记录、TDD 约束和最终 Review 等协作接口；删除重复的流程图、冗长示例、重复解释和大段 Red Flags，使 Skill 更容易被模型执行
- 移除 `finishing-a-development-branch` 和 `using-git-worktrees`；Worktrees 应该由用户自己管理，而不是模型隐式创建和切换
- 不单独引入 `receiving-code-review`；当前 Review 由 `requesting-code-review` 和 `subagent-driven-development` 中的任务/最终审查流程承担

### mattpocock/skills

本仓库参考 [mattpocock/skills](https://github.com/mattpocock/skills)，迁移了 `diagnosing-bugs`，并吸收了其部分设计理念：

- `diagnosing-bugs` 保留上游的六阶段诊断流程：建立紧反馈循环、复现与最小化、提出假设、定向插桩、修复与回归测试、清理与复盘
- `diagnosing-bugs` 移除对 `CONTEXT.md`、ADR 和 `improve-codebase-architecture` 的依赖，不要求目标项目安装额外 Skill 或维护特定项目文档
- `resolve-conflicts` 借鉴其 `resolving-merge-conflicts` 的意图分析原则：逐个冲突点读取双方对应的 commit message 或 PR，兼容时保留双方意图，不兼容时不发明新行为并记录取舍；没有照搬其自动完成 merge/rebase 和提交的策略。
- `brainstorming` 借鉴其 `grill-me` 的提问方法：优先追问影响架构、范围、接口、行为和验收标准的关键决策；每次提问先给出推荐方案和主要取舍，再请用户确认；没有引入独立的 `grill-me`/`grill-with-docs` 流程。

## LICENSE

上游内容按 MIT License 迁移，版权归属见根目录 [LICENSE](LICENSE)。
