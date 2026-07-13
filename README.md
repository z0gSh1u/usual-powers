# usual-powers

## 平台适配

- Claude Code：使用 `.claude-plugin/plugin.json`。
- Codex：使用 `.codex-plugin/plugin.json`，由 `skills` 字段指向根目录的 `skills/`。
- OpenCode：使用 `.opencode/plugins/usual-powers.js` 将根目录的 `skills/` 注册到技能发现路径。

## 基于 superpowers 的改造说明

本仓库参考并选取了 [obra/superpowers](https://github.com/obra/superpowers) 中的工作流 Skills，但不是完整镜像。

- Brainstorming 产物统一写入 `docs/specs/`。
- Writing plans 产物统一写入 `docs/plans/`。
- Writing plans 结束后只使用 `subagent-driven-development` 执行，不再保留多种执行路径。
- 引入 `test-driven-development` 和 `requesting-code-review`，并将它们接入实现与验证流程。
- `subagent-driven-development` 不限制只能派遣一个 subagent；模型根据依赖、冲突、共享状态和宿主能力自行决定并行策略，并尽可能最大化安全且有价值的并行。
- 验证和 Review 以实际影响为准：minor 问题可以忽略，Critical/Important 问题才需要修复；同一变更最多进行两轮 Review/Fix，避免在细枝末节上原地打转。
- `skills/` 是唯一内容源，平台目录只负责注册和发现，不复制 Skill 内容。
- 保留 brainstorming 的 visual companion、必要脚本和交互协议，但移除对特定宿主 CLI 工具的依赖，改为平台中立的启动约定。
- 保留任务 Brief、实现报告、Review package、状态记录、TDD 约束和最终 Review 等协作接口；删除重复的流程图、冗长示例、重复解释和大段 Red Flags，使 Skill 更容易被模型执行。
- 移除关于 `finishing-a-development-branch` 和 `using-git-worktrees` 的表述；当前流程不依赖这两个 Skill。
- 不单独引入 `receiving-code-review`；当前 Review 由 `requesting-code-review` 和 `subagent-driven-development` 中的任务/最终审查流程承担。

## 自有 Skills

以下 Skills 按本仓库的实际工作习惯独立设计：

- `resolve-conflicts`：结合冲突双方的修改目的和用户补充背景，解决 Git merge、rebase 或 cherry-pick 中的现有冲突，并完成针对性验证。
- `know-how`：探究当前代码库中的功能或技术机制，追踪实现链路并基于证据说明其工作方式。
- `check-before-pr`：在创建或更新 PR 前运行所有相关验证命令，并合理修复可解决的问题。
- `commit-unstaged`：提交所有 unstaged 改动，必要时按逻辑拆分为多个 commit。
- `refactor-codebase`：在保持行为不变的前提下，移除死代码并现代化遗留模式；来源于 [ChatGPT use case: Refactor your codebase](https://learn.chatgpt.com/use-cases/refactor-your-codebase)。

## 迁移的其他 Skills

- `diagnosing-bugs`：通过紧反馈循环、最小复现、假设验证和回归测试，系统诊断困难 Bug 与性能问题；已移除对 `CONTEXT.md`、ADR 和其他架构 Skill 的依赖。

## 基于 mattpocock/skills 的迁移说明

本仓库参考 [mattpocock/skills](https://github.com/mattpocock/skills)，只迁移了 `diagnosing-bugs`，没有完整引入其工程工作流体系。

- 保留上游的六阶段诊断流程：建立紧反馈循环、复现与最小化、提出假设、定向插桩、修复与回归测试、清理与复盘。
- 保留可选的 `scripts/hitl-loop.template.sh`，仅用于无法自动化、必须由人工操作的复现步骤。
- 移除对 `CONTEXT.md`、ADR 和 `improve-codebase-architecture` 的依赖，不要求目标项目安装额外 Skill 或维护特定项目文档。
- 按本仓库的跨平台约定放入根目录 `skills/`，由 Claude Code、Codex 和 OpenCode 的现有适配层统一发现。
- `resolve-conflicts` 借鉴其 `resolving-merge-conflicts` 的意图分析原则：逐个冲突点读取双方对应的 commit message 或 PR，兼容时保留双方意图，不兼容时不发明新行为并记录取舍；没有照搬其自动完成 merge/rebase 和提交的策略。
- `brainstorming` 借鉴其 `grill-me` 的提问方法：优先追问影响架构、范围、接口、行为和验收标准的关键决策；每次提问先给出推荐方案和主要取舍，再请用户确认；没有引入独立的 `grill-me`/`grill-with-docs` 流程。
- 上游内容按 MIT License 迁移，版权归属见根目录 [LICENSE](LICENSE)。
