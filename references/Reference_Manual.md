# CSP Lua SDK Reference Manual

This manual consolidates documentation for the Custom Shaders Patch (CSP) Lua SDK. It is designed to be a comprehensive reference for AI agents and developers.

## 1. Overview

The CSP Lua SDK allows developers to script custom behavior in Assetto Corsa using LuaJIT. Scripts can control UI, physics, rendering, weather, and more.

### Script Types & Paths
CSP detects the script type based on its location. For IntelliSense to work correctly, your workspace must follow these patterns:

| Type | Directory Path Pattern | Purpose |
| :--- | :--- | :--- |
| **Apps** | `apps/*`, `extension/internal/*` | UI overlays, tools. |
| **Car Physics** | `content/cars/*/data*` | Custom physics (No I/O). |
| **Car Display** | `content/cars/*/extension*`, `extension/config/cars/*`, `extension/lua/cars/*` | Digital dashboards, active aero. |
| **Track Scripts** | `content/tracks/*`, `extension/config/tracks/*`, `extension/lua/tracks/*` | Track logic (No I/O). |
| **Online/Server** | `extension/lua/online/*` | Server-side logic. |
| **WeatherFX** | `extension/weather-controllers/*`, `extension/weather/*` | Weather & lighting controllers. |

> [!NOTE]
> For a full list of paths, refer to [Workspace Rules](Workspace_Rules.md).

---

## 2. Development Environment

### IDE Setup (VS Code)
To get the best development experience with autocomplete and type checking:

1. **Install Lua Extension**: Use the "Lua by sumneko" extension.
2. **Library Configuration**: Point the extension to the library folders in `extension/internal/lua-sdk`.
3. **Workspace Integrity**: Ensure your files are in the paths listed above so the SDK can auto-detect the context.
4. **Large Files Fix**: If autocomplete stops working, increase the preload limit in VS Code settings:
   - Search for `Lua.workspace.preloadFileSize`.
   - Set it to `2000` (KB).

### Debugging
1. Enable **Lua Debug** app in `CSP Settings > GUI > Developer Apps`.
2. Open **Lua Debug** app in-game.
   - Shows running scripts, errors, performance, and logs.
3. `ac.log('Message')` prints to the log.
4. `ac.warn('Message')` prints a warning.
5. `ac.error('Message')` prints an error.

---

## 3. App Development

Apps are the most common entry point. They live in `assettocorsa/apps/lua/<AppName>/`.

### `manifest.ini` Structure
Calls to `script.*` functions are defined here.
```ini
[ABOUT]
NAME = My App
AUTHOR = Me
VERSION = 1.0

[CORE]
LAZY = FULL ; FULL=Unload on close, PARTIAL=Keep running hidden, NONE=Always run

[WINDOW_...]
ID = main
NAME = My Window
ICON = icon.png
FUNCTION_ICON = dynamicIcon ; [NEW] Draw icon dynamically
FUNCTION_MAIN = windowMain
FUNCTION_ON_SHOW = onShow       ; [NEW] Called when window opens
FUNCTION_ON_HIDE = onHide       ; [NEW] Called when window closes
FUNCTION_SETTINGS = onSettings  ; [NEW] For [SETTINGS] flag
FLAGS = AUTO_RESIZE, SETTINGS, DARK_HEADER, FADING

[SIM_CALLBACKS]
UPDATE = update ; Calls script.update()
FRAME_BEGIN = onFrameBegin ; [NEW] Before scene rendering

[RENDER_CALLBACKS]
OPAQUE = onOpaque           ; [NEW] After opaque geometry
TRANSPARENT = onTransparent ; [NEW] After transparent objects

[UI_CALLBACKS]
IN_GAME = onInGame          ; [NEW] For custom fullscreen HUDs
```

### Lifecycle & Callbacks
Beyond `windowMain`, CSP provides several ways to hook into the simulation:
- **Window Events**: Defined in `manifest.ini`, `FUNCTION_ON_SHOW` and `FUNCTION_ON_HIDE` are perfect for initializing or pausing data collection.
- **Sim Callbacks**:
    - `ac.onLapCompleted(carIndex, callback)`: Triggers when any car finishes a lap.
    - `ac.onSharedEvent(eventName, callback)`: Connects with `[AWAKE_TRIGGERS]` in manifest.
    - `ac.onChatMessage(callback)`: [Online] Triggered when a new chat message arrives.
    - `_physics_RigidBody:onCollision(callback)`: Triggered on collision (requires rigid body reference).
- **Execution Order**: Apps run after Car Scripts. WeatherFX and Track Scripts run with specific render priority.

