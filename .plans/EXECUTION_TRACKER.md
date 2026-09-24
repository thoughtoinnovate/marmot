# 🚀 Marmot Execution Tracker

This is your single, trackable entrypoint. As you (or an AI agent) complete the code generation phases detailed in the [Spoon-Fed Implementation Playbook](./spoonfeed_implementation_plan.md), check the boxes below by changing `[ ]` to `[x]`.

> **🔄 AGENT RESUMPTION PROTOCOL**
> If you are an AI picking up this task in a new session:
> 1. Scan this file to find the first unchecked `[ ]` task.
> 2. Run `cargo check --workspace` and `cargo test --workspace` to verify the state of the codebase matches the checked boxes. Fix any compilation errors left by the previous session before proceeding.
> 3. Read the corresponding step in `spoonfeed_implementation_plan.md`.
> 4. Continue execution without duplicating already completed work.

---

## Phase 1: Core Foundation (The Microkernel & Types)
*See `spoonfeed_implementation_plan.md` Step 0 - Step 2*

- [ ] **🤖 Agent Instruction (MANDATORY)**: Before writing code for this phase, use your web search tools to explore the best guides and modern practices for lightweight, fast, self-improvable agent state machines and event protocols in Rust.
- [ ] **Step 0: Workspace Initialization**
  - [ ] Create workspace `Cargo.toml`.
  - [ ] Verify: `cargo check` passes.
- [ ] **Step 1: Crate `marmot-protocol`**
  - [ ] Create crate structure.
  - [ ] Define `MarmotCommand` and `MarmotEvent` Enums.
  - [ ] Verify: `cargo test -p marmot-protocol` passes.
- [ ] **Step 2: Crate `marmot-tools`**
  - [ ] Create crate structure.
  - [ ] Implement `ViewFileTool`, `WriteFileTool`, and `RunBashTool`.
  - [ ] Verify: `cargo check -p marmot-tools` passes.

---

## Phase 2: Engine & Decoupled Server
*See `spoonfeed_implementation_plan.md` Step 3 - Step 4*

- [ ] **🤖 Agent Instruction (MANDATORY)**: Before writing code for this phase, search the web for the latest architectural best practices in building decoupled, headless agent servers, LLM mock providers, and capability-gating (permission brokers) in Rust.
- [ ] **Step 3: Crate `marmot-core`**
  - [ ] Implement `PermissionBroker`.
  - [ ] Implement `MockProvider` (deterministic testing).
  - [ ] Implement `MasterLoop` event dispatcher.
  - [ ] Verify: `cargo test -p marmot-core` passes.
- [ ] **Step 4: Crate `marmot-server`**
  - [ ] Implement async channel proxy / socket server.
  - [ ] Verify: `cargo check -p marmot-server` passes.

---

## Phase 3: The TUI & Binary Glue
*See `spoonfeed_implementation_plan.md` Step 5 - Step 6*

- [ ] **🤖 Agent Instruction (MANDATORY)**: Before writing code for this phase, search for modern `ratatui` best practices, non-blocking async TUI architectures, and how tools like Claude Code or Cursor handle TUI responsiveness and streaming.
- [ ] **Step 5: Crate `marmot-tui`**
  - [ ] Setup `ratatui` backend and `crossterm` event stream.
  - [ ] Implement non-blocking chat, tool spinners, and permission modal states.
  - [ ] Verify: `cargo check -p marmot-tui` passes.
- [ ] **Step 6: Crate `marmot-cli` (The Entrypoint)**
  - [ ] Wire `marmot-server`, `marmot-core`, and `marmot-tui` together.
  - [ ] Verify: `cargo build --workspace` compiles `marmot-cli`.
  - [ ] **Milestone achieved:** You can now run `./target/debug/marmot-cli` and interact with the mock engine!

---

## Phase 4: The Extensibility Harness (Self-Improvement)
*These require expanding beyond the initial playbook.*

- [ ] **🤖 Agent Instruction (MANDATORY)**: Before implementing this phase, deeply research "LLM self-improvement architectures", "Extism Wasm plugin hosts in Rust", and "LSP agent integrations" to ensure the implementation is cutting-edge and lightweight.
- [ ] **Step 7: Real LLM Integration**
  - [ ] Swap `MockProvider` for `AnthropicProvider` (SSE streaming).
- [ ] **Step 8: `marmot-plugin-memory`**
  - [ ] Setup local SQLite database (`marmot.db`).
  - [ ] Hook into `pre_turn` and `TurnCompleted`.
- [ ] **Step 9: Wasm Self-Improvement Sandbox**
  - [ ] Embed Extism Wasm runtime.
  - [ ] Allow the agent to dynamically register `plugin.wasm` files mid-turn.
- [ ] **Step 10: LSP Bridge**
  - [ ] Connect `rust-analyzer`/`tsserver` for live compilation diagnostics.
