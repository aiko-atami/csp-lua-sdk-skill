# CSP Lua Quick Reference

This document provides quick access to CSP-specific functions, patterns, and API usage.

## 1. Simulation & Car State

### Simulation State
```lua
local sim = ac.getSim()
local speed = sim.speed -- km/h
local gear = sim.gear
local rpm = sim.rpm
local gameTime = sim.time -- game time in seconds
```

### Car Data
```lua
-- Get player car (index 0) or specific car
local car = ac.getCar(0)

-- Callbacks
ac.onLapCompleted(0, function(carIndex, lapTime)
  ac.log("Lap completed by car " .. carIndex .. " in " .. lapTime .. "ms")
end)
```

-- Car properties
local speed = car.speedKmh
local position = car.position -- vec3
local acceleration = car.acceleration -- vec3
local rpm = car.rpm
local gear = car.gear
local gasInput = car.gas -- 0-1
local brakeInput = car.brake -- 0-1
```

### Physics (Car Scripts)
```lua
-- Access wheels in car-specific scripts
local wheelFL = physics.wheel[0] 
local tyrePressure = wheelFL.tyrePressure
local tyreLoad = wheelFL.tyreLoad
local slipAngle = wheelFL.slipAngle
```

---

## 2. Interaction & Input

### Input
```lua
-- Keyboard (using ui.Key enum)
if ac.isKeyPressed(ui.Key.Space) then ... end

-- Mouse (in apps)
if ui.mouseClicked() then
  local pos = ui.mousePos()
end
```

### UI Widgets (ImGui)
```lua
-- Input fields
local text, changed = ui.inputText('Label', textValue)

-- Sliders
local value, changed = ui.slider('##slider', sliderValue, 0, 100)

-- Checkbox
local checked, changed = ui.checkbox('Option', boolValue)

-- Combo box
if ui.beginCombo('Combo', currentItem) then
  for i, item in ipairs(items) do
    if ui.selectable(item, currentIndex == i) then
      currentIndex = i
    end
  end
  ui.endCombo()
end

-- UI Transparency Fix
ui.beginPremultipliedAlphaTexture()
ui.image(myTexture, vec2(100, 100)) -- Fixes dark edges in semi-transparent areas
ui.endPremultipliedAlphaTexture()

-- Premium Typography (DirectWrite)
local myFont = ui.DWriteFont('Inter', 'extension/fonts'):weight(ui.DWriteFont.Weight.Bold)
ui.pushFont(myFont)
ui.dwriteText('Stylish Text', 24)
ui.popFont()
```

---

## 3. Rendering & Debug

### 3D Debug Drawing
```lua
function script.draw3D()
  render.debugLine(vec3(0, 0, 0), vec3(10, 0, 0), rgbm(1, 0, 0, 1))
  render.debugSphere(vec3(0, 1, 0), 0.5, rgbm(0, 1, 0, 1))
  render.debugText(vec3(0, 2, 0), 'Label', rgbm(1, 1, 1, 1))
  render.debugArrow(vec3(0, 0, 0), vec3(0, 5, 0), 0.1, rgbm(0, 0, 1, 1))
end
```

---

## 4. Utilities & Math

### Vector Operations (vec3)
```lua
local v1 = vec3(1, 2, 3)
local normalized = v1:normalize()
local length = v1:length()
local distance = v1:distance(v2)
local dot = v1:dot(v2)
local cross = v1:cross(v2)
local interpolated = v1:lerp(v2, 0.5)
```

### Math Utilities (CSP Extensions)
```lua
local clamped = math.clamp(value, min, max)
local lerped = math.lerp(a, b, t)
local sign = math.sign(value) -- -1, 0, or 1
local remapped = math.remap(value, oldMin, oldMax, newMin, newMax)
-- Smooth targeting
current = math.applyLag(current, target, smoothing, dt)
```

### Color (rgbm)
```lua
-- r, g, b, multiplier
local color = rgbm(1, 0, 0, 1)
local white = rgbm.colors.white
```

---

## 5. System & Web

### File Operations
```lua
local content = ac.readFile('path/to/file.txt')
local exists = ac.fileExists('path/to/file.txt')
local files = ac.scanDir('path/to/dir')
```

### Web Requests
```lua
local web = require('lib_web')

web.get('https://api.example.com/data', function(err, response)
  if not err then ac.log(response.body) end
end)
```

### Networking (OnlineEvent)
```lua
local myEvent = ac.OnlineEvent({
  val = ac.StructItem.int32()
}, function(sender, data)
  ac.log("From: " .. (sender and sender.index or "server") .. ", Val: " .. data.val)
end)

-- Send to everyone (rate limit: 200ms)
myEvent({ val = 42 })
```

### Persistent Storage
```lua
-- Persists between sessions for Apps
ac.storage.myValue = 123
local value = ac.storage.myValue or 0
```

### Audio & Environment
-- Play UI sound
ui.playSound('UI_Button_Click')

-- Weather Control
ac.setTrackCondition('rain', 0.5)
ac.setWeatherIntensity(0.8)

-- 3D Audio
local sound = ac.AudioEvent('event:/cars/my_car/horn', true)
sound:setPosition(car.position)
sound:play()
```

---

## 6. Optimization Tips

1. **Cache SDK Objects**: Avoid calling `ac.getSim()` or `ac.getCar()` every frame. Cache them in `script.update` or local scope.
2. **Object Pooling**: Do not create new `vec3()` or `rgbm()` in loops. Use `:set()` or reuse objects.
3. **Delta Time**: Always multiply movements by `dt` in `script.update`.
4. **Frequency**: Use `setInterval` for things that don't need to run at 60+ FPS (e.g., checking web APIs).
5. **Preprocessor**: Always use `---@ext` for performance-critical scripts to enable enum inlining and const folding.

---

## 7. Troubleshooting

```lua
-- Logging levels
ac.log('Info')
ac.warn('Warning')
ac.error('Error')

-- Table Dump Pattern
function dump(t, indent)
  indent = indent or ''
  for k, v in pairs(t) do
    if type(v) == 'table' then
      ac.log(indent .. k .. ':')
      dump(v, indent .. '  ')
    else
      ac.log(indent .. k .. ': ' .. tostring(v))
    end
  end
end
```