### Common `FLAGS`
- `AUTO_RESIZE`: Resize window to fit content.
- `DARK_HEADER`: Black font and symbols in titlebar.
- `FADING`: Windows fades when inactive.
- `FLOATING_TITLE_BAR`: Title bar elements float/stack.
- `HIDDEN_OFFLINE` / `HIDDEN_ONLINE`: Contextual visibility.
- `HIDDEN_RENDER_VR` / `..._SINGLE` / `..._TRIPLE`: Screen setup visibility.
- `NO_TITLE_BAR`: Hide title bar.
- `NO_BACKGROUND`: Transparent background.
- `SETTINGS`: Adds a settings cog to the title bar.
- `SETUP`: Show in car setup screen.

### Lua Entry Point (`<AppName>.lua`)
```lua
function script.windowMain(dt)
  ui.text("Hello World")
  if ui.button("Click Me") then
    ac.log("Clicked!")
  end
end

function script.update(dt)
  -- Called every frame if defined in manifest [SIM_CALLBACKS]
end
```

### UI System (ImGui)
CSP uses **Dear ImGui**. Interaction is immediate mode.
- `ui.text(str)`
- `ui.button(label)` -> returns `true` if clicked.
- `ui.checkbox(label, value)` -> returns `new_value, changed`.

**Advanced UI & Custom Drawing**:
- `ui.drawList()`: Access the ImGui DrawList for drawing custom lines, rectangles, and gradients.
- `ui.DWriteFont(name, path)`: Use DirectWrite fonts for high-quality text rendering.
- `ui.dwriteText(text, size)`: Draw text using the currently pushed DWrite font.
- `ui.ImageSource`: Reference custom texture assets.
- `ui.SmoothInterpolation(initialValue, weight)`: Helper for smooth UI transitions.
- `ui.FadingElement(drawCallback)`: Helper for elements that fade in/out.

**Transparency Issue**:
If images look dark in transparent areas, wrap draw calls:
```lua
ui.beginPremultipliedAlphaTexture()
ui.image(...)
ui.endPremultipliedAlphaTexture()
```

---

## 4. Online & Server Scripts

### Multi-Client Sync (`ac.OnlineEvent`)
Use `ac.OnlineEvent` to share data between players. Both scripts must use the exact same layout.
- **Limits**:
    - Original AC Server: **175 bytes** max per packet, **200ms** min interval.
    - UDP is only available if `ac.getSim().directUDPMessagingAvailable` is true.
- **Usage**: Define a layout using `ac.StructItem`:
```lua
local myEvent = ac.OnlineEvent({
  speed = ac.StructItem.float(),
  name = ac.StructItem.string(32)
}, function(sender, data)
  ac.log("Received " .. data.name .. " going " .. data.speed)
end)

-- To broadcast:
myEvent({ speed = 100, name = "Driver" })
```

### Server Config (`csp_extra_options.ini`)
To enforce scripts on clients:
```ini
[SCRIPT_...]
SCRIPT = "http://url.to/script.lua"
CHECKSUM = "sha256_hash_of_script"
REQUIRED = 1 ; 0 or 1
```

### Local Testing (Not for Production)
1. Place script in `assettocorsa/extension/lua/online/example.lua`.
2. In `csp_extra_options.ini`:
   ```ini
   [SCRIPT_TEST]
   SCRIPT = "example.lua"
   ```
3. Edits to `example.lua` will live-reload.

### Mumble Integration
Enable Mumble Voice Chat in `csp_extra_options.ini`:
```ini
[MUMBLE_INTEGRATION]
HOST = 'mumble.server.com'
PORT = 64738
```

### Inter-Script Communication
Scripts can communicate without direct references using shared events:
- `ac.broadcastSharedEvent(key, data)`: Sends an event to any script listening.
- `ac.onSharedEvent(key, callback)`: Listen for events from other scripts.

---

## 5. Environment & WeatherFX

WeatherFX scripts allow deep world integration. They live in `extension/weather-controllers/` or `extension/weather/`.

### WeatherFX Script Structure
The `script` table in WFX implementation supports:
- `script.update(dt)`: Main logic.
- `script.asyncUpdate(dt)`: Background thread update (no AC API access).
- `script.renderSky(...)`: Sky rendering hook.
- `script.renderClouds(...)`: Cloud rendering hook.
- `script.renderTrack(...)`: Track transparent surface rendering.

### World Control
- `ac.setTrackCondition(key, value)`: Update track conditions (rain, wetness, etc.).
- `ac.setWeatherIntensity(intensity)`: Control rain/fog density.

