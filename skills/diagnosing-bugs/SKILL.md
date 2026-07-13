---
name: diagnosing-bugs
description: Diagnose hard bugs and performance regressions by building a tight feedback loop, minimizing the reproduction, testing ranked hypotheses, instrumenting one variable at a time, fixing with regression coverage, and verifying cleanup. Use when the user asks to diagnose or debug a failure, reports broken behavior, exceptions, intermittent errors, or slow performance.
---

# Diagnosing Bugs

对困难 Bug 使用严格的诊断循环。除非有明确理由，否则不要跳过阶段。探究代码时先阅读仓库已有的开发说明、相关文档、测试和配置，使用项目自己的术语。

## Phase 1 — Build a feedback loop

先建立一个能针对这个 Bug 变红的紧反馈循环。没有准确的通过/失败信号时，不要直接阅读代码形成猜测；二分、假设验证和插桩都依赖这个信号。

按适用性优先尝试：

1. 在能够触达 Bug 的 seam 上写失败测试（unit、integration 或 E2E）。
2. 对运行中的开发服务使用 curl 或 HTTP 脚本。
3. 使用固定输入运行 CLI，并将输出与已知正确结果比较。
4. 使用 Playwright/Puppeteer 等无头浏览器，断言 DOM、console 或 network 行为。
5. 保存并重放网络请求、payload 或事件日志。
6. 创建只覆盖问题路径的临时 harness，隔离服务和依赖。
7. 对错误输出或非确定性行为使用 property/fuzz 循环。
8. 如果问题出现在已知版本区间，用 `git bisect run` 自动定位。
9. 将相同输入放入旧版本和新版本（或不同配置）进行差异比较。
10. 最后才使用 [scripts/hitl-loop.template.sh](scripts/hitl-loop.template.sh) 组织必须由人工操作的复现步骤。

建立循环后继续收紧它：缩小测试范围、缓存初始化、固定时间和随机种子、隔离文件系统或冻结网络。循环应当足够快、稳定，并断言用户描述的具体症状，而不是只断言“没有崩溃”。

对于非确定性 Bug，提高复现率而不是等待一次偶然失败：重复运行、并行施压、缩窄时序窗口，或注入可控延迟。若确实无法构建循环，停止猜测，明确列出尝试过的方式，并请求复现环境、日志/录屏/HAR 等材料，或请求添加临时观测手段的权限。

Phase 1 完成的标准：已经实际运行过一个命令，且它满足以下条件：

- 能触达真实 Bug 路径，并断言用户的确切症状；
- 每次运行得到相同结论，或对非确定性问题有足够高的复现率；
- 运行时间足够短；
- 可以无人值守执行。

## Phase 2 — Reproduce and minimise

运行反馈循环，确认它复现的是用户描述的问题，而不是附近的另一个错误。多次运行并记录准确症状，包括错误信息、错误输出或性能数据。

然后逐项删减输入、调用方、配置、数据和步骤。每次删减后重新运行，只保留导致问题仍然存在的部分，直到剩余元素都是必要条件。最小复现应当成为后续回归测试的候选。

## Phase 3 — Hypothesise

在验证任何一个原因前，生成 3–5 个按优先级排序、可证伪的假设。每个假设都要说明可观察的预测，例如：

> 如果原因是 X，那么改变 Y 应该使问题消失或加重。

把假设列表展示给用户，利用用户的领域信息重新排序；用户暂时不在线时不要因此阻塞，继续按当前排序推进。没有可观察预测的猜测不应进入列表。

## Phase 4 — Instrument

每次探针都必须对应某个假设的预测，并且一次只改变一个变量。

优先使用 Debugger 或 REPL；其次在能区分假设的边界添加定向日志。不要“到处打印再 grep”。所有临时日志使用唯一前缀，例如 `[DEBUG-a4f2]`，结束前用该前缀搜索并清理。

性能问题优先建立基线测量，例如计时 harness、`performance.now()`、profiler 或 query plan，再进行修复或二分；先测量，后修改。

## Phase 5 — Fix and regression-test

只有存在正确的测试 seam 时，才在修复前写回归测试。测试应当从调用方实际遇到的路径验证真实 Bug，而不是只测试一个无法复现问题的内部函数。

如果存在正确 seam：

1. 将最小复现转成该 seam 上的失败测试；
2. 确认测试确实变红；
3. 实施最小修复；
4. 确认测试变绿；
5. 用原始的、未最小化的场景重新运行 Phase 1 循环。

如果不存在正确 seam，记录这是当前架构的测试限制，不要用浅层测试制造虚假的安全感。仍然要修复问题并说明缺少可靠回归覆盖的风险。

## Phase 6 — Cleanup and post-mortem

在宣布完成前确认：

- 原始复现已不再失败；
- 回归测试通过，或已记录为什么无法建立可靠 seam；
- 所有 `[DEBUG-...]` 临时日志已删除；
- 临时 harness 和 throwaway prototype 已删除或移入明确标记的调试位置；
- 已说明最终证实的原因，以及未来如何降低再次发生的可能性。

如果修复过程中发现了独立的架构风险，将它作为后续建议单独记录，不要为了当前 Bug 扩大修复范围。
