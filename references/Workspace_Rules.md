# CSP Lua Workspace Rules

Custom Shaders Patch (CSP) uses specific directory path patterns to identify the context (type) of a Lua script. This identification is crucial for:
1. **IntelliSense**: Loading the correct API definitions for the current script type.
2. **Permissions**: Enabling or disabling certain functions (e.g., I/O access).
3. **Execution Context**: Determining when and how the script is loaded by the game.

## Script Type Path Patterns

The following table maps script types to the directory patterns they must be located in.

| Type | Path Patterns | I/O Access |
| :--- | :--- | :--- |
| **Apps** | `apps/*`, `extension/internal/*` | Allowed |
| **Car Physics** | `content/cars/*/data*` | Restricted |
| **Car Display** | `content/cars/*/extension*`, `extension/config/cars/*`, `extension/lua/cars/*` | Restricted |
| **Track Scripts** | `content/tracks/*`, `extension/config/tracks/*`, `extension/lua/tracks/*` | Restricted |
| **Online/Server** | `extension/lua/online/*` | Allowed |
| **WeatherFX Controller** | `extension/weather-controllers/*` | Allowed |
| **WeatherFX Logic** | `extension/weather/*` | Allowed |
| **FFB Post-process** | `extension/lua/ffb-postprocess/*` | Restricted |
| **Chaser Camera** | `extension/lua/chaser-camera/*` | Restricted |
| **Cockpit Camera** | `extension/lua/cockpit-camera/*` | Restricted |
| **Joypad Assist** | `extension/lua/joypad-assist/*`, `extension/lua/mouse-steering/*` | Restricted |
| **New Modes** | `extension/lua/new-modes/*` | Allowed |
| **Fireworks** | `extension/lua/fireworks/*` | Allowed |
| **PP Filters** | `extension/lua/pp-filters/*` | Allowed |
| **Loading Screen** | `extension/lua/loading-screen/*` | Allowed |
| **Tools** | `extension/lua/tools/*` | Allowed |

## VS Code Extension

If you have the custom VS Code extension installed (`vs-code-extension.vsix`), it will use these rules to automatically scan your workspace, detect the type of script you are working on, and update the Lua library path accordingly.

### Troubleshooting
- **Incorrect Type Detection**: Ensure your workspace includes the parent directories (e.g., open `assettocorsa` as a folder rather than just the individual script file).
- **Missing API**: If a function is missing, double-check that your script is in a directory that allows that script type's permissions (e.g., I/O functions won't work in Car Physics scripts).
