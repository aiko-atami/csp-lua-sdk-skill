# CSP Lua SDK Examples

Condensed, high-impact patterns from official examples.

## 1. Interactive Car Displays
Use `display.interactiveMesh` for clickable elements and `ui.draw*` for rendering on textures.

```lua
-- Define clickable meshes and hit-test points
local dash = display.interactiveMesh{ 
  mesh = '{ geo_dash, BTN_1, BTN_2 }', 
  resolution = vec2(512, 512) 
}

-- Check if a specific area was clicked
local btn1 = dash.pressed(vec2(0, 0), vec2(0.5, 0.5), vec3(0.2, 0.8, 0.6), 0.05)

function script.update(dt)
  if btn1() then ac.log("Button 1 pressed") end
  
  -- Render to texture
  ui.beginRotation()
  ui.drawRectFilled(vec2(0, 0), vec2(100, 50), rgbm(0, 1, 0, 1))
  ui.endPivotRotation(90, vec2(50, 25))
end

-- UI Animation Example
local smoothY = ui.SmoothInterpolation(0, 5) -- initial 0, weight 5
function script.windowMain(dt)
  local targetY = ui.mouseClicked() and 100 or 0
  local currentY = smoothY(targetY, dt)
  ui.setCursorPosX(currentY)
  ui.button("Sliding Button")
end
```

## 2. Advanced Physics & Car Data
Accessing internal state and overriding systems like Turbo.

```lua
local data = ac.accessCarPhysics() -- Fast access to common physics
local engineINI = ac.INIConfig.carData(car.index, 'engine.ini')
local maxBoost = engineINI:get('TURBO_0', 'MAX_BOOST', 1)

function script.update(dt)
  -- Custom boost logic
  local targetBoost = math.lerp(0, maxBoost, data.gas)
  ac.overrideTurboBoost(0, targetBoost)
  
  -- Smooth interpolation
  local rpmFiltered = math.applyLag(prevRpm, car.rpm, 0.8, dt)
  ac.debug("Filtered RPM", rpmFiltered)
end
```

## 3. Online Events & Synchronization
Broadcasting data and creating admin tools.

```lua
-- Define a typed event (syncs between clients)
local teleportEvent = ac.OnlineEvent({
  targetID = ac.StructItem.int32(),
  pos = ac.StructItem.vec3()
}, function(sender, msg)
  if msg.targetID == ac.getCar(0).sessionID then
    physics.setCarPosition(0, msg.pos, vec3(0, 0, 1))
  end
end)

-- Register a tool in the Online Chat (lightbulb icon)
ui.registerOnlineExtra(ui.Icons.FastForward, 'Teleport', nil, function()
  if ui.button("Teleport to Start") then
    teleportEvent({ targetID = 0, pos = vec3(0, 0, 0) })
  end
end, nil, ui.OnlineExtraFlags.Admin)
```

## 4. Optimization Patterns
Essential for performance-critical scripts (Physics/Display).

```lua
-- Cache objects to avoid GC pressure
local v1 = vec3()
local skipFrames = 0

function script.update(dt)
  -- Skip frames for UI that doesn't need 60Hz
  skipFrames = skipFrames > 0 and skipFrames - 1 or 2
  if skipFrames > 0 then 
    ac.skipFrame() 
    return 
  end

  -- Reuse vector
  v1:set(car.position):add(car.velocity)
end
```
