---
name: check-before-pr
description: Run all relevant safe validation commands before creating or updating a pull request, including lint, type checks, tests, builds, and project-specific verification scripts. Diagnose and reasonably fix failures, then rerun affected checks. Use when the user asks to check work before a PR, validate a change, or make the project pass its verification suite.
---

# Check Before PR

在创建或更新 PR 前，运行当前项目所有相关且安全的验证命令；发现问题后合理修复并重新验证。默认不提交、推送或创建 PR。

## Workflow

1. 保护当前工作区：先查看 `git status` 和完整 diff，阅读仓库中的 `AGENTS.md`、README、贡献指南和 CI 配置。不要使用会丢失用户修改的命令。
2. 识别项目生态、包管理器和验证入口。检查 lockfile、`package.json`、Makefile/Justfile/Taskfile、项目配置、CI workflow 以及文档中声明的命令。
3. 枚举所有安全的验证命令，包括名称或用途涉及 `format`、`lint`、`typecheck`、`type-check`、`check`、`validate`、`test`、`verify`、`build` 的脚本和项目专用检查。不要只运行一个默认 test 命令。
   - TypeScript 项目至少检查存在的 lint、typecheck、test 和 build；同时运行其他明确用于验证的脚本。
   - Monorepo 优先运行能覆盖子包的根级命令，避免重复执行；必要时补跑未被覆盖的包级命令。
   - 跳过 watch、dev、start、serve、deploy、publish、release、破坏性迁移和需要人工交互的命令，除非用户明确要求。使用项目已有的 CI/non-interactive 选项。
4. 按依赖顺序执行验证：格式检查、lint、类型检查、单元/集成/E2E 测试、构建及其他项目检查。记录每条命令及其结果，不因一条失败就漏掉其他独立检查。
5. 处理失败：
   - 先用最小范围命令复现，判断问题来自代码、测试、配置、工具链、依赖、环境还是外部服务；
   - 阅读失败位置及相关调用方、配置和测试，结合当前 diff 判断预期行为；
   - 对可以安全解决的问题做最小、针对性的修复，必要时补充回归测试；
   - 不通过删除测试、放宽断言、关闭 lint/typecheck、吞掉错误或大范围重构来制造“通过”；
   - 依赖缺失时遵循项目已有包管理器和 lockfile。不要为了通过检查擅自更换依赖或包管理器；安装依赖需要外部权限时，报告阻塞原因。
6. 每次修复后先重跑受影响的最小检查；全部修复后重新执行完整验证集合。每次重跑都应对应一个修复或明确的诊断动作，避免盲目重复。
7. 确认最终工作区状态和 diff，确保没有遗留临时文件、调试代码、冲突标记或不必要的生成物。除非用户明确要求，不要提交、推送或创建 PR。

## Output

汇报：

- 执行过的验证命令及结果；
- 发现的问题、根因和实际修复；
- 最终通过的验证范围；
- 仍未解决的问题、阻塞原因和下一步建议。

如果所有验证通过，明确说明可以进入 PR 阶段；如果无法安全修复，明确区分代码问题和环境/外部依赖问题，不要声称验证通过。
