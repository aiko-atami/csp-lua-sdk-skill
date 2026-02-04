# Assetto Corsa CSP Lua SDK Skill

This repository contains a **Claude Skill** designed to help users engage with the Assetto Corsa Custom Shaders Patch (CSP) Lua SDK. It provides Claude with context, API definitions, and best practices for creating CSP scripts.

## 📂 Repository Structure

- **`SKILL.md`**: The core definition of the skill, including the entry point instructions for Claude.
- **`references/`**: Contains detailed documentation and raw API definitions (`.lua` files) used by the skill for context.
- **`README.md`**: This file (documentation for humans).

## 🚀 Installation

To use this skill with Claude:

1.  **Download the latest release**:
    *   Go to the [Releases page](../../releases/latest).
    *   Download the `csp-lua-sdk.zip` asset.
2.  **Upload to Claude**:
    *   Navigate to **Settings > Capabilities > Skills** (or the relevant Skills menu in your Claude interface).
    *   Click **Add Skill** (or Upload).
    *   Upload the `.zip` file.

## ✨ Features

When this skill is enabled, you can ask Claude to:

*   **Generate Code**: "Write a CSP app that displays a turbo gauge."
*   **Debug Scripts**: "Why is my physics script throwing a strict mode error?"
*   **Explain APIs**: "How does `ac.OnlineEvent` work for data synchronization?"
*   **Optimize Performance**: "Refactor this `update()` loop for better performance."

## ⚠️ Note on Structure

This repository follows strict naming conventions required for Claude Skills:
*   The main file is named `SKILL.md`.
*   Folder names are in `kebab-case`.
*   Documentation is stored in `references/`.

For more details on building skills, refer to the official [Anthropic/Claude Skills documentation](https://docs.anthropic.com/).
