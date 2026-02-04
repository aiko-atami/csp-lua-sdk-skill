---
name: csp-lua-sdk
description: Comprehensive SDK and guide for Assetto Corsa Custom Shaders Patch (CSP) Lua scripting. Use when the user asks to create, modify, debug, or explain CSP Lua scripts for apps, physics, cars, or tracks.
version: 1.0.0
---

# Assetto Corsa CSP Lua SDK

## Instructions

### Step 1: Identify Script Type
Determine the type of script you are working with (App, Car, Track, etc.).
- Refer to [Workspace Rules](references/Workspace_Rules.md) for directory structure requirements.

### Step 2: Consult API Definitions
Use the raw API definition files for accurate IntelliSense and function signatures. These are located in `references/api/`.
- **Apps**: `references/api/ac_apps.lib.lua`
- **Car Physics**: `references/api/ac_car_cphys.lib.lua`
- **Car Display**: `references/api/ac_car_scriptable_display.lib.lua`
- **Online**: `references/api/ac_online_script.lib.lua`
- **Track**: `references/api/ac_track_script.lib.lua`
- **General Tools**: `references/api/ac_tools.lib.lua`

### Step 3: Implement Logic
- Use [Quick Reference](references/Quick_Reference.md) for common snippets.
- Use [Reference Manual](references/Reference_Manual.md) for deep dives into specific subsystems.

## Examples

### Example 1: Creating a Simple Lag-Filtered Car Display
**User says:** "Make a speedometer that doesn't jitter."
**Code:**
```lua
-- Filtered car state
local speed = math.applyLag(prev, ac.getCar(0).speedKmh, 0.8, dt)
display.text{ text = string.format("%.0f", speed), pos = vec2(10, 10) }
```

### Example 2: Simple Online Event
**User says:** "How do I send data between clients?"
**Code:**
```lua
-- Define event
local ev = ac.OnlineEvent({v = ac.StructItem.float()}, function(s, m) ac.log(m.v) end)
-- Broadcast
ev({v = 42})
```

### Example 3: Drawing Text
**User says:** "Draw text on the screen."
**Code:**
```lua
display.text{ text = "LEVEL", pos = vec2(10, 10), letter = vec2(20, 30) }
```

## Troubleshooting

### Error: "Function not found" or "nil value"
**Cause:** Using functions from a different script type (e.g., using `ac.getCar()` in a pure Lua app without `allow_access`) or using internal APIs.
**Solution:**
1. Check `references/Workspace_Rules.md` to ensure you are in the correct file type.
2. Verify the function exists in the `references/api/*.lib.lua` file for your script type.
3. Do not use internal APIs (starting with `_`).

### Error: "Performance drop / Stuttering"
**Cause:** Creating garbage or expensive calls in `update()`.
**Solution:**
1. Move `vec2`/`rgb` creation outside of loops if possible.
2. Use `math.applyLag` instead of complex smoothing tables.
3. Use `---@ext` optimizations where applicable.