- **Shared Libraries**: You can include common logic from `extension/internal/lua-shared/` using `require('lib_...')`.
- **Modularity**: Use `require()` to split large apps. In Physics scripts, `require` is restricted to libraries that do not use I/O.
- **Project Structure**: For complex apps, use a `src/` or `modules/` folder and `require` them from the main script.
- **Material Overrides**:
    - Use `ac.findMeshes(pattern)` to get an `ac.SceneReference`.
    - Use `:setMaterialProperty(property, value)` or `:setMaterialTexture(slot, texture)` to change visuals.
    - Example: `ac.findMeshes('geo_headlights'):setMaterialProperty('ksEmissive', rgbm(1, 1, 0, 5))`

### Audio & Sound
CSP allows playing both simple UI sounds and complex 3D world sounds.
- `ui.playSound(name)`: Play a standard UI sound.
- `ac.AudioEvent(path, reverbResponse, useOcclusion)`: Create a 3D audio event.
    - `:setPosition(pos)`: Set world position.
    - `:setVolume(vol)`: Control volume.
    - `:play()` / `:stop()`: Control playback.

### Physics Raycasting
Use raycasting to detect the track surface or other objects:
- `physics.raycastTrack(pos, dir, length)`: Returns distance to track surface and other meta-data.

---

## 7. Performance & Preprocessor

CSP includes a Lua preprocessor to optimize scripts.

### Features
1. **Enum Inlining**: `ac.Wheel.FrontRight` becomes `0`.
2. **Const Folding**: `const(math.pi * 2)` becomes `6.28...`.
3. **Bitwise Opt**: `bit.band(const, const)` is resolved at compile time.

### Usage
- Add `---@ext` or `---@ext:verbose` (prints final code to log) at the top of the file to enable.
- Use `const()` for values that never change.

### Profiling & Performance
- Use the **Lua Debug** app (Developer Apps) to see CPU usage per script in real-time.
- **`ac.skipFrame()`**: In specialized scripts (like displays), use this to run logic at lower frequency (e.g., skip 1 out of 2 frames).
- **`shm` (Shared Memory)**: Use `ac.SharedMemory` for fast data exchange without serialization overhead.

### `const()` Rules & Examples
- **Tables**: Inlined only if code refers to primitive properties (e.g., `config.speed`) and never to the table itself.
- **Functions**: Can mimic macros; replaced with argument substitution if result is not fully resolvable.
- **Loadstring**: Use `loadstring(const(...))` to optimize dynamically loaded code.
```lua
-- Optimize complex config
local config = const(require('config'))

-- Optimize math
local threshold = const(100 * 100)
```

---

## 6. Important Best Practices

1. **Do NOT Hardcode Enums**: Use `ui.StyleVar.FramePadding`, not numbers. Values change.
2. **Namespace Safety**: Do NOT add to `script`, `math`, `table`, or `string`. Standard library updates may overwrite your extensions.
3. **Internal Tables**: Avoid anything starting with `_` (e.g., `__util`). These are internal and unstable.
4. **VRAM Management**: `:dispose()` is usually unnecessary unless you need to free VRAM immediately (e.g., for heavy `ui.ExtraCanvas` recreation).
5. **I/O Permissions**: Apps and user-installed scripts (post-fx, etc.) have full I/O and process access. Car/Track/Online scripts are sandboxed.
6. **Use `stringify`**: Use `stringify.binary()` for fast (and private) serialization of tables.
7. **Timers**: Use `setInterval(fn, ms)` for non-frame-critical updates instead of checking time in `update()`.
8. **No `ffi`**: FFI is restricted for compatibility.

---

## 7. Useful Snippets

### Check if Car is on Track
```lua
local function isOnValidTrack(carIndex)
  local car = ac.getCar(carIndex)
  local invalidWheels = 0
  for i = 0, 3 do
    if not car.wheels[i].surfaceValidTrack then
      invalidWheels = invalidWheels + 1
    end
  end
  return invalidWheels < 2 -- Allow 1 wheel off
end
```

### Hide Lap Invalidated Message
```lua
-- Mark lap as spoiled every frame effectively hiding the message
setInterval(function() 
  ac.markLapAsSpoiled(true) 
end, 0)
```

## 8. External Resources

- [Internal Apps Source](https://github.com/ac-custom-shaders-patch/acc-lua-internal)
- [Example Scripts](https://github.com/ac-custom-shaders-patch/acc-lua-examples)
- [Paintshop App (Advanced Example)](https://github.com/ac-custom-shaders-patch/app-paintshop)
