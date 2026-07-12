# usual-powers

跨 Claude Code、Codex 和 OpenCode 复用的 Agent Skills 集合。

## 目录约定

- `skills/` 是所有 Skill 的唯一内容源。
- 每个 Skill 使用 `skills/<skill-name>/SKILL.md` 作为入口。
- `.claude-plugin/`、`.codex-plugin/` 和 `.opencode/` 只负责平台适配，不复制 Skill 内容。

## 新增 Skill

```text
skills/<skill-name>/
├── SKILL.md
├── references/    # 可选：较长的参考资料
├── scripts/       # 可选：可重复执行的工具
└── assets/        # 可选：模板、图片等资源
```

`SKILL.md` 的目录名和 frontmatter 中的 `name` 必须一致，并使用小写字母、数字和单连字符。

```markdown
---
name: example-skill
description: Use when a specific task or situation requires this reusable workflow.
---

# Example Skill

Add the skill instructions here.
```

## 平台适配

- Claude Code：使用 `.claude-plugin/plugin.json`。
- Codex：使用 `.codex-plugin/plugin.json`，由 `skills` 字段指向根目录的 `skills/`。
- OpenCode：使用 `.opencode/plugins/usual-powers.js` 将根目录的 `skills/` 注册到技能发现路径。

当前仓库基于以下来自 `obra/superpowers` 的 Skills，并针对跨平台使用做了精简和适配：

- `brainstorming`（包含视觉伴侣的完整文件和脚本）
- `writing-plans`
- `subagent-driven-development`
- `dispatching-parallel-agents`
- `test-driven-development`
- `requesting-code-review`
