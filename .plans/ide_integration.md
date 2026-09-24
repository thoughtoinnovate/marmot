# Marmot: IDE Integration Architecture (VS Code, JetBrains, Neovim)

Because Marmot uses a **Decoupled Microkernel Architecture** (where `marmot-core` is separated from `marmot-tui`), integrating with major IDEs does not require rewriting the agent logic.

Marmot integrates into IDEs using a **Client-Server model** combined with **MCP (Model Context Protocol)** and standard **JSON-RPC**.

---

## 1. The Headless Marmot Server

When a user runs Marmot from an IDE, it starts in headless mode:
```bash
marmot daemon --port 9123 --uds /tmp/marmot.sock
```
The IDE plugin acts purely as a "dumb" UI frontend (just like our `marmot-tui` crate), sending `SubmitPrompt` commands and rendering `TokenDelta` events over WebSockets or Unix Domain Sockets (UDS).

---

## 2. Editor-Specific Implementations

### Visual Studio Code
* **Architecture**: A standard VS Code Extension (TypeScript) using the VS Code Chat API or a Webview panel.
* **Communication**: The extension spawns `marmot daemon` via `child_process` and connects via UDS.
* **Context Sharing**: The VS Code extension exposes an **MCP Server** to Marmot. This allows Marmot to call tools like `vscode_get_active_editor()` or `vscode_get_selected_text()`.

### JetBrains (IntelliJ, WebStorm, PyCharm)
* **Architecture**: A Kotlin-based plugin utilizing JetBrains' Tool Window API.
* **Communication**: Connects to the local Marmot server via WebSockets.
* **Diffs**: Instead of Marmot writing directly to the filesystem, the `marmot-server` can send a `ProposeDiff` event. The JetBrains plugin intercepts this and renders it using JetBrains' native local change visualization, letting the user click "Accept" or "Reject".

### Neovim
* **Architecture**: A lightweight Lua plugin (`marmot.nvim`).
* **Communication**: Neovim excels at `stdio` communication. The Lua plugin spawns `marmot --stdio` in the background. It communicates using standard JSON-RPC (similar to how Neovim talks to LSPs).
* **UI**: Renders the agent's chain-of-thought in a floating window or vertical split buffer. It injects code using Neovim's extmarks and buffer modification APIs.

---

## 3. Bidirectional Context (LSP & MCP)

The magic of Marmot in an IDE is the bidirectional flow of context:

1. **IDE $\rightarrow$ Marmot (Via MCP)**
   * Marmot needs to know what you are looking at. The IDE exposes an MCP server so Marmot can ask: *"What files are open?"* or *"What is the cursor's current line?"*
2. **Marmot $\rightarrow$ IDE (Via LSP/JSON-RPC)**
   * Marmot generates a refactor. Instead of saving it directly, it streams the intent back to the IDE, allowing the IDE to format the code, run its local LSP diagnostics, and display a native Diff preview.
