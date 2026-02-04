---@meta
---@diagnostic disable: lowercase-global
--[[ csp.lua ]]
--[[ csp.lua ]]

---@class ac.HashSpaceItem
local HashSpaceItem = class('HashSpaceItem')

---Returns ID associated with an item.
---@return integer
function HashSpaceItem:id() end

---Moves an item to a position.
---@param pos vec3
function HashSpaceItem:update(pos) end

---Removes item from its space.
function HashSpaceItem:dispose() end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@param cellSize number @Should be about twice as large as your largest entity.
---@return ac.HashSpace
function ac.HashSpace(cellSize) end

---Simple structure meant to speed up collision detection by arranging items in a grid using hashmap. Cells are arranged horizontally.
---@class ac.HashSpace
local _ac_HashSpace = nil

---Iterates items around given position.
---@generic T
---@param pos vec3
---@param callback fun(id: integer, callbackData: T)
---@param callbackData T?
function _ac_HashSpace:iterate(pos, callback, callbackData) end

---Checks if there are any items around given position.
---@param pos vec3
---@return boolean
function _ac_HashSpace:anyAround(pos) end

---Count amount of items around given position.
---@param pos vec3
---@return integer
function _ac_HashSpace:count(pos) end

---Returns raw pointers for given position for manual iteration. Be careful!
---@param pos vec3
---@return any, any
function _ac_HashSpace:rawPointers(pos) end

---Adds a new dynamic item to the grid. Each item gets a new ID.
---@return ac.HashSpaceItem
function _ac_HashSpace:add() end

---Adds a fixed item to the grid, with predetermined ID. Avoid mixing dynamic and fixed items in the same grid.
---@param id integer
---@param pos vec3
function _ac_HashSpace:addFixed(id, pos) end
--[[ lib_numlut.lua ]]

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lut = ac.Lut([[
--- -100 |  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -90 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---  -20 |  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04
---]], { 2 })
---assert(lut:calculate(-95)[1] == 0.5)
---```
---@class ac.Lut
---@explicit-contructor ac.Lut
local _ac_Lut = nil

---Interpolate for a given input, return a newly created table. Note: consider using `:calculateTo()` instead to avoid re-creating tables, it would work much more efficiently.
---@param input number
---@return number[]
function _ac_Lut:calculate(input) end

---Interpolate for a given input, write result to a given table.
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function _ac_Lut:calculateTo(output, input) end
--[[ lib_numlut_jit.lua ]]

---Meant to quickly interpolate between tables of values, some of them could be colors set in HSV. Example:
---```
---local lutJit = ac.LutJit:new{ data = {
---  { input = -100, output = {  0.00,   350,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -90, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  { input =  -20, output = {  1.00,    10,  0.37,  1.00,  3.00,  1.00,  1.00,  3.60,500.00,  0.04 } },
---  }, hsvRows = { 2 }}
---assert(lutJit:calculate(-95)[1] == 1)
---```
---Obsolete. Use `ac.Lut` instead, with faster C++ implementation.
---@class ac.LutJit
---@deprecated
ac.LutJit = {}

---Creates new ac.LuaJit instance. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param data any
---@param hsvRows integer[] @ 1-based indices of columns (not rows) storing HSV values in them.
---@return table
function ac.LutJit:new(o, data, hsvRows) end

---Computes a new value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param input number
---@return number[]
function ac.LutJit:calculate(input) end

---Computes a new value to a preexisting HSV value. Deprecated, use `ac.Lut` instead.
---@deprecated
---@param output number[]
---@param input number
---@return number[] @Same table as was provided in arguments.
function ac.LutJit:calculateTo(output, input) end

---Loads a ZIP file from a given URL, unpacks first KN5 from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to load
---KN5 in the scene.
---
---If there is a VAO patch in a ZIP file, it will be extracted next to KN5.
---
---Note: only valid KN5 files and VAO patches are supported. Heavy caching is applied: if model was
---downloaded once, it would not be re-downloaded (unlike with remote textures where proper HTTP caching
---rules apply). If model was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `web.loadRemoteAssets()` instead.
---@deprecated
---@param source string|{url: string, headers: table<string, string>} @URL to download, or, since 0.2.10, a table.
---@param callback fun(err: string, filename: string)
function web.loadRemoteModel(source, callback) end

---Loads a ZIP file from a given URL, unpacks first KsAnim from it to a cache folder and returns
---its filename through a callback. If file is already in cache storage, doesn’t do anything and
---simply returns filename to it. After callback is called, that filename could be used to animate
---objects in the scene. If animation was not accessed for a couple of weeks, it’ll be removed.
---
---If you need to download several entities and do something afterwards, it might help to use some
---promise Lua library.
---
---Use `web.loadRemoteAssets()` instead.
---@deprecated
---@param source string|{url: string, headers: table<string, string>} @URL to download, or, since 0.2.10, a table.
---@param callback fun(err: string, filename: string)
function web.loadRemoteAnimation(source, callback) end

---Loads a ZIP file from a given URL, unpacks assets from it to a cache folder and returns
---path to the folder in a callback. If files are already in cache storage, doesn’t do anything and
---simply returns the path. After callback is called, you can use path to the folder to get full paths to those assets.
---If assets are not accessed for a couple of weeks, they’ll be removed.
---
---Since 0.2.10, scripts with I/O access are allowed to extract all types of files using this function.
---@param source string|{url: string, headers: table<string, string>, crucial: string?} @URL to download, or, since 0.2.10, a table. Field `crucial` acts similar to `crucial` of `io.extractFromZipAsync()`.
---@param callback fun(err: string, folder: string)
function web.loadRemoteAssets(source, callback) end

---Resolve hostname, return IPv4 via a callback.
---@param url string
---@param callback fun(err: string?, response: string?)
function web.resolveDNS(url, callback) end

---@param key string
---@return string
function web.encryptKey(key) end
--[[ csp.lua ]]

---GIF player can be used to display animated GIFs. Also supports regular and animated WEBP images.
---@param source string|{width: number, height: number, decompress: boolean?} @URL, filename or binary data.
---@param simTime boolean? @Pass `true` to use simulation time (pause GIF when AC is paused), or `false` to use UI time. By default, `true` for car and track scripts.
---@return ui.GIFPlayer
function ui.GIFPlayer(source, simTime) end

---GIF player can be used to display animated GIFs. Also supports regular and animated WEBP images.
---@class ui.GIFPlayer
---@field keepRunning boolean @By default GIFs stop playing if they are not actively used in rendering. If you need them to keep running in background, set this property to `true`.
local _ui_GIFPlayer = nil

---Get GIF resolution. If GIF is not yet loaded, returns zeroes.
---@return vec2 @Width and height in pixels.
function _ui_GIFPlayer:resolution() end

---Push new bitmap data to a live-updating image. Doesn’t do anything if data is wrong size, or if player is not created for this mode.
---@param data binary
---@return boolean @Returns `false` if data doesn’t fit.
function _ui_GIFPlayer:push(data) end

---Rewinds GIF back to beginning.
---
---Note: since 0.3.0.144, GIF players using the same source share their internal state, decoder and textures to save on RAM and
---CPU usage. Using this method on a shared player (if it’s played a bit) will disconnect the player and make it its own thing.
---@return ui.GIFPlayer @Returns itself for chaining several methods together.
function _ui_GIFPlayer:rewind() end

---Pauses playback. Added in 0.3.0.144.
---@return ui.GIFPlayer @Returns itself for chaining several methods together.
function _ui_GIFPlayer:pause() end

---Resumes playback. Added in 0.3.0.144.
---@return ui.GIFPlayer @Returns itself for chaining several methods together.
function _ui_GIFPlayer:resume() end

---Checks if GIF is loaded and ready to be drawn.
---@return boolean
function _ui_GIFPlayer:ready() end

---Links playback rate to simulation speed: pauses when game or replay are paused, slows down with replay slow motion,
---speeds up with replay fast forwarding.
---@param value boolean? @Set to `true` to link playback rate.
---@return ui.GIFPlayer @Returns itself for chaining several methods together.
function _ui_GIFPlayer:linkToSimulationSpeed(value) end

---Returns `false` if GIF decoding has failed.
---@return boolean
function _ui_GIFPlayer:valid() end
--[[ lib_ui_shared.lua ]]

---@param handle integer @Shared texture handle. Can be either a `D3D11_RESOURCE_MISC_SHARED` handle or a handle from `:sharedHandle()` of an extra canvas.
---@param ntMode nil|integer|boolean? @Set to `true` if the handle is NT handle. Alternatively, set to an integer with source process ID. Default value: `false`. Note: for NT handles it’s better to use the named textures and pass it as a string instead (with the overload).
---@return ui.SharedTexture
---@overload fun(name: string) @Overload using name of a shared NT texture, works a lot better.
function ui.SharedTexture(handle, ntMode) end

---A wrapper for accessing textures shared by other Lua scripts or even by other applications. For the latter, textures need to have `D3D11_RESOURCE_MISC_SHARED` flag and be on the same GPU.
---@class ui.SharedTexture
local _ui_SharedTexture = nil

---Dispose texture and release its view. Call this method if remote texture is being destroyed.
function _ui_SharedTexture:dispose() end

---Sets texture name for debugging. Textures with set name appear in Lua Debug App, allowing to monitor their state.
---@param name string? @Name to display texture as. If set to `nil` or `false`, name will be reset and texture will be hidden.
---@return self @Returns itself for chaining several methods together.
function _ui_SharedTexture:setName(name) end

---Get texture handle used for creating a texture. If texture has failed to load, returns 0. If texture is loaded by name and loaded properly, returns 1.
---@return integer
function _ui_SharedTexture:handle() end

---Get texture resolution. If texture has failed to load, returns zeroes.
---@return vec2 @Width and height in pixels.
function _ui_SharedTexture:resolution() end

---Returns `false` if access to a shared texture has failed.
---@return boolean
function _ui_SharedTexture:valid() end

---@alias ac.DebugCollectMode
---| `ac.DebugCollectMode.Average` @Value: 0.
---| `ac.DebugCollectMode.Minimum` @Value: 1.
---| `ac.DebugCollectMode.Maximum` @Value: 2.
ac.DebugCollectMode = {
  Average = 0, ---@type ac.DebugCollectMode #Value: 0.
  Minimum = 1, ---@type ac.DebugCollectMode #Value: 1.
  Maximum = 2, ---@type ac.DebugCollectMode #Value: 2.
}

---@alias ac.INIFormat
---| `ac.INIFormat.Default` @AC format: no quotes, “[” in value begins a new section, etc.
---| `ac.INIFormat.DefaultAcd` @AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
---| `ac.INIFormat.Extended` @Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
---| `ac.INIFormat.ExtendedIncludes` @Same as CSP, but also with support for INIpp expressions and includes.
ac.INIFormat = {
  Default = 0, ---@type ac.INIFormat #AC format: no quotes, “[” in value begins a new section, etc.
  DefaultAcd = 1, ---@type ac.INIFormat #AC format, but also with support for reading files from `data.acd` (makes difference only for `ac.INIConfig.load()`).
  Extended = 10, ---@type ac.INIFormat #Quotes are allowed, comma-separated value turns into multiple values (for vectors and lists), repeated keys replace previous values.
  ExtendedIncludes = 11, ---@type ac.INIFormat #Same as CSP, but also with support for INIpp expressions and includes.
}

---@alias ac.LightType
---| `ac.LightType.Regular` @Value: 1.
---| `ac.LightType.Line` @Value: 2.
ac.LightType = {
  Regular = 1, ---@type ac.LightType #Value: 1.
  Line = 2, ---@type ac.LightType #Value: 2.
}

---@alias ac.IncludeType
---| `ac.IncludeType.None` @Value: 0.
---| `ac.IncludeType.Car` @Value: 1.
---| `ac.IncludeType.Track` @Value: 2.
ac.IncludeType = {
  None = 0, ---@type ac.IncludeType #Value: 0.
  Car = 1, ---@type ac.IncludeType #Value: 1.
  Track = 2, ---@type ac.IncludeType #Value: 2.
}

---@alias ac.FogAlgorithm
---| `ac.FogAlgorithm.Original` @Value: 0.
---| `ac.FogAlgorithm.New` @Value: 1.
ac.FogAlgorithm = {
  Original = 0, ---@type ac.FogAlgorithm #Value: 0.
  New = 1, ---@type ac.FogAlgorithm #Value: 1.
}

---@alias ac.SurfaceType
---| `ac.SurfaceType.Grass` @Value: 0.
---| `ac.SurfaceType.Dirt` @Value: 1.
---| `ac.SurfaceType.Snow` @-Could also be ice.
---| `ac.SurfaceType.Default` @Value: 255.
ac.SurfaceType = {
  Grass = 0, ---@type ac.SurfaceType #Value: 0.
  Dirt = 1, ---@type ac.SurfaceType #Value: 1.
  Snow = 2, ---@type ac.SurfaceType #-Could also be ice.
  Default = 255, ---@type ac.SurfaceType #Value: 255.
}

---@alias ac.SurfaceExtendedType
---| `ac.SurfaceExtendedType.Base` @Value: 0.
---| `ac.SurfaceExtendedType.ExtraTurf` @Value: 1.
---| `ac.SurfaceExtendedType.Grass` @Value: 2.
---| `ac.SurfaceExtendedType.Gravel` @Value: 3.
---| `ac.SurfaceExtendedType.Kerb` @Value: 4.
---| `ac.SurfaceExtendedType.Old` @Value: 5.
---| `ac.SurfaceExtendedType.Sand` @Value: 6.
---| `ac.SurfaceExtendedType.Ice` @Value: 7.
---| `ac.SurfaceExtendedType.Snow` @Value: 8.
ac.SurfaceExtendedType = {
  Base = 0, ---@type ac.SurfaceExtendedType #Value: 0.
  ExtraTurf = 1, ---@type ac.SurfaceExtendedType #Value: 1.
  Grass = 2, ---@type ac.SurfaceExtendedType #Value: 2.
  Gravel = 3, ---@type ac.SurfaceExtendedType #Value: 3.
  Kerb = 4, ---@type ac.SurfaceExtendedType #Value: 4.
  Old = 5, ---@type ac.SurfaceExtendedType #Value: 5.
  Sand = 6, ---@type ac.SurfaceExtendedType #Value: 6.
  Ice = 7, ---@type ac.SurfaceExtendedType #Value: 7.
  Snow = 8, ---@type ac.SurfaceExtendedType #Value: 8.
}

---@alias ac.ShadowsState
---| `ac.ShadowsState.Off` @Value: 0.
---| `ac.ShadowsState.On` @Value: 1.
---| `ac.ShadowsState.EverythingShadowed` @Value: 2.
ac.ShadowsState = {
  Off = 0, ---@type ac.ShadowsState #Value: 0.
  On = 1, ---@type ac.ShadowsState #Value: 1.
  EverythingShadowed = 2, ---@type ac.ShadowsState #Value: 2.
}

---@alias ac.TextureState
---| `ac.TextureState.Empty` @Value: 0.
---| `ac.TextureState.Loading` @Value: 1.
---| `ac.TextureState.Failed` @Value: 2.
---| `ac.TextureState.Ready` @Value: 3.
ac.TextureState = {
  Empty = 0, ---@type ac.TextureState #Value: 0.
  Loading = 1, ---@type ac.TextureState #Value: 1.
  Failed = 2, ---@type ac.TextureState #Value: 2.
  Ready = 3, ---@type ac.TextureState #Value: 3.
}

---@alias ac.CameraMode
---| `ac.CameraMode.Cockpit` @First person view.
---| `ac.CameraMode.Car` @F6 camera.
---| `ac.CameraMode.Drivable` @Chase/bonnet/bumper/dash cameras.
---| `ac.CameraMode.Track` @Replay camera.
---| `ac.CameraMode.Helicopter` @Moving replay camera.
---| `ac.CameraMode.OnBoardFree` @F5 camera.
---| `ac.CameraMode.Free` @F7 camera.
---| `ac.CameraMode.Deprecated` @Value: 7.
---| `ac.CameraMode.ImageGeneratorCamera` @Value: 8.
---| `ac.CameraMode.Start` @Starting camera.
ac.CameraMode = {
  Cockpit = 0, ---@type ac.CameraMode #First person view.
  Car = 1, ---@type ac.CameraMode #F6 camera.
  Drivable = 2, ---@type ac.CameraMode #Chase/bonnet/bumper/dash cameras.
  Track = 3, ---@type ac.CameraMode #Replay camera.
  Helicopter = 4, ---@type ac.CameraMode #Moving replay camera.
  OnBoardFree = 5, ---@type ac.CameraMode #F5 camera.
  Free = 6, ---@type ac.CameraMode #F7 camera.
  Deprecated = 7, ---@type ac.CameraMode #Value: 7.
  ImageGeneratorCamera = 8, ---@type ac.CameraMode #Value: 8.
  Start = 9, ---@type ac.CameraMode #Starting camera.
}

---@alias ac.DrivableCamera
---| `ac.DrivableCamera.Chase` @Value: 0.
---| `ac.DrivableCamera.Chase2` @Value: 1.
---| `ac.DrivableCamera.Bonnet` @Value: 2.
---| `ac.DrivableCamera.Bumper` @Value: 3.
---| `ac.DrivableCamera.Dash` @Value: 4.
ac.DrivableCamera = {
  Chase = 0, ---@type ac.DrivableCamera #Value: 0.
  Chase2 = 1, ---@type ac.DrivableCamera #Value: 1.
  Bonnet = 2, ---@type ac.DrivableCamera #Value: 2.
  Bumper = 3, ---@type ac.DrivableCamera #Value: 3.
  Dash = 4, ---@type ac.DrivableCamera #Value: 4.
}

---Wheel index (from 0 to 3) or a special value for wheel mask.
---@alias ac.Wheel
---| `ac.Wheel.FrontLeft` @Value: 0.
---| `ac.Wheel.FrontRight` @Value: 1.
---| `ac.Wheel.RearLeft` @Value: 2.
---| `ac.Wheel.RearRight` @Value: 3.
---| `ac.Wheel.Front` @Value: 12.
---| `ac.Wheel.Rear` @Value: 48.
---| `ac.Wheel.Left` @Value: 20.
---| `ac.Wheel.Right` @Value: 40.
---| `ac.Wheel.All` @Value: 60.
ac.Wheel = {
  FrontLeft = 0, ---@type ac.Wheel #Value: 0.
  FrontRight = 1, ---@type ac.Wheel #Value: 1.
  RearLeft = 2, ---@type ac.Wheel #Value: 2.
  RearRight = 3, ---@type ac.Wheel #Value: 3.
  Front = 12, ---@type ac.Wheel #Value: 12.
  Rear = 48, ---@type ac.Wheel #Value: 48.
  Left = 20, ---@type ac.Wheel #Value: 20.
  Right = 40, ---@type ac.Wheel #Value: 40.
  All = 60, ---@type ac.Wheel #Value: 60.
}

---@alias ac.MirrorPieceRole
---| `ac.MirrorPieceRole.None` @Value: 0.
---| `ac.MirrorPieceRole.Top` @Value: 1.
---| `ac.MirrorPieceRole.Left` @Value: 2.
---| `ac.MirrorPieceRole.Right` @Value: 4.
ac.MirrorPieceRole = {
  None = 0, ---@type ac.MirrorPieceRole #Value: 0.
  Top = 1, ---@type ac.MirrorPieceRole #Value: 1.
  Left = 2, ---@type ac.MirrorPieceRole #Value: 2.
  Right = 4, ---@type ac.MirrorPieceRole #Value: 4.
}

---@alias ac.MirrorPieceFlip
---| `ac.MirrorPieceFlip.None` @Value: 0.
---| `ac.MirrorPieceFlip.Horizontal` @Value: 1.
---| `ac.MirrorPieceFlip.Vertical` @Value: 2.
---| `ac.MirrorPieceFlip.Both` @Value: 3.
ac.MirrorPieceFlip = {
  None = 0, ---@type ac.MirrorPieceFlip #Value: 0.
  Horizontal = 1, ---@type ac.MirrorPieceFlip #Value: 1.
  Vertical = 2, ---@type ac.MirrorPieceFlip #Value: 2.
  Both = 3, ---@type ac.MirrorPieceFlip #Value: 3.
}

---@alias ac.MirrorMonitorType
---| `ac.MirrorMonitorType.TN` @Oldschool displays with a lot of color distortion.
---| `ac.MirrorMonitorType.VA` @Medium tier, less color distortion.
---| `ac.MirrorMonitorType.IPS` @Almost no color distortion.
ac.MirrorMonitorType = {
  TN = 0, ---@type ac.MirrorMonitorType #Oldschool displays with a lot of color distortion.
  VA = 2, ---@type ac.MirrorMonitorType #Medium tier, less color distortion.
  IPS = 1, ---@type ac.MirrorMonitorType #Almost no color distortion.
}

---@alias ac.WeatherType
---| `ac.WeatherType.LightThunderstorm` @Value: 0.
---| `ac.WeatherType.Thunderstorm` @Value: 1.
---| `ac.WeatherType.HeavyThunderstorm` @Value: 2.
---| `ac.WeatherType.LightDrizzle` @Value: 3.
---| `ac.WeatherType.Drizzle` @Value: 4.
---| `ac.WeatherType.HeavyDrizzle` @Value: 5.
---| `ac.WeatherType.LightRain` @Value: 6.
---| `ac.WeatherType.Rain` @Value: 7.
---| `ac.WeatherType.HeavyRain` @Value: 8.
---| `ac.WeatherType.LightSnow` @Value: 9.
---| `ac.WeatherType.Snow` @Value: 10.
---| `ac.WeatherType.HeavySnow` @Value: 11.
---| `ac.WeatherType.LightSleet` @Value: 12.
---| `ac.WeatherType.Sleet` @Value: 13.
---| `ac.WeatherType.HeavySleet` @Value: 14.
---| `ac.WeatherType.Clear` @Value: 15.
---| `ac.WeatherType.FewClouds` @Value: 16.
---| `ac.WeatherType.ScatteredClouds` @Value: 17.
---| `ac.WeatherType.BrokenClouds` @Value: 18.
---| `ac.WeatherType.OvercastClouds` @Value: 19.
---| `ac.WeatherType.Fog` @Value: 20.
---| `ac.WeatherType.Mist` @Value: 21.
---| `ac.WeatherType.Smoke` @Value: 22.
---| `ac.WeatherType.Haze` @Value: 23.
---| `ac.WeatherType.Sand` @Value: 24.
---| `ac.WeatherType.Dust` @Value: 25.
---| `ac.WeatherType.Squalls` @Value: 26.
---| `ac.WeatherType.Tornado` @Value: 27.
---| `ac.WeatherType.Hurricane` @Value: 28.
---| `ac.WeatherType.Cold` @Value: 29.
---| `ac.WeatherType.Hot` @Value: 30.
---| `ac.WeatherType.Windy` @Value: 31.
---| `ac.WeatherType.Hail` @Value: 32.
ac.WeatherType = {
  LightThunderstorm = 0, ---@type ac.WeatherType #Value: 0.
  Thunderstorm = 1, ---@type ac.WeatherType #Value: 1.
  HeavyThunderstorm = 2, ---@type ac.WeatherType #Value: 2.
  LightDrizzle = 3, ---@type ac.WeatherType #Value: 3.
  Drizzle = 4, ---@type ac.WeatherType #Value: 4.
  HeavyDrizzle = 5, ---@type ac.WeatherType #Value: 5.
  LightRain = 6, ---@type ac.WeatherType #Value: 6.
  Rain = 7, ---@type ac.WeatherType #Value: 7.
  HeavyRain = 8, ---@type ac.WeatherType #Value: 8.
  LightSnow = 9, ---@type ac.WeatherType #Value: 9.
  Snow = 10, ---@type ac.WeatherType #Value: 10.
  HeavySnow = 11, ---@type ac.WeatherType #Value: 11.
  LightSleet = 12, ---@type ac.WeatherType #Value: 12.
  Sleet = 13, ---@type ac.WeatherType #Value: 13.
  HeavySleet = 14, ---@type ac.WeatherType #Value: 14.
  Clear = 15, ---@type ac.WeatherType #Value: 15.
  FewClouds = 16, ---@type ac.WeatherType #Value: 16.
  ScatteredClouds = 17, ---@type ac.WeatherType #Value: 17.
  BrokenClouds = 18, ---@type ac.WeatherType #Value: 18.
  OvercastClouds = 19, ---@type ac.WeatherType #Value: 19.
  Fog = 20, ---@type ac.WeatherType #Value: 20.
  Mist = 21, ---@type ac.WeatherType #Value: 21.
  Smoke = 22, ---@type ac.WeatherType #Value: 22.
  Haze = 23, ---@type ac.WeatherType #Value: 23.
  Sand = 24, ---@type ac.WeatherType #Value: 24.
  Dust = 25, ---@type ac.WeatherType #Value: 25.
  Squalls = 26, ---@type ac.WeatherType #Value: 26.
  Tornado = 27, ---@type ac.WeatherType #Value: 27.
  Hurricane = 28, ---@type ac.WeatherType #Value: 28.
  Cold = 29, ---@type ac.WeatherType #Value: 29.
  Hot = 30, ---@type ac.WeatherType #Value: 30.
  Windy = 31, ---@type ac.WeatherType #Value: 31.
  Hail = 32, ---@type ac.WeatherType #Value: 32.
}

---@alias ac.TonemapFunction
---| `ac.TonemapFunction.Linear` @Simple linear mapping.
---| `ac.TonemapFunction.LinearClamped` @Linear mapping (LDR clamp).
---| `ac.TonemapFunction.Sensitometric` @Simple simulation of response of film, CCD, etc., recommended.
---| `ac.TonemapFunction.Reinhard` @Reinhard.
---| `ac.TonemapFunction.ReinhardLum` @Saturation retention type Reinhard tone map function.
---| `ac.TonemapFunction.Log` @Tone map function for the logarithmic space.
---| `ac.TonemapFunction.LogLum` @Saturation retention type logarithmic space tone map function.
---| `ac.TonemapFunction.ACES` @ACES.
---| `ac.TonemapFunction.Uchimura` @GT-like by Uchimura.
---| `ac.TonemapFunction.RomBinDaHouse` @Tonemapping by RomBinDaHouse.
---| `ac.TonemapFunction.Lottes` @Tonemapping by Lottes.
---| `ac.TonemapFunction.Uncharted` @Tonemapping used in Uncharted.
---| `ac.TonemapFunction.Unreal` @Tonemapping commonly used in UE.
---| `ac.TonemapFunction.Filmic` @Filmic tonemapping.
---| `ac.TonemapFunction.ReinhardWp` @White-preserving Reinhard.
---| `ac.TonemapFunction.Juicy` @Experimental, better preserving saturation.
---| `ac.TonemapFunction.AgX` @Might be the best one, based on https://iolite-engine.com/blog_posts/minimal_agx_implementation.
ac.TonemapFunction = {
  Linear = 0, ---@type ac.TonemapFunction #Simple linear mapping.
  LinearClamped = 1, ---@type ac.TonemapFunction #Linear mapping (LDR clamp).
  Sensitometric = 2, ---@type ac.TonemapFunction #Simple simulation of response of film, CCD, etc., recommended.
  Reinhard = 3, ---@type ac.TonemapFunction #Reinhard.
  ReinhardLum = 4, ---@type ac.TonemapFunction #Saturation retention type Reinhard tone map function.
  Log = 5, ---@type ac.TonemapFunction #Tone map function for the logarithmic space.
  LogLum = 6, ---@type ac.TonemapFunction #Saturation retention type logarithmic space tone map function.
  ACES = 7, ---@type ac.TonemapFunction #ACES.
  Uchimura = 8, ---@type ac.TonemapFunction #GT-like by Uchimura.
  RomBinDaHouse = 9, ---@type ac.TonemapFunction #Tonemapping by RomBinDaHouse.
  Lottes = 10, ---@type ac.TonemapFunction #Tonemapping by Lottes.
  Uncharted = 11, ---@type ac.TonemapFunction #Tonemapping used in Uncharted.
  Unreal = 12, ---@type ac.TonemapFunction #Tonemapping commonly used in UE.
  Filmic = 13, ---@type ac.TonemapFunction #Filmic tonemapping.
  ReinhardWp = 14, ---@type ac.TonemapFunction #White-preserving Reinhard.
  Juicy = 15, ---@type ac.TonemapFunction #Experimental, better preserving saturation.
  AgX = 16, ---@type ac.TonemapFunction #Might be the best one, based on https://iolite-engine.com/blog_posts/minimal_agx_implementation.
}

---@alias ac.FolderID
---| `ac.FolderID.AppData` @…/AppData.
---| `ac.FolderID.Documents` @…/Documents.
---| `ac.FolderID.Root` @…/SteamApps/common/assettocorsa.
---| `ac.FolderID.Cfg` @…/Documents/Assetto Corsa/cfg.
---| `ac.FolderID.Logs` @…/Documents/Assetto Corsa/logs.
---| `ac.FolderID.Screenshots` @…/Documents/Assetto Corsa/screens.
---| `ac.FolderID.Replays` @…/Documents/Assetto Corsa/replay.
---| `ac.FolderID.ReplaysTemp` @…/Documents/Assetto Corsa/replay/temp.
---| `ac.FolderID.UserSetups` @…/Documents/Assetto Corsa/setups.
---| `ac.FolderID.PPFilters` @…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
---| `ac.FolderID.ContentCars` @…/SteamApps/common/assettocorsa/content/cars.
---| `ac.FolderID.ContentDrivers` @…/SteamApps/common/assettocorsa/content/drivers.
---| `ac.FolderID.ContentTracks` @…/SteamApps/common/assettocorsa/content/tracks.
---| `ac.FolderID.ExtRoot` @…/SteamApps/common/assettocorsa/extension.
---| `ac.FolderID.ExtCfgSys` @…/SteamApps/common/assettocorsa/extension/config.
---| `ac.FolderID.ExtCfgUser` @…/Documents/Assetto Corsa/cfg/extension.
---| `ac.FolderID.ExtTextures` @…/SteamApps/common/assettocorsa/extension/textures.
---| `ac.FolderID.ACApps` @…/SteamApps/common/assettocorsa/apps.
---| `ac.FolderID.ACAppsLua` @…/SteamApps/common/assettocorsa/apps/lua.
---| `ac.FolderID.ACAppsPython` @…/SteamApps/common/assettocorsa/apps/python.
---| `ac.FolderID.ExtCfgState` @…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
---| `ac.FolderID.ContentFonts` @…/SteamApps/common/assettocorsa/content/fonts.
---| `ac.FolderID.RaceResults` @…/Documents/Assetto Corsa/out.
---| `ac.FolderID.AppDataLocal` @…/AppData/Local.
---| `ac.FolderID.ExtFonts` @…/SteamApps/common/assettocorsa/extension/fonts.
---| `ac.FolderID.ACDocuments` @…/Documents/Assetto Corsa.
---| `ac.FolderID.ExtLua` @…/SteamApps/common/assettocorsa/extension/lua.
---| `ac.FolderID.ExtCache` @…/SteamApps/common/assettocorsa/cache.
---| `ac.FolderID.AppDataTemp` @…/AppData/Local/Temp.
---| `ac.FolderID.ExtInternal` @…/SteamApps/common/assettocorsa/extension/internal.
---| `ac.FolderID.ScriptOrigin` @Main script directory.
---| `ac.FolderID.ScriptConfig` @…/Documents/Assetto Corsa/cfg/extension/state/lua/<mode>/<script ID>.
---| `ac.FolderID.CurrentTrack` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>.
---| `ac.FolderID.CurrentTrackLayout` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>/<layout ID> (or the same as CurrentTrack if no layout is selected).
---| `ac.FolderID.CurrentTrackLayoutUI` @…/SteamApps/common/assettocorsa/content/tracks/<track ID>/ui/<layout ID> (or just …/ui if no layout is selected).
ac.FolderID = {
  AppData = 0, ---@type ac.FolderID #…/AppData.
  Documents = 1, ---@type ac.FolderID #…/Documents.
  Root = 4, ---@type ac.FolderID #…/SteamApps/common/assettocorsa.
  Cfg = 5, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg.
  Logs = 7, ---@type ac.FolderID #…/Documents/Assetto Corsa/logs.
  Screenshots = 8, ---@type ac.FolderID #…/Documents/Assetto Corsa/screens.
  Replays = 9, ---@type ac.FolderID #…/Documents/Assetto Corsa/replay.
  ReplaysTemp = 10, ---@type ac.FolderID #…/Documents/Assetto Corsa/replay/temp.
  UserSetups = 11, ---@type ac.FolderID #…/Documents/Assetto Corsa/setups.
  PPFilters = 12, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/system/cfg/ppfilters.
  ContentCars = 13, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/cars.
  ContentDrivers = 14, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/drivers.
  ContentTracks = 15, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks.
  ExtRoot = 16, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension.
  ExtCfgSys = 17, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/config.
  ExtCfgUser = 18, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension.
  ExtTextures = 21, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/textures.
  ACApps = 23, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps.
  ACAppsLua = 1029, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps/lua.
  ACAppsPython = 24, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/apps/python.
  ExtCfgState = 25, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension/state (changing configs there does not trigger any live reloads).
  ContentFonts = 26, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/fonts.
  RaceResults = 27, ---@type ac.FolderID #…/Documents/Assetto Corsa/out.
  AppDataLocal = 28, ---@type ac.FolderID #…/AppData/Local.
  ExtFonts = 29, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/fonts.
  ACDocuments = 31, ---@type ac.FolderID #…/Documents/Assetto Corsa.
  ExtLua = 32, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/lua.
  ExtCache = 33, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/cache.
  AppDataTemp = 34, ---@type ac.FolderID #…/AppData/Local/Temp.
  ExtInternal = 35, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/extension/internal.
  ScriptOrigin = 1024, ---@type ac.FolderID #Main script directory.
  ScriptConfig = 1025, ---@type ac.FolderID #…/Documents/Assetto Corsa/cfg/extension/state/lua/<mode>/<script ID>.
  CurrentTrack = 1026, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>.
  CurrentTrackLayout = 1027, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>/<layout ID> (or the same as CurrentTrack if no layout is selected).
  CurrentTrackLayoutUI = 1028, ---@type ac.FolderID #…/SteamApps/common/assettocorsa/content/tracks/<track ID>/ui/<layout ID> (or just …/ui if no layout is selected).
}

---@alias ac.HolidayType
---| `ac.HolidayType.None` @Value: 0.
---| `ac.HolidayType.Generic` @Value: 13.
---| `ac.HolidayType.NewYear` @Value: 1.
---| `ac.HolidayType.Christmas` @Value: 2.
---| `ac.HolidayType.VictoryDay` @Value: 3.
---| `ac.HolidayType.IndependenceDay` @Value: 4.
---| `ac.HolidayType.Halloween` @Value: 5.
---| `ac.HolidayType.JapanFestival` @Value: 6.
---| `ac.HolidayType.ChineseNewYear` @Value: 7.
---| `ac.HolidayType.EidAlAdha` @Value: 8.
---| `ac.HolidayType.GuyFawkesNight` @Value: 9.
---| `ac.HolidayType.StIstvanCelebration` @Value: 10.
---| `ac.HolidayType.CanadaDay` @Value: 11.
---| `ac.HolidayType.VictoriaDay` @Value: 12.
ac.HolidayType = {
  None = 0, ---@type ac.HolidayType #Value: 0.
  Generic = 13, ---@type ac.HolidayType #Value: 13.
  NewYear = 1, ---@type ac.HolidayType #Value: 1.
  Christmas = 2, ---@type ac.HolidayType #Value: 2.
  VictoryDay = 3, ---@type ac.HolidayType #Value: 3.
  IndependenceDay = 4, ---@type ac.HolidayType #Value: 4.
  Halloween = 5, ---@type ac.HolidayType #Value: 5.
  JapanFestival = 6, ---@type ac.HolidayType #Value: 6.
  ChineseNewYear = 7, ---@type ac.HolidayType #Value: 7.
  EidAlAdha = 8, ---@type ac.HolidayType #Value: 8.
  GuyFawkesNight = 9, ---@type ac.HolidayType #Value: 9.
  StIstvanCelebration = 10, ---@type ac.HolidayType #Value: 10.
  CanadaDay = 11, ---@type ac.HolidayType #Value: 11.
  VictoriaDay = 12, ---@type ac.HolidayType #Value: 12.
}

---@alias ac.SkyRegion
---| `ac.SkyRegion.None` @Value: 0.
---| `ac.SkyRegion.Sun` @Value: 1.
---| `ac.SkyRegion.Opposite` @Value: 2.
---| `ac.SkyRegion.All` @Value: 3.
ac.SkyRegion = {
  None = 0, ---@type ac.SkyRegion #Value: 0.
  Sun = 1, ---@type ac.SkyRegion #Value: 1.
  Opposite = 2, ---@type ac.SkyRegion #Value: 2.
  All = 3, ---@type ac.SkyRegion #Value: 3.
}

---@alias ac.SkyFeature
---| `ac.SkyFeature.Sun` @Value: 0.
---| `ac.SkyFeature.Moon` @Value: 1.
---| `ac.SkyFeature.Mercury` @Value: 101.
---| `ac.SkyFeature.Venus` @Value: 102.
---| `ac.SkyFeature.Mars` @Value: 103.
---| `ac.SkyFeature.Jupiter` @Value: 104.
---| `ac.SkyFeature.Saturn` @Value: 105.
---| `ac.SkyFeature.ISS` @Value: 200.
ac.SkyFeature = {
  Sun = 0, ---@type ac.SkyFeature #Value: 0.
  Moon = 1, ---@type ac.SkyFeature #Value: 1.
  Mercury = 101, ---@type ac.SkyFeature #Value: 101.
  Venus = 102, ---@type ac.SkyFeature #Value: 102.
  Mars = 103, ---@type ac.SkyFeature #Value: 103.
  Jupiter = 104, ---@type ac.SkyFeature #Value: 104.
  Saturn = 105, ---@type ac.SkyFeature #Value: 105.
  ISS = 200, ---@type ac.SkyFeature #Value: 200.
}

---This enum is used by car state.
---@alias ac.UserInputMode
---| `ac.UserInputMode.Wheel` @Value: 0.
---| `ac.UserInputMode.Gamepad` @Value: 1.
---| `ac.UserInputMode.Keyboard` @Value: 2.
ac.UserInputMode = {
  Wheel = 0, ---@type ac.UserInputMode #Value: 0.
  Gamepad = 1, ---@type ac.UserInputMode #Value: 1.
  Keyboard = 2, ---@type ac.UserInputMode #Value: 2.
}

---@alias ac.AudioChannel
---| `ac.AudioChannel.Main` @Value: 'main'.
---| `ac.AudioChannel.Rain` @Value: 'rain'.
---| `ac.AudioChannel.Weather` @Value: 'weather'.
---| `ac.AudioChannel.Track` @Value: 'track'.
---| `ac.AudioChannel.Wipers` @Value: 'wipers'.
---| `ac.AudioChannel.CarComponents` @Value: 'carComponents'.
---| `ac.AudioChannel.Wind` @Value: 'wind'.
---| `ac.AudioChannel.Tyres` @Value: 'tyres'.
---| `ac.AudioChannel.Surfaces` @Value: 'surfaces'.
---| `ac.AudioChannel.Dirt` @Value: 'dirt'.
---| `ac.AudioChannel.Engine` @Value: 'engine'.
---| `ac.AudioChannel.Transmission` @Value: 'transmission'.
---| `ac.AudioChannel.Opponents` @Value: 'opponents'.
ac.AudioChannel = {
  Main = 'main', ---@type ac.AudioChannel #Value: 'main'.
  Rain = 'rain', ---@type ac.AudioChannel #Value: 'rain'.
  Weather = 'weather', ---@type ac.AudioChannel #Value: 'weather'.
  Track = 'track', ---@type ac.AudioChannel #Value: 'track'.
  Wipers = 'wipers', ---@type ac.AudioChannel #Value: 'wipers'.
  CarComponents = 'carComponents', ---@type ac.AudioChannel #Value: 'carComponents'.
  Wind = 'wind', ---@type ac.AudioChannel #Value: 'wind'.
  Tyres = 'tyres', ---@type ac.AudioChannel #Value: 'tyres'.
  Surfaces = 'surfaces', ---@type ac.AudioChannel #Value: 'surfaces'.
  Dirt = 'dirt', ---@type ac.AudioChannel #Value: 'dirt'.
  Engine = 'engine', ---@type ac.AudioChannel #Value: 'engine'.
  Transmission = 'transmission', ---@type ac.AudioChannel #Value: 'transmission'.
  Opponents = 'opponents', ---@type ac.AudioChannel #Value: 'opponents'.
}

---@alias ac.SpawnSet
---| `ac.SpawnSet.Start` @Value: 'START'.
---| `ac.SpawnSet.Pits` @Value: 'PIT'.
---| `ac.SpawnSet.HotlapStart` @Value: 'HOTLAP_START'.
---| `ac.SpawnSet.TimeAttack` @Careful: most tracks might not have that spawn set.
ac.SpawnSet = {
  Start = 'START', ---@type ac.SpawnSet #Value: 'START'.
  Pits = 'PIT', ---@type ac.SpawnSet #Value: 'PIT'.
  HotlapStart = 'HOTLAP_START', ---@type ac.SpawnSet #Value: 'HOTLAP_START'.
  TimeAttack = 'TIME_ATTACK', ---@type ac.SpawnSet #Careful: most tracks might not have that spawn set.
}

---At the moment, most of those flag types are never shown, but more flags will be added later. Also, physics-altering scripts---(like, for example, server scripts) can override flag type and use any flag from this list (and apply their own rules and---penalties when needed)
---@alias ac.FlagType
---| `ac.FlagType.None` @No flag, works.
---| `ac.FlagType.Start` @Works in race, practice or hotlap modes.
---| `ac.FlagType.Caution` @Yellow flag, works.
---| `ac.FlagType.Slippery` @Does not work yet.
---| `ac.FlagType.PitLaneClosed` @Does not work yet.
---| `ac.FlagType.Stop` @Black flag, works.
---| `ac.FlagType.SlowVehicle` @Does not work yet.
---| `ac.FlagType.Ambulance` @Does not work yet.
---| `ac.FlagType.ReturnToPits` @Penalty flag, works.
---| `ac.FlagType.MechanicalFailure` @Does not work yet.
---| `ac.FlagType.Unsportsmanlike` @Does not work yet.
---| `ac.FlagType.StopCancel` @Does not work yet.
---| `ac.FlagType.FasterCar` @Blue flag, works.
---| `ac.FlagType.Finished` @Checkered flag, works.
---| `ac.FlagType.OneLapLeft` @White flag, works.
---| `ac.FlagType.SessionSuspended` @Does not work yet.
---| `ac.FlagType.Code60` @Does not work yet.
ac.FlagType = {
  None = 0, ---@type ac.FlagType #No flag, works.
  Start = 1, ---@type ac.FlagType #Works in race, practice or hotlap modes.
  Caution = 2, ---@type ac.FlagType #Yellow flag, works.
  Slippery = 3, ---@type ac.FlagType #Does not work yet.
  PitLaneClosed = 4, ---@type ac.FlagType #Does not work yet.
  Stop = 5, ---@type ac.FlagType #Black flag, works.
  SlowVehicle = 6, ---@type ac.FlagType #Does not work yet.
  Ambulance = 7, ---@type ac.FlagType #Does not work yet.
  ReturnToPits = 8, ---@type ac.FlagType #Penalty flag, works.
  MechanicalFailure = 9, ---@type ac.FlagType #Does not work yet.
  Unsportsmanlike = 10, ---@type ac.FlagType #Does not work yet.
  StopCancel = 11, ---@type ac.FlagType #Does not work yet.
  FasterCar = 12, ---@type ac.FlagType #Blue flag, works.
  Finished = 13, ---@type ac.FlagType #Checkered flag, works.
  OneLapLeft = 14, ---@type ac.FlagType #White flag, works.
  SessionSuspended = 15, ---@type ac.FlagType #Does not work yet.
  Code60 = 16, ---@type ac.FlagType #Does not work yet.
}

---This enum is used by physics scripts only. For the one for car state, use `ac.UserInputMode`.
---@alias ac.InputMethod
---| `ac.InputMethod.Unknown` @Value: 0.
---| `ac.InputMethod.Wheel` @Value: 1.
---| `ac.InputMethod.Gamepad` @Value: 2.
---| `ac.InputMethod.Keyboard` @Value: 3.
---| `ac.InputMethod.AI` @Value: 4.
ac.InputMethod = {
  Unknown = 0, ---@type ac.InputMethod #Value: 0.
  Wheel = 1, ---@type ac.InputMethod #Value: 1.
  Gamepad = 2, ---@type ac.InputMethod #Value: 2.
  Keyboard = 3, ---@type ac.InputMethod #Value: 3.
  AI = 4, ---@type ac.InputMethod #Value: 4.
}

---@alias ac.PenaltyType
---| `ac.PenaltyType.None` @No penalty.
---| `ac.PenaltyType.MandatoryPits` @Parameter: how many laps are left to do mandatory pits.
---| `ac.PenaltyType.TeleportToPits` @Parameter: how many seconds to wait in pits with locked controls.
---| `ac.PenaltyType.SlowDown` @Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
---| `ac.PenaltyType.BlackFlag` @Adds black flag, no parameter.
---| `ac.PenaltyType.ReleaseBlackFlag` @Removes previously set black flag, no parameter.
ac.PenaltyType = {
  None = 0, ---@type ac.PenaltyType #No penalty.
  MandatoryPits = 1, ---@type ac.PenaltyType #Parameter: how many laps are left to do mandatory pits.
  TeleportToPits = 2, ---@type ac.PenaltyType #Parameter: how many seconds to wait in pits with locked controls.
  SlowDown = 3, ---@type ac.PenaltyType #Requires to cut gas for number of seconds in parameter (warning: works only with some race configurations, for example, “Disable gas cut penalty” should not be active in server rules settings).
  BlackFlag = 4, ---@type ac.PenaltyType #Adds black flag, no parameter.
  ReleaseBlackFlag = 5, ---@type ac.PenaltyType #Removes previously set black flag, no parameter.
}

---@alias ac.ImageFormat
---| `ac.ImageFormat.BMP` @Value: 0.
---| `ac.ImageFormat.JPG` @Value: 1.
---| `ac.ImageFormat.PNG` @Value: 2.
---| `ac.ImageFormat.DDS` @Value: 5.
---| `ac.ImageFormat.ZippedDDS` @DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
ac.ImageFormat = {
  BMP = 0, ---@type ac.ImageFormat #Value: 0.
  JPG = 1, ---@type ac.ImageFormat #Value: 1.
  PNG = 2, ---@type ac.ImageFormat #Value: 2.
  DDS = 5, ---@type ac.ImageFormat #Value: 5.
  ZippedDDS = 6, ---@type ac.ImageFormat #DDS in a ZIP file, if used for saving canvas, actual saving happens in a different thread (so, it’s both fast and compact).
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ac.KeyIndex
---| `ac.KeyIndex.LeftButton` @Value: 1.
---| `ac.KeyIndex.RightButton` @Value: 2.
---| `ac.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ac.KeyIndex.Tab` @Value: 9.
---| `ac.KeyIndex.Return` @Value: 13.
---| `ac.KeyIndex.Shift` @Value: 16.
---| `ac.KeyIndex.Control` @Value: 17.
---| `ac.KeyIndex.Menu` @Aka Alt button.
---| `ac.KeyIndex.Escape` @Value: 27.
---| `ac.KeyIndex.Accept` @Value: 30.
---| `ac.KeyIndex.Space` @Value: 32.
---| `ac.KeyIndex.End` @Value: 35.
---| `ac.KeyIndex.Home` @Value: 36.
---| `ac.KeyIndex.Left` @Arrow ←.
---| `ac.KeyIndex.Up` @Arrow ↑.
---| `ac.KeyIndex.Right` @Arrow →.
---| `ac.KeyIndex.Down` @Arrow ↓.
---| `ac.KeyIndex.Insert` @Value: 45.
---| `ac.KeyIndex.Delete` @Value: 46.
---| `ac.KeyIndex.LeftWin` @Value: 91.
---| `ac.KeyIndex.RightWin` @Value: 92.
---| `ac.KeyIndex.NumPad0` @Value: 96.
---| `ac.KeyIndex.NumPad1` @Value: 97.
---| `ac.KeyIndex.NumPad2` @Value: 98.
---| `ac.KeyIndex.NumPad3` @Value: 99.
---| `ac.KeyIndex.NumPad4` @Value: 100.
---| `ac.KeyIndex.NumPad5` @Value: 101.
---| `ac.KeyIndex.NumPad6` @Value: 102.
---| `ac.KeyIndex.NumPad7` @Value: 103.
---| `ac.KeyIndex.NumPad8` @Value: 104.
---| `ac.KeyIndex.NumPad9` @Value: 105.
---| `ac.KeyIndex.Multiply` @Value: 106.
---| `ac.KeyIndex.Add` @Value: 107.
---| `ac.KeyIndex.Separator` @Value: 108.
---| `ac.KeyIndex.Subtract` @Value: 109.
---| `ac.KeyIndex.Decimal` @Value: 110.
---| `ac.KeyIndex.Divide` @Value: 111.
---| `ac.KeyIndex.F1` @Value: 112.
---| `ac.KeyIndex.F2` @Value: 113.
---| `ac.KeyIndex.F3` @Value: 114.
---| `ac.KeyIndex.F4` @Value: 115.
---| `ac.KeyIndex.F5` @Value: 116.
---| `ac.KeyIndex.F6` @Value: 117.
---| `ac.KeyIndex.F7` @Value: 118.
---| `ac.KeyIndex.F8` @Value: 119.
---| `ac.KeyIndex.F9` @Value: 120.
---| `ac.KeyIndex.F10` @Value: 121.
---| `ac.KeyIndex.F11` @Value: 122.
---| `ac.KeyIndex.F12` @Value: 123.
---| `ac.KeyIndex.NumLock` @Value: 144.
---| `ac.KeyIndex.Scroll` @Value: 145.
---| `ac.KeyIndex.OemNecEqual` @“.
---| `ac.KeyIndex.LeftShift` @Value: 160.
---| `ac.KeyIndex.RightShift` @Value: 161.
---| `ac.KeyIndex.LeftControl` @Value: 162.
---| `ac.KeyIndex.RightControl` @Value: 163.
---| `ac.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ac.KeyIndex.RightMenu` @Aka right Alt button.
---| `ac.KeyIndex.Oem1` @“;:” for US.
---| `ac.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ac.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ac.KeyIndex.D0` @Digit 0.
---| `ac.KeyIndex.D1` @Digit 1.
---| `ac.KeyIndex.D2` @Digit 2.
---| `ac.KeyIndex.D3` @Digit 3.
---| `ac.KeyIndex.D4` @Digit 4.
---| `ac.KeyIndex.D5` @Digit 5.
---| `ac.KeyIndex.D6` @Digit 6.
---| `ac.KeyIndex.D7` @Digit 7.
---| `ac.KeyIndex.D8` @Digit 8.
---| `ac.KeyIndex.D9` @Digit 9.
---| `ac.KeyIndex.A` @Letter A.
---| `ac.KeyIndex.B` @Letter B.
---| `ac.KeyIndex.C` @Letter C.
---| `ac.KeyIndex.D` @Letter D.
---| `ac.KeyIndex.E` @Letter E.
---| `ac.KeyIndex.F` @Letter F.
---| `ac.KeyIndex.G` @Letter G.
---| `ac.KeyIndex.H` @Letter H.
---| `ac.KeyIndex.I` @Letter I.
---| `ac.KeyIndex.J` @Letter J.
---| `ac.KeyIndex.K` @Letter K.
---| `ac.KeyIndex.L` @Letter L.
---| `ac.KeyIndex.M` @Letter M.
---| `ac.KeyIndex.N` @Letter N.
---| `ac.KeyIndex.O` @Letter O.
---| `ac.KeyIndex.P` @Letter P.
---| `ac.KeyIndex.Q` @Letter Q.
---| `ac.KeyIndex.R` @Letter R.
---| `ac.KeyIndex.S` @Letter S.
---| `ac.KeyIndex.T` @Letter T.
---| `ac.KeyIndex.U` @Letter U.
---| `ac.KeyIndex.V` @Letter V.
---| `ac.KeyIndex.W` @Letter W.
---| `ac.KeyIndex.X` @Letter X.
---| `ac.KeyIndex.Y` @Letter Y.
---| `ac.KeyIndex.Z` @Letter Z.
ac.KeyIndex = {
  LeftButton = 1, ---@type ac.KeyIndex #Value: 1.
  RightButton = 2, ---@type ac.KeyIndex #Value: 2.
  Cancel = 3, ---@type ac.KeyIndex #Value: 3.
  MiddleButton = 4, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---@type ac.KeyIndex #Not contiguous with LeftButton and RightButton.
  Back = 8, ---@type ac.KeyIndex #Value: 8.
  Tab = 9, ---@type ac.KeyIndex #Value: 9.
  Clear = 12, ---@type ac.KeyIndex #Value: 12.
  Return = 13, ---@type ac.KeyIndex #Value: 13.
  Shift = 16, ---@type ac.KeyIndex #Value: 16.
  Control = 17, ---@type ac.KeyIndex #Value: 17.
  Menu = 18, ---@type ac.KeyIndex #Aka Alt button.
  Pause = 19, ---@type ac.KeyIndex #Value: 19.
  Capital = 20, ---@type ac.KeyIndex #Value: 20.
  Kana = 21, ---@type ac.KeyIndex #Value: 21.
  Hangeul = 21, ---@type ac.KeyIndex #Old name - should be here for compatibility.
  Hangul = 21, ---@type ac.KeyIndex #Value: 21.
  Junja = 23, ---@type ac.KeyIndex #Value: 23.
  Final = 24, ---@type ac.KeyIndex #Value: 24.
  Hanja = 25, ---@type ac.KeyIndex #Value: 25.
  Kanji = 25, ---@type ac.KeyIndex #Value: 25.
  Escape = 27, ---@type ac.KeyIndex #Value: 27.
  Convert = 28, ---@type ac.KeyIndex #Value: 28.
  NonConvert = 29, ---@type ac.KeyIndex #Value: 29.
  Accept = 30, ---@type ac.KeyIndex #Value: 30.
  ModeChange = 31, ---@type ac.KeyIndex #Value: 31.
  Space = 32, ---@type ac.KeyIndex #Value: 32.
  PageUp = 33, ---@type ac.KeyIndex #Value: 33.
  PageDown = 34, ---@type ac.KeyIndex #Value: 34.
  End = 35, ---@type ac.KeyIndex #Value: 35.
  Home = 36, ---@type ac.KeyIndex #Value: 36.
  Left = 37, ---@type ac.KeyIndex #Arrow ←.
  Up = 38, ---@type ac.KeyIndex #Arrow ↑.
  Right = 39, ---@type ac.KeyIndex #Arrow →.
  Down = 40, ---@type ac.KeyIndex #Arrow ↓.
  Select = 41, ---@type ac.KeyIndex #Value: 41.
  Print = 42, ---@type ac.KeyIndex #Value: 42.
  Execute = 43, ---@type ac.KeyIndex #Value: 43.
  Snapshot = 44, ---@type ac.KeyIndex #Value: 44.
  Insert = 45, ---@type ac.KeyIndex #Value: 45.
  Delete = 46, ---@type ac.KeyIndex #Value: 46.
  Help = 47, ---@type ac.KeyIndex #Value: 47.
  LeftWin = 91, ---@type ac.KeyIndex #Value: 91.
  RightWin = 92, ---@type ac.KeyIndex #Value: 92.
  Apps = 93, ---@type ac.KeyIndex #Value: 93.
  Sleep = 95, ---@type ac.KeyIndex #Value: 95.
  NumPad0 = 96, ---@type ac.KeyIndex #Value: 96.
  NumPad1 = 97, ---@type ac.KeyIndex #Value: 97.
  NumPad2 = 98, ---@type ac.KeyIndex #Value: 98.
  NumPad3 = 99, ---@type ac.KeyIndex #Value: 99.
  NumPad4 = 100, ---@type ac.KeyIndex #Value: 100.
  NumPad5 = 101, ---@type ac.KeyIndex #Value: 101.
  NumPad6 = 102, ---@type ac.KeyIndex #Value: 102.
  NumPad7 = 103, ---@type ac.KeyIndex #Value: 103.
  NumPad8 = 104, ---@type ac.KeyIndex #Value: 104.
  NumPad9 = 105, ---@type ac.KeyIndex #Value: 105.
  Multiply = 106, ---@type ac.KeyIndex #Value: 106.
  Add = 107, ---@type ac.KeyIndex #Value: 107.
  Separator = 108, ---@type ac.KeyIndex #Value: 108.
  Subtract = 109, ---@type ac.KeyIndex #Value: 109.
  Decimal = 110, ---@type ac.KeyIndex #Value: 110.
  Divide = 111, ---@type ac.KeyIndex #Value: 111.
  F1 = 112, ---@type ac.KeyIndex #Value: 112.
  F2 = 113, ---@type ac.KeyIndex #Value: 113.
  F3 = 114, ---@type ac.KeyIndex #Value: 114.
  F4 = 115, ---@type ac.KeyIndex #Value: 115.
  F5 = 116, ---@type ac.KeyIndex #Value: 116.
  F6 = 117, ---@type ac.KeyIndex #Value: 117.
  F7 = 118, ---@type ac.KeyIndex #Value: 118.
  F8 = 119, ---@type ac.KeyIndex #Value: 119.
  F9 = 120, ---@type ac.KeyIndex #Value: 120.
  F10 = 121, ---@type ac.KeyIndex #Value: 121.
  F11 = 122, ---@type ac.KeyIndex #Value: 122.
  F12 = 123, ---@type ac.KeyIndex #Value: 123.
  F13 = 124, ---@type ac.KeyIndex #Value: 124.
  F14 = 125, ---@type ac.KeyIndex #Value: 125.
  F15 = 126, ---@type ac.KeyIndex #Value: 126.
  F16 = 127, ---@type ac.KeyIndex #Value: 127.
  F17 = 128, ---@type ac.KeyIndex #Value: 128.
  F18 = 129, ---@type ac.KeyIndex #Value: 129.
  F19 = 130, ---@type ac.KeyIndex #Value: 130.
  F20 = 131, ---@type ac.KeyIndex #Value: 131.
  F21 = 132, ---@type ac.KeyIndex #Value: 132.
  F22 = 133, ---@type ac.KeyIndex #Value: 133.
  F23 = 134, ---@type ac.KeyIndex #Value: 134.
  F24 = 135, ---@type ac.KeyIndex #Value: 135.
  NavigationView = 136, ---@type ac.KeyIndex #Reserved.
  NavigationMenu = 137, ---@type ac.KeyIndex #Reserved.
  NavigationUp = 138, ---@type ac.KeyIndex #Reserved.
  NavigationDown = 139, ---@type ac.KeyIndex #Reserved.
  NavigationLeft = 140, ---@type ac.KeyIndex #Reserved.
  NavigationRight = 141, ---@type ac.KeyIndex #Reserved.
  NavigationAccept = 142, ---@type ac.KeyIndex #Reserved.
  NavigationCancel = 143, ---@type ac.KeyIndex #Reserved.
  NumLock = 144, ---@type ac.KeyIndex #Value: 144.
  Scroll = 145, ---@type ac.KeyIndex #Value: 145.
  OemNecEqual = 146, ---@type ac.KeyIndex #“.
  OemFjJisho = 146, ---@type ac.KeyIndex #“Dictionary” key.
  OemFjMasshou = 147, ---@type ac.KeyIndex #“Unregister word” key.
  OemFjTouroku = 148, ---@type ac.KeyIndex #“Register word” key.
  OemFjLoya = 149, ---@type ac.KeyIndex #“Left OYAYUBI” key.
  OemFjRoya = 150, ---@type ac.KeyIndex #“Right OYAYUBI” key.
  LeftShift = 160, ---@type ac.KeyIndex #Value: 160.
  RightShift = 161, ---@type ac.KeyIndex #Value: 161.
  LeftControl = 162, ---@type ac.KeyIndex #Value: 162.
  RightControl = 163, ---@type ac.KeyIndex #Value: 163.
  LeftMenu = 164, ---@type ac.KeyIndex #Aka left Alt button.
  RightMenu = 165, ---@type ac.KeyIndex #Aka right Alt button.
  BrowserBack = 166, ---@type ac.KeyIndex #Value: 166.
  BrowserForward = 167, ---@type ac.KeyIndex #Value: 167.
  BrowserRefresh = 168, ---@type ac.KeyIndex #Value: 168.
  BrowserStop = 169, ---@type ac.KeyIndex #Value: 169.
  BrowserSearch = 170, ---@type ac.KeyIndex #Value: 170.
  BrowserFavorites = 171, ---@type ac.KeyIndex #Value: 171.
  BrowserHome = 172, ---@type ac.KeyIndex #Value: 172.
  VolumeMute = 173, ---@type ac.KeyIndex #Value: 173.
  VolumeDown = 174, ---@type ac.KeyIndex #Value: 174.
  VolumeUp = 175, ---@type ac.KeyIndex #Value: 175.
  MediaNextTrack = 176, ---@type ac.KeyIndex #Value: 176.
  MediaPrevTrack = 177, ---@type ac.KeyIndex #Value: 177.
  MediaStop = 178, ---@type ac.KeyIndex #Value: 178.
  MediaPlayPause = 179, ---@type ac.KeyIndex #Value: 179.
  LaunchMail = 180, ---@type ac.KeyIndex #Value: 180.
  LaunchMediaSelect = 181, ---@type ac.KeyIndex #Value: 181.
  LaunchApp1 = 182, ---@type ac.KeyIndex #Value: 182.
  LaunchApp2 = 183, ---@type ac.KeyIndex #Value: 183.
  Oem1 = 186, ---@type ac.KeyIndex #“;:” for US.
  OemPlus = 187, ---@type ac.KeyIndex #“+” any country.
  OemComma = 188, ---@type ac.KeyIndex #“,” any country.
  OemMinus = 189, ---@type ac.KeyIndex #“-” any country.
  OemPeriod = 190, ---@type ac.KeyIndex #“.” any country.
  Oem2 = 191, ---@type ac.KeyIndex #“/?” for US.
  Oem3 = 192, ---@type ac.KeyIndex #“`~” for US.
  GamepadA = 195, ---@type ac.KeyIndex #Reserved.
  GamepadB = 196, ---@type ac.KeyIndex #Reserved.
  GamepadX = 197, ---@type ac.KeyIndex #Reserved.
  GamepadY = 198, ---@type ac.KeyIndex #Reserved.
  GamepadRightShoulder = 199, ---@type ac.KeyIndex #Reserved.
  GamepadLeftShoulder = 200, ---@type ac.KeyIndex #Reserved.
  GamepadLeftTrigger = 201, ---@type ac.KeyIndex #Reserved.
  GamepadRightTrigger = 202, ---@type ac.KeyIndex #Reserved.
  GamepadDpadUp = 203, ---@type ac.KeyIndex #Reserved.
  GamepadDpadDown = 204, ---@type ac.KeyIndex #Reserved.
  GamepadDpadLeft = 205, ---@type ac.KeyIndex #Reserved.
  GamepadDpadRight = 206, ---@type ac.KeyIndex #Reserved.
  GamepadMenu = 207, ---@type ac.KeyIndex #Reserved.
  GamepadView = 208, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickButton = 209, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickButton = 210, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickUp = 211, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickDown = 212, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickRight = 213, ---@type ac.KeyIndex #Reserved.
  GamepadLeftThumbstickLeft = 214, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickUp = 215, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickDown = 216, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickRight = 217, ---@type ac.KeyIndex #Reserved.
  GamepadRightThumbstickLeft = 218, ---@type ac.KeyIndex #Reserved.
  SquareOpenBracket = 219, ---@type ac.KeyIndex #Value: 219.
  SquareCloseBracket = 221, ---@type ac.KeyIndex #Value: 221.
  D0 = 48, ---@type ac.KeyIndex #Digit 0.
  D1 = 49, ---@type ac.KeyIndex #Digit 1.
  D2 = 50, ---@type ac.KeyIndex #Digit 2.
  D3 = 51, ---@type ac.KeyIndex #Digit 3.
  D4 = 52, ---@type ac.KeyIndex #Digit 4.
  D5 = 53, ---@type ac.KeyIndex #Digit 5.
  D6 = 54, ---@type ac.KeyIndex #Digit 6.
  D7 = 55, ---@type ac.KeyIndex #Digit 7.
  D8 = 56, ---@type ac.KeyIndex #Digit 8.
  D9 = 57, ---@type ac.KeyIndex #Digit 9.
  A = 65, ---@type ac.KeyIndex #Letter A.
  B = 66, ---@type ac.KeyIndex #Letter B.
  C = 67, ---@type ac.KeyIndex #Letter C.
  D = 68, ---@type ac.KeyIndex #Letter D.
  E = 69, ---@type ac.KeyIndex #Letter E.
  F = 70, ---@type ac.KeyIndex #Letter F.
  G = 71, ---@type ac.KeyIndex #Letter G.
  H = 72, ---@type ac.KeyIndex #Letter H.
  I = 73, ---@type ac.KeyIndex #Letter I.
  J = 74, ---@type ac.KeyIndex #Letter J.
  K = 75, ---@type ac.KeyIndex #Letter K.
  L = 76, ---@type ac.KeyIndex #Letter L.
  M = 77, ---@type ac.KeyIndex #Letter M.
  N = 78, ---@type ac.KeyIndex #Letter N.
  O = 79, ---@type ac.KeyIndex #Letter O.
  P = 80, ---@type ac.KeyIndex #Letter P.
  Q = 81, ---@type ac.KeyIndex #Letter Q.
  R = 82, ---@type ac.KeyIndex #Letter R.
  S = 83, ---@type ac.KeyIndex #Letter S.
  T = 84, ---@type ac.KeyIndex #Letter T.
  U = 85, ---@type ac.KeyIndex #Letter U.
  V = 86, ---@type ac.KeyIndex #Letter V.
  W = 87, ---@type ac.KeyIndex #Letter W.
  X = 88, ---@type ac.KeyIndex #Letter X.
  Y = 89, ---@type ac.KeyIndex #Letter Y.
  Z = 90, ---@type ac.KeyIndex #Letter Z.
}

---More types might be added later, or at least a `CustomMode` type.
---@alias ac.SessionType
---| `ac.SessionType.Undefined` @Value: 0.
---| `ac.SessionType.Practice` @Value: 1.
---| `ac.SessionType.Qualify` @Value: 2.
---| `ac.SessionType.Race` @Value: 3.
---| `ac.SessionType.Hotlap` @Value: 4.
---| `ac.SessionType.TimeAttack` @Value: 5.
---| `ac.SessionType.Drift` @Value: 6.
---| `ac.SessionType.Drag` @Value: 7.
ac.SessionType = {
  Undefined = 0, ---@type ac.SessionType #Value: 0.
  Practice = 1, ---@type ac.SessionType #Value: 1.
  Qualify = 2, ---@type ac.SessionType #Value: 2.
  Race = 3, ---@type ac.SessionType #Value: 3.
  Hotlap = 4, ---@type ac.SessionType #Value: 4.
  TimeAttack = 5, ---@type ac.SessionType #Value: 5.
  Drift = 6, ---@type ac.SessionType #Value: 6.
  Drag = 7, ---@type ac.SessionType #Value: 7.
}

---@alias ac.SharedNamespace
---| `ac.SharedNamespace.Global` @Value: ''.
---| `ac.SharedNamespace.CarDisplay` @Value: 'car_scriptable_display'.
---| `ac.SharedNamespace.CarScript` @Value: 'car_script'.
---| `ac.SharedNamespace.TrackDisplay` @Value: 'track_scriptable_display'.
---| `ac.SharedNamespace.TrackScript` @Value: 'track_script'.
---| `ac.SharedNamespace.ServerScript` @Value: 'server_script'.
---| `ac.SharedNamespace.Shared` @Value: 'shared'.
ac.SharedNamespace = {
  Global = '', ---@type ac.SharedNamespace #Value: ''.
  CarDisplay = 'car_scriptable_display', ---@type ac.SharedNamespace #Value: 'car_scriptable_display'.
  CarScript = 'car_script', ---@type ac.SharedNamespace #Value: 'car_script'.
  TrackDisplay = 'track_scriptable_display', ---@type ac.SharedNamespace #Value: 'track_scriptable_display'.
  TrackScript = 'track_script', ---@type ac.SharedNamespace #Value: 'track_script'.
  ServerScript = 'server_script', ---@type ac.SharedNamespace #Value: 'server_script'.
  Shared = 'shared', ---@type ac.SharedNamespace #Value: 'shared'.
}

---@alias ac.CompressionType
---| `ac.CompressionType.LZ4` @Fastest compression, great for use in real-time applications. Does not take `level` into account.
---| `ac.CompressionType.Deflate` @Deflate compression.
---| `ac.CompressionType.Zlib` @Zlib compression (deflate with zlib wrapper).
---| `ac.CompressionType.Gzip` @Gzip compression (deflate with gzip wrapper).
ac.CompressionType = {
  LZ4 = 0, ---@type ac.CompressionType #Fastest compression, great for use in real-time applications. Does not take `level` into account.
  Deflate = 1, ---@type ac.CompressionType #Deflate compression.
  Zlib = 2, ---@type ac.CompressionType #Zlib compression (deflate with zlib wrapper).
  Gzip = 3, ---@type ac.CompressionType #Gzip compression (deflate with gzip wrapper).
}

---@alias ac.NationCode
---| `ac.NationCode.Aruba` @Aruba.
---| `ac.NationCode.Afghanistan` @Afghanistan.
---| `ac.NationCode.Angola` @Angola.
---| `ac.NationCode.Anguilla` @Anguilla.
---| `ac.NationCode.Albania` @Albania.
---| `ac.NationCode.Andorra` @Andorra.
---| `ac.NationCode.UnitedArabEmirates` @United Arab Emirates.
---| `ac.NationCode.Argentina` @Argentina.
---| `ac.NationCode.Armenia` @Armenia.
---| `ac.NationCode.AmericanSamoa` @American Samoa.
---| `ac.NationCode.Antarctica` @Antarctica.
---| `ac.NationCode.AntiguaAndBarbuda` @Antigua and Barbuda.
---| `ac.NationCode.Australia` @Australia.
---| `ac.NationCode.Austria` @Austria.
---| `ac.NationCode.Azerbaijan` @Azerbaijan.
---| `ac.NationCode.Burundi` @Burundi.
---| `ac.NationCode.Belgium` @Belgium.
---| `ac.NationCode.Benin` @Benin.
---| `ac.NationCode.BurkinaFaso` @Burkina Faso.
---| `ac.NationCode.Bangladesh` @Bangladesh.
---| `ac.NationCode.Bulgaria` @Bulgaria.
---| `ac.NationCode.Bahrain` @Bahrain.
---| `ac.NationCode.Bahamas` @Bahamas.
---| `ac.NationCode.BosniaAndHerzegovina` @Bosnia and Herzegovina.
---| `ac.NationCode.Belarus` @Belarus.
---| `ac.NationCode.Belize` @Belize.
---| `ac.NationCode.Bermuda` @Bermuda.
---| `ac.NationCode.Bolivia` @Bolivia.
---| `ac.NationCode.Brazil` @Brazil.
---| `ac.NationCode.Barbados` @Barbados.
---| `ac.NationCode.Brunei` @Brunei.
---| `ac.NationCode.Bhutan` @Bhutan.
---| `ac.NationCode.Botswana` @Botswana.
---| `ac.NationCode.CentralAfricanRepublic` @Central African Republic.
---| `ac.NationCode.Canada` @Canada.
---| `ac.NationCode.CocosIslands` @Cocos Islands.
---| `ac.NationCode.Switzerland` @Switzerland.
---| `ac.NationCode.Chile` @Chile.
---| `ac.NationCode.China` @China.
---| `ac.NationCode.CoteDIvoire` @Côte d’Ivoire.
---| `ac.NationCode.Cameroon` @Cameroon.
---| `ac.NationCode.DemocraticRepublicOfTheCongo` @Democratic Republic of the Congo.
---| `ac.NationCode.RepublicOfTheCongo` @Republic of the Congo.
---| `ac.NationCode.CookIslands` @Cook Islands.
---| `ac.NationCode.Colombia` @Colombia.
---| `ac.NationCode.Comoros` @Comoros.
---| `ac.NationCode.CapeVerde` @Cape Verde.
---| `ac.NationCode.CostaRica` @Costa Rica.
---| `ac.NationCode.Cuba` @Cuba.
---| `ac.NationCode.CaymanIslands` @Cayman Islands.
---| `ac.NationCode.Cyprus` @Cyprus.
---| `ac.NationCode.Czechia` @Czechia.
---| `ac.NationCode.Germany` @Germany.
---| `ac.NationCode.Djibouti` @Djibouti.
---| `ac.NationCode.Dominica` @Dominica.
---| `ac.NationCode.Denmark` @Denmark.
---| `ac.NationCode.DominicanRepublic` @Dominican Republic.
---| `ac.NationCode.Algeria` @Algeria.
---| `ac.NationCode.Ecuador` @Ecuador.
---| `ac.NationCode.Egypt` @Egypt.
---| `ac.NationCode.England` @England.
---| `ac.NationCode.Eritrea` @Eritrea.
---| `ac.NationCode.WesternSahara` @Western Sahara.
---| `ac.NationCode.Spain` @Spain.
---| `ac.NationCode.Estonia` @Estonia.
---| `ac.NationCode.Ethiopia` @Ethiopia.
---| `ac.NationCode.Finland` @Finland.
---| `ac.NationCode.Fiji` @Fiji.
---| `ac.NationCode.France` @France.
---| `ac.NationCode.FaroeIslands` @Faroe Islands.
---| `ac.NationCode.Micronesia` @Micronesia.
---| `ac.NationCode.Gabon` @Gabon.
---| `ac.NationCode.UnitedKingdom` @United Kingdom.
---| `ac.NationCode.Georgia` @Georgia.
---| `ac.NationCode.Guernsey` @Guernsey.
---| `ac.NationCode.Ghana` @Ghana.
---| `ac.NationCode.Gibraltar` @Gibraltar.
---| `ac.NationCode.Guinea` @Guinea.
---| `ac.NationCode.Gambia` @Gambia.
---| `ac.NationCode.GuineaBissau` @Guinea-Bissau.
---| `ac.NationCode.EquatorialGuinea` @Equatorial Guinea.
---| `ac.NationCode.Greece` @Greece.
---| `ac.NationCode.Grenada` @Grenada.
---| `ac.NationCode.Greenland` @Greenland.
---| `ac.NationCode.Guatemala` @Guatemala.
---| `ac.NationCode.Guam` @Guam.
---| `ac.NationCode.Guyana` @Guyana.
---| `ac.NationCode.HongKong` @Hong Kong.
---| `ac.NationCode.Honduras` @Honduras.
---| `ac.NationCode.Croatia` @Croatia.
---| `ac.NationCode.Haiti` @Haiti.
---| `ac.NationCode.Hungary` @Hungary.
---| `ac.NationCode.Indonesia` @Indonesia.
---| `ac.NationCode.IsleOfMan` @Isle of Man.
---| `ac.NationCode.India` @India.
---| `ac.NationCode.Ireland` @Ireland.
---| `ac.NationCode.Iran` @Iran.
---| `ac.NationCode.Iraq` @Iraq.
---| `ac.NationCode.Iceland` @Iceland.
---| `ac.NationCode.Israel` @Israel.
---| `ac.NationCode.Italy` @Italy.
---| `ac.NationCode.Jamaica` @Jamaica.
---| `ac.NationCode.Jersey` @Jersey.
---| `ac.NationCode.Jordan` @Jordan.
---| `ac.NationCode.Japan` @Japan.
---| `ac.NationCode.Kazakhstan` @Kazakhstan.
---| `ac.NationCode.Kenya` @Kenya.
---| `ac.NationCode.Kyrgyzstan` @Kyrgyzstan.
---| `ac.NationCode.Cambodia` @Cambodia.
---| `ac.NationCode.Kiribati` @Kiribati.
---| `ac.NationCode.SaintKittsAndNevis` @Saint Kitts and Nevis.
---| `ac.NationCode.SouthKorea` @South Korea.
---| `ac.NationCode.Kuwait` @Kuwait.
---| `ac.NationCode.Laos` @Laos.
---| `ac.NationCode.Lebanon` @Lebanon.
---| `ac.NationCode.Liberia` @Liberia.
---| `ac.NationCode.Libya` @Libya.
---| `ac.NationCode.SaintLucia` @Saint Lucia.
---| `ac.NationCode.Liechtenstein` @Liechtenstein.
---| `ac.NationCode.SriLanka` @Sri Lanka.
---| `ac.NationCode.Lesotho` @Lesotho.
---| `ac.NationCode.Lithuania` @Lithuania.
---| `ac.NationCode.Luxembourg` @Luxembourg.
---| `ac.NationCode.Latvia` @Latvia.
---| `ac.NationCode.Macau` @Macau.
---| `ac.NationCode.Morocco` @Morocco.
---| `ac.NationCode.Monaco` @Monaco.
---| `ac.NationCode.Moldova` @Moldova.
---| `ac.NationCode.Madagascar` @Madagascar.
---| `ac.NationCode.Maldives` @Maldives.
---| `ac.NationCode.Mexico` @Mexico.
---| `ac.NationCode.MarshallIslands` @Marshall Islands.
---| `ac.NationCode.NorthMacedonia` @North Macedonia.
---| `ac.NationCode.Mali` @Mali.
---| `ac.NationCode.Malta` @Malta.
---| `ac.NationCode.Myanmar` @Myanmar.
---| `ac.NationCode.Montenegro` @Montenegro.
---| `ac.NationCode.Mongolia` @Mongolia.
---| `ac.NationCode.Mozambique` @Mozambique.
---| `ac.NationCode.Mauritania` @Mauritania.
---| `ac.NationCode.Montserrat` @Montserrat.
---| `ac.NationCode.Martinique` @Martinique.
---| `ac.NationCode.Mauritius` @Mauritius.
---| `ac.NationCode.Malawi` @Malawi.
---| `ac.NationCode.Malaysia` @Malaysia.
---| `ac.NationCode.Namibia` @Namibia.
---| `ac.NationCode.NewCaledonia` @New Caledonia.
---| `ac.NationCode.Niger` @Niger.
---| `ac.NationCode.Nigeria` @Nigeria.
---| `ac.NationCode.Nicaragua` @Nicaragua.
---| `ac.NationCode.NorthernIreland` @Northern Ireland.
---| `ac.NationCode.Netherlands` @Netherlands.
---| `ac.NationCode.Norway` @Norway.
---| `ac.NationCode.Nepal` @Nepal.
---| `ac.NationCode.Nauru` @Nauru.
---| `ac.NationCode.NewZealand` @New Zealand.
---| `ac.NationCode.Oman` @Oman.
---| `ac.NationCode.Pakistan` @Pakistan.
---| `ac.NationCode.Panama` @Panama.
---| `ac.NationCode.Peru` @Peru.
---| `ac.NationCode.Philippines` @Philippines.
---| `ac.NationCode.Palau` @Palau.
---| `ac.NationCode.PapuaNewGuinea` @Papua New Guinea.
---| `ac.NationCode.Poland` @Poland.
---| `ac.NationCode.PuertoRico` @Puerto Rico.
---| `ac.NationCode.Portugal` @Portugal.
---| `ac.NationCode.Paraguay` @Paraguay.
---| `ac.NationCode.FrenchPolynesia` @French Polynesia.
---| `ac.NationCode.Qatar` @Qatar.
---| `ac.NationCode.Romania` @Romania.
---| `ac.NationCode.Russia` @Russia.
---| `ac.NationCode.Rwanda` @Rwanda.
---| `ac.NationCode.SaudiArabia` @Saudi Arabia.
---| `ac.NationCode.Scotland` @Scotland.
---| `ac.NationCode.Sudan` @Sudan.
---| `ac.NationCode.Senegal` @Senegal.
---| `ac.NationCode.Singapore` @Singapore.
---| `ac.NationCode.SolomonIslands` @Solomon Islands.
---| `ac.NationCode.SierraLeone` @Sierra Leone.
---| `ac.NationCode.ElSalvador` @El Salvador.
---| `ac.NationCode.SanMarino` @San Marino.
---| `ac.NationCode.Somalia` @Somalia.
---| `ac.NationCode.Serbia` @Serbia.
---| `ac.NationCode.SouthSudan` @South Sudan.
---| `ac.NationCode.SaoTomeAndPrincipe` @Sao Tome and Principe.
---| `ac.NationCode.Suriname` @Suriname.
---| `ac.NationCode.Slovakia` @Slovakia.
---| `ac.NationCode.Slovenia` @Slovenia.
---| `ac.NationCode.Sweden` @Sweden.
---| `ac.NationCode.Eswatini` @Eswatini.
---| `ac.NationCode.Seychelles` @Seychelles.
---| `ac.NationCode.Syria` @Syria.
---| `ac.NationCode.TurksAndCaicosIslands` @Turks and Caicos Islands.
---| `ac.NationCode.Chad` @Chad.
---| `ac.NationCode.Togo` @Togo.
---| `ac.NationCode.Thailand` @Thailand.
---| `ac.NationCode.Tajikistan` @Tajikistan.
---| `ac.NationCode.Turkmenistan` @Turkmenistan.
---| `ac.NationCode.TimorLeste` @Timor-Leste.
---| `ac.NationCode.Tonga` @Tonga.
---| `ac.NationCode.TrinidadAndTobago` @Trinidad and Tobago.
---| `ac.NationCode.Tunisia` @Tunisia.
---| `ac.NationCode.Turkiye` @Türkiye.
---| `ac.NationCode.Tuvalu` @Tuvalu.
---| `ac.NationCode.Taiwan` @Taiwan.
---| `ac.NationCode.Tanzania` @Tanzania.
---| `ac.NationCode.Uganda` @Uganda.
---| `ac.NationCode.Ukraine` @Ukraine.
---| `ac.NationCode.Uruguay` @Uruguay.
---| `ac.NationCode.UnitedStates` @United States.
---| `ac.NationCode.Uzbekistan` @Uzbekistan.
---| `ac.NationCode.VaticanCity` @Vatican City.
---| `ac.NationCode.SaintVincentAndTheGrenadines` @Saint Vincent and the Grenadines.
---| `ac.NationCode.Venezuela` @Venezuela.
---| `ac.NationCode.BritishVirginIslands` @British Virgin Islands.
---| `ac.NationCode.USVirginIslands` @US Virgin Islands.
---| `ac.NationCode.Vietnam` @Vietnam.
---| `ac.NationCode.Vanuatu` @Vanuatu.
---| `ac.NationCode.Wales` @Wales.
---| `ac.NationCode.Samoa` @Samoa.
---| `ac.NationCode.Kosovo` @Kosovo.
---| `ac.NationCode.Yemen` @Yemen.
---| `ac.NationCode.SouthAfrica` @South Africa.
---| `ac.NationCode.Zambia` @Zambia.
---| `ac.NationCode.Zimbabwe` @Zimbabwe.
ac.NationCode = {
  Aruba = 'ABW', ---@type ac.NationCode #Aruba.
  Afghanistan = 'AFG', ---@type ac.NationCode #Afghanistan.
  Angola = 'AGO', ---@type ac.NationCode #Angola.
  Anguilla = 'AIA', ---@type ac.NationCode #Anguilla.
  Albania = 'ALB', ---@type ac.NationCode #Albania.
  Andorra = 'AND', ---@type ac.NationCode #Andorra.
  UnitedArabEmirates = 'ARE', ---@type ac.NationCode #United Arab Emirates.
  Argentina = 'ARG', ---@type ac.NationCode #Argentina.
  Armenia = 'ARM', ---@type ac.NationCode #Armenia.
  AmericanSamoa = 'ASM', ---@type ac.NationCode #American Samoa.
  Antarctica = 'ATA', ---@type ac.NationCode #Antarctica.
  AntiguaAndBarbuda = 'ATG', ---@type ac.NationCode #Antigua and Barbuda.
  Australia = 'AUS', ---@type ac.NationCode #Australia.
  Austria = 'AUT', ---@type ac.NationCode #Austria.
  Azerbaijan = 'AZE', ---@type ac.NationCode #Azerbaijan.
  Burundi = 'BDI', ---@type ac.NationCode #Burundi.
  Belgium = 'BEL', ---@type ac.NationCode #Belgium.
  Benin = 'BEN', ---@type ac.NationCode #Benin.
  BurkinaFaso = 'BFA', ---@type ac.NationCode #Burkina Faso.
  Bangladesh = 'BGD', ---@type ac.NationCode #Bangladesh.
  Bulgaria = 'BGR', ---@type ac.NationCode #Bulgaria.
  Bahrain = 'BHR', ---@type ac.NationCode #Bahrain.
  Bahamas = 'BHS', ---@type ac.NationCode #Bahamas.
  BosniaAndHerzegovina = 'BIH', ---@type ac.NationCode #Bosnia and Herzegovina.
  Belarus = 'BLR', ---@type ac.NationCode #Belarus.
  Belize = 'BLZ', ---@type ac.NationCode #Belize.
  Bermuda = 'BMU', ---@type ac.NationCode #Bermuda.
  Bolivia = 'BOL', ---@type ac.NationCode #Bolivia.
  Brazil = 'BRA', ---@type ac.NationCode #Brazil.
  Barbados = 'BRB', ---@type ac.NationCode #Barbados.
  Brunei = 'BRN', ---@type ac.NationCode #Brunei.
  Bhutan = 'BTN', ---@type ac.NationCode #Bhutan.
  Botswana = 'BWA', ---@type ac.NationCode #Botswana.
  CentralAfricanRepublic = 'CAF', ---@type ac.NationCode #Central African Republic.
  Canada = 'CAN', ---@type ac.NationCode #Canada.
  CocosIslands = 'CCK', ---@type ac.NationCode #Cocos Islands.
  Switzerland = 'CHE', ---@type ac.NationCode #Switzerland.
  Chile = 'CHL', ---@type ac.NationCode #Chile.
  China = 'CHN', ---@type ac.NationCode #China.
  CoteDIvoire = 'CIV', ---@type ac.NationCode #Côte d’Ivoire.
  Cameroon = 'CMR', ---@type ac.NationCode #Cameroon.
  DemocraticRepublicOfTheCongo = 'COD', ---@type ac.NationCode #Democratic Republic of the Congo.
  RepublicOfTheCongo = 'COG', ---@type ac.NationCode #Republic of the Congo.
  CookIslands = 'COK', ---@type ac.NationCode #Cook Islands.
  Colombia = 'COL', ---@type ac.NationCode #Colombia.
  Comoros = 'COM', ---@type ac.NationCode #Comoros.
  CapeVerde = 'CPV', ---@type ac.NationCode #Cape Verde.
  CostaRica = 'CRI', ---@type ac.NationCode #Costa Rica.
  Cuba = 'CUB', ---@type ac.NationCode #Cuba.
  CaymanIslands = 'CYM', ---@type ac.NationCode #Cayman Islands.
  Cyprus = 'CYP', ---@type ac.NationCode #Cyprus.
  Czechia = 'CZE', ---@type ac.NationCode #Czechia.
  Germany = 'DEU', ---@type ac.NationCode #Germany.
  Djibouti = 'DJI', ---@type ac.NationCode #Djibouti.
  Dominica = 'DMA', ---@type ac.NationCode #Dominica.
  Denmark = 'DNK', ---@type ac.NationCode #Denmark.
  DominicanRepublic = 'DOM', ---@type ac.NationCode #Dominican Republic.
  Algeria = 'DZA', ---@type ac.NationCode #Algeria.
  Ecuador = 'ECU', ---@type ac.NationCode #Ecuador.
  Egypt = 'EGY', ---@type ac.NationCode #Egypt.
  England = 'ENG', ---@type ac.NationCode #England.
  Eritrea = 'ERI', ---@type ac.NationCode #Eritrea.
  WesternSahara = 'ESH', ---@type ac.NationCode #Western Sahara.
  Spain = 'ESP', ---@type ac.NationCode #Spain.
  Estonia = 'EST', ---@type ac.NationCode #Estonia.
  Ethiopia = 'ETH', ---@type ac.NationCode #Ethiopia.
  Finland = 'FIN', ---@type ac.NationCode #Finland.
  Fiji = 'FJI', ---@type ac.NationCode #Fiji.
  France = 'FRA', ---@type ac.NationCode #France.
  FaroeIslands = 'FRO', ---@type ac.NationCode #Faroe Islands.
  Micronesia = 'FSM', ---@type ac.NationCode #Micronesia.
  Gabon = 'GAB', ---@type ac.NationCode #Gabon.
  UnitedKingdom = 'GBR', ---@type ac.NationCode #United Kingdom.
  Georgia = 'GEO', ---@type ac.NationCode #Georgia.
  Guernsey = 'GGY', ---@type ac.NationCode #Guernsey.
  Ghana = 'GHA', ---@type ac.NationCode #Ghana.
  Gibraltar = 'GIB', ---@type ac.NationCode #Gibraltar.
  Guinea = 'GIN', ---@type ac.NationCode #Guinea.
  Gambia = 'GMB', ---@type ac.NationCode #Gambia.
  GuineaBissau = 'GNB', ---@type ac.NationCode #Guinea-Bissau.
  EquatorialGuinea = 'GNQ', ---@type ac.NationCode #Equatorial Guinea.
  Greece = 'GRC', ---@type ac.NationCode #Greece.
  Grenada = 'GRD', ---@type ac.NationCode #Grenada.
  Greenland = 'GRL', ---@type ac.NationCode #Greenland.
  Guatemala = 'GTM', ---@type ac.NationCode #Guatemala.
  Guam = 'GUM', ---@type ac.NationCode #Guam.
  Guyana = 'GUY', ---@type ac.NationCode #Guyana.
  HongKong = 'HKG', ---@type ac.NationCode #Hong Kong.
  Honduras = 'HND', ---@type ac.NationCode #Honduras.
  Croatia = 'HRV', ---@type ac.NationCode #Croatia.
  Haiti = 'HTI', ---@type ac.NationCode #Haiti.
  Hungary = 'HUN', ---@type ac.NationCode #Hungary.
  Indonesia = 'IDN', ---@type ac.NationCode #Indonesia.
  IsleOfMan = 'IMN', ---@type ac.NationCode #Isle of Man.
  India = 'IND', ---@type ac.NationCode #India.
  Ireland = 'IRL', ---@type ac.NationCode #Ireland.
  Iran = 'IRN', ---@type ac.NationCode #Iran.
  Iraq = 'IRQ', ---@type ac.NationCode #Iraq.
  Iceland = 'ISL', ---@type ac.NationCode #Iceland.
  Israel = 'ISR', ---@type ac.NationCode #Israel.
  Italy = 'ITA', ---@type ac.NationCode #Italy.
  Jamaica = 'JAM', ---@type ac.NationCode #Jamaica.
  Jersey = 'JEY', ---@type ac.NationCode #Jersey.
  Jordan = 'JOR', ---@type ac.NationCode #Jordan.
  Japan = 'JPN', ---@type ac.NationCode #Japan.
  Kazakhstan = 'KAZ', ---@type ac.NationCode #Kazakhstan.
  Kenya = 'KEN', ---@type ac.NationCode #Kenya.
  Kyrgyzstan = 'KGZ', ---@type ac.NationCode #Kyrgyzstan.
  Cambodia = 'KHM', ---@type ac.NationCode #Cambodia.
  Kiribati = 'KIR', ---@type ac.NationCode #Kiribati.
  SaintKittsAndNevis = 'KNA', ---@type ac.NationCode #Saint Kitts and Nevis.
  SouthKorea = 'KOR', ---@type ac.NationCode #South Korea.
  Kuwait = 'KWT', ---@type ac.NationCode #Kuwait.
  Laos = 'LAO', ---@type ac.NationCode #Laos.
  Lebanon = 'LBN', ---@type ac.NationCode #Lebanon.
  Liberia = 'LBR', ---@type ac.NationCode #Liberia.
  Libya = 'LBY', ---@type ac.NationCode #Libya.
  SaintLucia = 'LCA', ---@type ac.NationCode #Saint Lucia.
  Liechtenstein = 'LIE', ---@type ac.NationCode #Liechtenstein.
  SriLanka = 'LKA', ---@type ac.NationCode #Sri Lanka.
  Lesotho = 'LSO', ---@type ac.NationCode #Lesotho.
  Lithuania = 'LTU', ---@type ac.NationCode #Lithuania.
  Luxembourg = 'LUX', ---@type ac.NationCode #Luxembourg.
  Latvia = 'LVA', ---@type ac.NationCode #Latvia.
  Macau = 'MAC', ---@type ac.NationCode #Macau.
  Morocco = 'MAR', ---@type ac.NationCode #Morocco.
  Monaco = 'MCO', ---@type ac.NationCode #Monaco.
  Moldova = 'MDA', ---@type ac.NationCode #Moldova.
  Madagascar = 'MDG', ---@type ac.NationCode #Madagascar.
  Maldives = 'MDV', ---@type ac.NationCode #Maldives.
  Mexico = 'MEX', ---@type ac.NationCode #Mexico.
  MarshallIslands = 'MHL', ---@type ac.NationCode #Marshall Islands.
  NorthMacedonia = 'MKD', ---@type ac.NationCode #North Macedonia.
  Mali = 'MLI', ---@type ac.NationCode #Mali.
  Malta = 'MLT', ---@type ac.NationCode #Malta.
  Myanmar = 'MMR', ---@type ac.NationCode #Myanmar.
  Montenegro = 'MNE', ---@type ac.NationCode #Montenegro.
  Mongolia = 'MNG', ---@type ac.NationCode #Mongolia.
  Mozambique = 'MOZ', ---@type ac.NationCode #Mozambique.
  Mauritania = 'MRT', ---@type ac.NationCode #Mauritania.
  Montserrat = 'MSR', ---@type ac.NationCode #Montserrat.
  Martinique = 'MTQ', ---@type ac.NationCode #Martinique.
  Mauritius = 'MUS', ---@type ac.NationCode #Mauritius.
  Malawi = 'MWI', ---@type ac.NationCode #Malawi.
  Malaysia = 'MYS', ---@type ac.NationCode #Malaysia.
  Namibia = 'NAM', ---@type ac.NationCode #Namibia.
  NewCaledonia = 'NCL', ---@type ac.NationCode #New Caledonia.
  Niger = 'NER', ---@type ac.NationCode #Niger.
  Nigeria = 'NGA', ---@type ac.NationCode #Nigeria.
  Nicaragua = 'NIC', ---@type ac.NationCode #Nicaragua.
  NorthernIreland = 'NIR', ---@type ac.NationCode #Northern Ireland.
  Netherlands = 'NLD', ---@type ac.NationCode #Netherlands.
  Norway = 'NOR', ---@type ac.NationCode #Norway.
  Nepal = 'NPL', ---@type ac.NationCode #Nepal.
  Nauru = 'NRU', ---@type ac.NationCode #Nauru.
  NewZealand = 'NZL', ---@type ac.NationCode #New Zealand.
  Oman = 'OMN', ---@type ac.NationCode #Oman.
  Pakistan = 'PAK', ---@type ac.NationCode #Pakistan.
  Panama = 'PAN', ---@type ac.NationCode #Panama.
  Peru = 'PER', ---@type ac.NationCode #Peru.
  Philippines = 'PHL', ---@type ac.NationCode #Philippines.
  Palau = 'PLW', ---@type ac.NationCode #Palau.
  PapuaNewGuinea = 'PNG', ---@type ac.NationCode #Papua New Guinea.
  Poland = 'POL', ---@type ac.NationCode #Poland.
  PuertoRico = 'PRI', ---@type ac.NationCode #Puerto Rico.
  Portugal = 'PRT', ---@type ac.NationCode #Portugal.
  Paraguay = 'PRY', ---@type ac.NationCode #Paraguay.
  FrenchPolynesia = 'PYF', ---@type ac.NationCode #French Polynesia.
  Qatar = 'QAT', ---@type ac.NationCode #Qatar.
  Romania = 'ROU', ---@type ac.NationCode #Romania.
  Russia = 'RUS', ---@type ac.NationCode #Russia.
  Rwanda = 'RWA', ---@type ac.NationCode #Rwanda.
  SaudiArabia = 'SAU', ---@type ac.NationCode #Saudi Arabia.
  Scotland = 'SCT', ---@type ac.NationCode #Scotland.
  Sudan = 'SDN', ---@type ac.NationCode #Sudan.
  Senegal = 'SEN', ---@type ac.NationCode #Senegal.
  Singapore = 'SGP', ---@type ac.NationCode #Singapore.
  SolomonIslands = 'SLB', ---@type ac.NationCode #Solomon Islands.
  SierraLeone = 'SLE', ---@type ac.NationCode #Sierra Leone.
  ElSalvador = 'SLV', ---@type ac.NationCode #El Salvador.
  SanMarino = 'SMR', ---@type ac.NationCode #San Marino.
  Somalia = 'SOM', ---@type ac.NationCode #Somalia.
  Serbia = 'SRB', ---@type ac.NationCode #Serbia.
  SouthSudan = 'SSD', ---@type ac.NationCode #South Sudan.
  SaoTomeAndPrincipe = 'STP', ---@type ac.NationCode #Sao Tome and Principe.
  Suriname = 'SUR', ---@type ac.NationCode #Suriname.
  Slovakia = 'SVK', ---@type ac.NationCode #Slovakia.
  Slovenia = 'SVN', ---@type ac.NationCode #Slovenia.
  Sweden = 'SWE', ---@type ac.NationCode #Sweden.
  Eswatini = 'SWZ', ---@type ac.NationCode #Eswatini.
  Seychelles = 'SYC', ---@type ac.NationCode #Seychelles.
  Syria = 'SYR', ---@type ac.NationCode #Syria.
  TurksAndCaicosIslands = 'TCA', ---@type ac.NationCode #Turks and Caicos Islands.
  Chad = 'TCD', ---@type ac.NationCode #Chad.
  Togo = 'TGO', ---@type ac.NationCode #Togo.
  Thailand = 'THA', ---@type ac.NationCode #Thailand.
  Tajikistan = 'TJK', ---@type ac.NationCode #Tajikistan.
  Turkmenistan = 'TKM', ---@type ac.NationCode #Turkmenistan.
  TimorLeste = 'TLS', ---@type ac.NationCode #Timor-Leste.
  Tonga = 'TON', ---@type ac.NationCode #Tonga.
  TrinidadAndTobago = 'TTO', ---@type ac.NationCode #Trinidad and Tobago.
  Tunisia = 'TUN', ---@type ac.NationCode #Tunisia.
  Turkiye = 'TUR', ---@type ac.NationCode #Türkiye.
  Tuvalu = 'TUV', ---@type ac.NationCode #Tuvalu.
  Taiwan = 'TWN', ---@type ac.NationCode #Taiwan.
  Tanzania = 'TZA', ---@type ac.NationCode #Tanzania.
  Uganda = 'UGA', ---@type ac.NationCode #Uganda.
  Ukraine = 'UKR', ---@type ac.NationCode #Ukraine.
  Uruguay = 'URY', ---@type ac.NationCode #Uruguay.
  UnitedStates = 'USA', ---@type ac.NationCode #United States.
  Uzbekistan = 'UZB', ---@type ac.NationCode #Uzbekistan.
  VaticanCity = 'VAT', ---@type ac.NationCode #Vatican City.
  SaintVincentAndTheGrenadines = 'VCT', ---@type ac.NationCode #Saint Vincent and the Grenadines.
  Venezuela = 'VEN', ---@type ac.NationCode #Venezuela.
  BritishVirginIslands = 'VGB', ---@type ac.NationCode #British Virgin Islands.
  USVirginIslands = 'VIR', ---@type ac.NationCode #US Virgin Islands.
  Vietnam = 'VNM', ---@type ac.NationCode #Vietnam.
  Vanuatu = 'VUT', ---@type ac.NationCode #Vanuatu.
  Wales = 'WLS', ---@type ac.NationCode #Wales.
  Samoa = 'WSM', ---@type ac.NationCode #Samoa.
  Kosovo = 'XKX', ---@type ac.NationCode #Kosovo.
  Yemen = 'YEM', ---@type ac.NationCode #Yemen.
  SouthAfrica = 'ZAF', ---@type ac.NationCode #South Africa.
  Zambia = 'ZMB', ---@type ac.NationCode #Zambia.
  Zimbabwe = 'ZWE', ---@type ac.NationCode #Zimbabwe.
}

---@alias ac.CSPModuleID
---| `ac.CSPModuleID.CarInstruments` @Value: 'car_instruments'.
---| `ac.CSPModuleID.ChaserCamera` @Value: 'chaser_camera'.
---| `ac.CSPModuleID.ChatShortcuts` @Value: 'chat_shortcuts'.
---| `ac.CSPModuleID.CustomRenderingModes` @Value: 'custom_rendering_modes'.
---| `ac.CSPModuleID.DXGITweaks` @Value: 'dxgi_tweaks'.
---| `ac.CSPModuleID.ExtraFX` @Value: 'extra_fx'.
---| `ac.CSPModuleID.FFBTweaks` @Value: 'ffb_tweaks'.
---| `ac.CSPModuleID.FreerCamera` @Value: 'freer_camera'.
---| `ac.CSPModuleID.G27Lights` @Value: 'g27_lights'.
---| `ac.CSPModuleID.GamepadFX` @Value: 'gamepad_fx'.
---| `ac.CSPModuleID.General` @Value: 'general'.
---| `ac.CSPModuleID.GraphicsAdjustments` @Value: 'graphics_adjustments'.
---| `ac.CSPModuleID.GrassFX` @Value: 'grass_fx'.
---| `ac.CSPModuleID.GUI` @Value: 'gui'.
---| `ac.CSPModuleID.LightingFX` @Value: 'lighting_fx'.
---| `ac.CSPModuleID.Music` @Value: 'music'.
---| `ac.CSPModuleID.NeckFX` @Value: 'neck'.
---| `ac.CSPModuleID.NewBehaviour` @Value: 'new_behaviour'.
---| `ac.CSPModuleID.NiceScreenshots` @Value: 'nice_screenshots'.
---| `ac.CSPModuleID.ParticlesFX` @Value: 'particles_fx'.
---| `ac.CSPModuleID.RainFX` @Value: 'rain_fx'.
---| `ac.CSPModuleID.ReflectionsFX` @Value: 'reflections_fx'.
---| `ac.CSPModuleID.SkidmarksFX` @Value: 'skidmarks_fx'.
---| `ac.CSPModuleID.SmallTweaks` @Value: 'small_tweaks'.
---| `ac.CSPModuleID.SmartMirror` @Value: 'smart_mirror'.
---| `ac.CSPModuleID.SmartShadows` @Value: 'smart_shadows'.
---| `ac.CSPModuleID.Splashscreen` @Value: 'splashscreen'.
---| `ac.CSPModuleID.SurfacesFX` @Value: 'surfaces_fx'.
---| `ac.CSPModuleID.Taskbar` @Value: 'taskbar'.
---| `ac.CSPModuleID.TrackAdjustments` @Value: 'track_adjustments'.
---| `ac.CSPModuleID.TripleCustom` @Value: 'triple_custom'.
---| `ac.CSPModuleID.TyresFX` @Value: 'tyres_fx'.
---| `ac.CSPModuleID.VRTweaks` @Value: 'vr_tweaks'.
---| `ac.CSPModuleID.WeatherFX` @Value: 'weather_fx'.
---| `ac.CSPModuleID.WindscreenFX` @Value: 'windscreen_fx'.
---| `ac.CSPModuleID.Yebisest` @Value: 'yebisest'.
ac.CSPModuleID = {
  CarInstruments = 'car_instruments', ---@type ac.CSPModuleID #Value: 'car_instruments'.
  ChaserCamera = 'chaser_camera', ---@type ac.CSPModuleID #Value: 'chaser_camera'.
  ChatShortcuts = 'chat_shortcuts', ---@type ac.CSPModuleID #Value: 'chat_shortcuts'.
  CustomRenderingModes = 'custom_rendering_modes', ---@type ac.CSPModuleID #Value: 'custom_rendering_modes'.
  DXGITweaks = 'dxgi_tweaks', ---@type ac.CSPModuleID #Value: 'dxgi_tweaks'.
  ExtraFX = 'extra_fx', ---@type ac.CSPModuleID #Value: 'extra_fx'.
  FFBTweaks = 'ffb_tweaks', ---@type ac.CSPModuleID #Value: 'ffb_tweaks'.
  FreerCamera = 'freer_camera', ---@type ac.CSPModuleID #Value: 'freer_camera'.
  G27Lights = 'g27_lights', ---@type ac.CSPModuleID #Value: 'g27_lights'.
  GamepadFX = 'gamepad_fx', ---@type ac.CSPModuleID #Value: 'gamepad_fx'.
  General = 'general', ---@type ac.CSPModuleID #Value: 'general'.
  GraphicsAdjustments = 'graphics_adjustments', ---@type ac.CSPModuleID #Value: 'graphics_adjustments'.
  GrassFX = 'grass_fx', ---@type ac.CSPModuleID #Value: 'grass_fx'.
  GUI = 'gui', ---@type ac.CSPModuleID #Value: 'gui'.
  LightingFX = 'lighting_fx', ---@type ac.CSPModuleID #Value: 'lighting_fx'.
  Music = 'music', ---@type ac.CSPModuleID #Value: 'music'.
  NeckFX = 'neck', ---@type ac.CSPModuleID #Value: 'neck'.
  NewBehaviour = 'new_behaviour', ---@type ac.CSPModuleID #Value: 'new_behaviour'.
  NiceScreenshots = 'nice_screenshots', ---@type ac.CSPModuleID #Value: 'nice_screenshots'.
  ParticlesFX = 'particles_fx', ---@type ac.CSPModuleID #Value: 'particles_fx'.
  RainFX = 'rain_fx', ---@type ac.CSPModuleID #Value: 'rain_fx'.
  ReflectionsFX = 'reflections_fx', ---@type ac.CSPModuleID #Value: 'reflections_fx'.
  SkidmarksFX = 'skidmarks_fx', ---@type ac.CSPModuleID #Value: 'skidmarks_fx'.
  SmallTweaks = 'small_tweaks', ---@type ac.CSPModuleID #Value: 'small_tweaks'.
  SmartMirror = 'smart_mirror', ---@type ac.CSPModuleID #Value: 'smart_mirror'.
  SmartShadows = 'smart_shadows', ---@type ac.CSPModuleID #Value: 'smart_shadows'.
  Splashscreen = 'splashscreen', ---@type ac.CSPModuleID #Value: 'splashscreen'.
  SurfacesFX = 'surfaces_fx', ---@type ac.CSPModuleID #Value: 'surfaces_fx'.
  Taskbar = 'taskbar', ---@type ac.CSPModuleID #Value: 'taskbar'.
  TrackAdjustments = 'track_adjustments', ---@type ac.CSPModuleID #Value: 'track_adjustments'.
  TripleCustom = 'triple_custom', ---@type ac.CSPModuleID #Value: 'triple_custom'.
  TyresFX = 'tyres_fx', ---@type ac.CSPModuleID #Value: 'tyres_fx'.
  VRTweaks = 'vr_tweaks', ---@type ac.CSPModuleID #Value: 'vr_tweaks'.
  WeatherFX = 'weather_fx', ---@type ac.CSPModuleID #Value: 'weather_fx'.
  WindscreenFX = 'windscreen_fx', ---@type ac.CSPModuleID #Value: 'windscreen_fx'.
  Yebisest = 'yebisest', ---@type ac.CSPModuleID #Value: 'yebisest'.
}

---@alias ac.ObjectClass
---| `ac.ObjectClass.Any` @Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
---| `ac.ObjectClass.Node` @Regular children-holding objects.
---| `ac.ObjectClass.Model` @Track objects.
---| `ac.ObjectClass.CarNodeSorter` @An object holding cars.
---| `ac.ObjectClass.NodeBoundingSphere` @A wrapper for each car, skipping rendering if whole thing is not in frustum.
---| `ac.ObjectClass.IdealLine` @Ideal line.
---| `ac.ObjectClass.ParticleSystem` @Particle systems (don’t do much with ParticlesFX active).
---| `ac.ObjectClass.StaticParticleSystem` @Usually used for spectators.
---| `ac.ObjectClass.DisplayNode` @Display nodes for car dashboards.
---| `ac.ObjectClass.TextNode` @3D text nodes for car dashboards.
---| `ac.ObjectClass.CSPNode` @CSP nodes, for example fake shadow nodes.
---| `ac.ObjectClass.Renderable` @Refers to meshes and skinned meshes together.
---| `ac.ObjectClass.Mesh` @Regular meshes.
---| `ac.ObjectClass.SkinnedMesh` @Skinned meshes.
---| `ac.ObjectClass.SkidmarkBuffer` @Objects with skidmarks (don’t do much with SkidmarksFX active).
ac.ObjectClass = {
  Any = 0, ---@type ac.ObjectClass #Return any scene object. If returned as result from `:class()`, means that there is no object with such index.
  Node = 1, ---@type ac.ObjectClass #Regular children-holding objects.
  Model = 2, ---@type ac.ObjectClass #Track objects.
  CarNodeSorter = 3, ---@type ac.ObjectClass #An object holding cars.
  NodeBoundingSphere = 4, ---@type ac.ObjectClass #A wrapper for each car, skipping rendering if whole thing is not in frustum.
  IdealLine = 7, ---@type ac.ObjectClass #Ideal line.
  ParticleSystem = 8, ---@type ac.ObjectClass #Particle systems (don’t do much with ParticlesFX active).
  StaticParticleSystem = 9, ---@type ac.ObjectClass #Usually used for spectators.
  DisplayNode = 10, ---@type ac.ObjectClass #Display nodes for car dashboards.
  TextNode = 11, ---@type ac.ObjectClass #3D text nodes for car dashboards.
  CSPNode = 12, ---@type ac.ObjectClass #CSP nodes, for example fake shadow nodes.
  Renderable = 13, ---@type ac.ObjectClass #Refers to meshes and skinned meshes together.
  Mesh = 15, ---@type ac.ObjectClass #Regular meshes.
  SkinnedMesh = 16, ---@type ac.ObjectClass #Skinned meshes.
  SkidmarkBuffer = 17, ---@type ac.ObjectClass #Objects with skidmarks (don’t do much with SkidmarksFX active).
}

---@alias ac.GamepadButton
---| `ac.GamepadButton.DPadUp` @Value: 0x1.
---| `ac.GamepadButton.DPadDown` @Value: 0x2.
---| `ac.GamepadButton.DPadLeft` @Value: 0x4.
---| `ac.GamepadButton.DPadRight` @Value: 0x8.
---| `ac.GamepadButton.Start` @Value: 0x10.
---| `ac.GamepadButton.Back` @Value: 0x20.
---| `ac.GamepadButton.LeftThumb` @Value: 0x40.
---| `ac.GamepadButton.RightThumb` @Value: 0x80.
---| `ac.GamepadButton.LeftShoulder` @Value: 0x100.
---| `ac.GamepadButton.RightShoulder` @Value: 0x200.
---| `ac.GamepadButton.L2` @Only for DualShock and Nintendo (ZL) gamepads.
---| `ac.GamepadButton.R2` @Only for DualShock and Nintendo (ZR) gamepads.
---| `ac.GamepadButton.A` @Value: 0x1000.
---| `ac.GamepadButton.B` @Value: 0x2000.
---| `ac.GamepadButton.X` @Value: 0x4000.
---| `ac.GamepadButton.Y` @Value: 0x8000.
---| `ac.GamepadButton.PlayStation` @Only for DualShock, DualSense and Nintendo (Home button) gamepads.
---| `ac.GamepadButton.Microphone` @Only for DualSense and Nintendo (SL button) gamepads.
---| `ac.GamepadButton.Pad` @Only for DualShock, DualSense and Nintendo (Capture button) gamepads.
---| `ac.GamepadButton.Extra` @Only for Nintendo (SR button) gamepads.
ac.GamepadButton = {
  DPadUp = 0x1, ---@type ac.GamepadButton #Value: 0x1.
  DPadDown = 0x2, ---@type ac.GamepadButton #Value: 0x2.
  DPadLeft = 0x4, ---@type ac.GamepadButton #Value: 0x4.
  DPadRight = 0x8, ---@type ac.GamepadButton #Value: 0x8.
  Start = 0x10, ---@type ac.GamepadButton #Value: 0x10.
  Back = 0x20, ---@type ac.GamepadButton #Value: 0x20.
  LeftThumb = 0x40, ---@type ac.GamepadButton #Value: 0x40.
  RightThumb = 0x80, ---@type ac.GamepadButton #Value: 0x80.
  LeftShoulder = 0x100, ---@type ac.GamepadButton #Value: 0x100.
  RightShoulder = 0x200, ---@type ac.GamepadButton #Value: 0x200.
  L2 = 0x400, ---@type ac.GamepadButton #Only for DualShock and Nintendo (ZL) gamepads.
  R2 = 0x800, ---@type ac.GamepadButton #Only for DualShock and Nintendo (ZR) gamepads.
  A = 0x1000, ---@type ac.GamepadButton #Value: 0x1000.
  B = 0x2000, ---@type ac.GamepadButton #Value: 0x2000.
  X = 0x4000, ---@type ac.GamepadButton #Value: 0x4000.
  Y = 0x8000, ---@type ac.GamepadButton #Value: 0x8000.
  PlayStation = 0x10000, ---@type ac.GamepadButton #Only for DualShock, DualSense and Nintendo (Home button) gamepads.
  Microphone = 0x20000, ---@type ac.GamepadButton #Only for DualSense and Nintendo (SL button) gamepads.
  Pad = 0x40000, ---@type ac.GamepadButton #Only for DualShock, DualSense and Nintendo (Capture button) gamepads.
  Extra = 0x80000, ---@type ac.GamepadButton #Only for Nintendo (SR button) gamepads.
}

---@alias ac.GamepadAxis
---| `ac.GamepadAxis.LeftTrigger` @Value: 0.
---| `ac.GamepadAxis.RightTrigger` @Value: 1.
---| `ac.GamepadAxis.LeftThumbX` @Value: 2.
---| `ac.GamepadAxis.LeftThumbY` @Value: 3.
---| `ac.GamepadAxis.RightThumbX` @Value: 4.
---| `ac.GamepadAxis.RightThumbY` @Value: 5.
ac.GamepadAxis = {
  LeftTrigger = 0, ---@type ac.GamepadAxis #Value: 0.
  RightTrigger = 1, ---@type ac.GamepadAxis #Value: 1.
  LeftThumbX = 2, ---@type ac.GamepadAxis #Value: 2.
  LeftThumbY = 3, ---@type ac.GamepadAxis #Value: 3.
  RightThumbX = 4, ---@type ac.GamepadAxis #Value: 4.
  RightThumbY = 5, ---@type ac.GamepadAxis #Value: 5.
}

---@alias ac.GamepadType
---| `ac.GamepadType.None` @No gamepad in that slot.
---| `ac.GamepadType.XBox` @Regular XBox gamepad.
---| `ac.GamepadType.DualSense` @DualSense gamepad.
---| `ac.GamepadType.DualShock` @DualShock gamepad (can also be one of Nintendo gamepads; use `ac.getDualShock(…).type` to check).
ac.GamepadType = {
  None = 0, ---@type ac.GamepadType #No gamepad in that slot.
  XBox = 1, ---@type ac.GamepadType #Regular XBox gamepad.
  DualSense = 2, ---@type ac.GamepadType #DualSense gamepad.
  DualShock = 3, ---@type ac.GamepadType #DualShock gamepad (can also be one of Nintendo gamepads; use `ac.getDualShock(…).type` to check).
}

---Due to compatibility issues DualShock and Nintendo devices are combined in an alternative API area separately from DualSense.
---@alias ac.GamepadDualShockType
---| `ac.GamepadDualShockType.JoyConLeft` @Left Joy-Con.
---| `ac.GamepadDualShockType.JoyConRight` @Right Joy-Con.
---| `ac.GamepadDualShockType.SwitchPro` @Switch Pro Controller.
---| `ac.GamepadDualShockType.DualShock` @DualShock 4.
---| `ac.GamepadDualShockType.DualSense` @DualSense (can appear here if controller is configured to launch in DualShock mode in CM controls settings).
ac.GamepadDualShockType = {
  JoyConLeft = 1, ---@type ac.GamepadDualShockType #Left Joy-Con.
  JoyConRight = 2, ---@type ac.GamepadDualShockType #Right Joy-Con.
  SwitchPro = 3, ---@type ac.GamepadDualShockType #Switch Pro Controller.
  DualShock = 4, ---@type ac.GamepadDualShockType #DualShock 4.
  DualSense = 5, ---@type ac.GamepadDualShockType #DualSense (can appear here if controller is configured to launch in DualShock mode in CM controls settings).
}

---@alias os.DialogFlags
---| `os.DialogFlags.None` @Value: 0.
---| `os.DialogFlags.OverwritePrompt` @When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
---| `os.DialogFlags.StrictFileTypes` @In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
---| `os.DialogFlags.NoChangeDir` @Don't change the current working directory.
---| `os.DialogFlags.PickFolders` @Present an Open dialog that offers a choice of folders rather than files.
---| `os.DialogFlags.ForceFileSystem` @Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
---| `os.DialogFlags.AllNonStorageItems` @Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
---| `os.DialogFlags.NoValidate` @Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
---| `os.DialogFlags.AllowMultiselect` @Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
---| `os.DialogFlags.PathMustExist` @The item returned must be in an existing folder. This is a default value.
---| `os.DialogFlags.FileMustExist` @The item returned must exist. This is a default value for the Open dialog.
---| `os.DialogFlags.CreatePrompt` @Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
---| `os.DialogFlags.ShareAware` @In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
---| `os.DialogFlags.NoReadonlyReturn` @Do not return read-only items. This is a default value for the Save dialog.
---| `os.DialogFlags.NoTestFileCreate` @Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
---| `os.DialogFlags.HideMRUPlaces` @Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
---| `os.DialogFlags.HidePinnedPlaces` @Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
---| `os.DialogFlags.NoDereferenceLinks` @Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
---| `os.DialogFlags.OkButtonNeedsInteraction` @The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
---| `os.DialogFlags.DontAddToRecent` @Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
---| `os.DialogFlags.ForceShowHidden` @Include hidden and system items.
---| `os.DialogFlags.DefaultNoMiniMode` @Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
---| `os.DialogFlags.ForcePreviewPaneOn` @Indicates to the Open dialog box that the preview pane should always be displayed.
---| `os.DialogFlags.SupportStreamableItems` @Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
os.DialogFlags = {
  None = 0, ---@type os.DialogFlags #Value: 0.
  OverwritePrompt = 2, ---@type os.DialogFlags #When saving a file, prompt before overwriting an existing file of the same name. This is a default value for the Save dialog.
  StrictFileTypes = 4, ---@type os.DialogFlags #In the Save dialog, only allow the user to choose a file that has one of the file name extensions specified through IFileDialog::SetFileTypes.
  NoChangeDir = 8, ---@type os.DialogFlags #Don't change the current working directory.
  PickFolders = 32, ---@type os.DialogFlags #Present an Open dialog that offers a choice of folders rather than files.
  ForceFileSystem = 64, ---@type os.DialogFlags #Ensures that returned items are file system items (SFGAO_FILESYSTEM). Note that this does not apply to items returned by IFileDialog::GetCurrentSelection.
  AllNonStorageItems = 128, ---@type os.DialogFlags #Enables the user to choose any item in the Shell namespace, not just those with SFGAO_STREAM or SFAGO_FILESYSTEM attributes. This flag cannot be combined with FOS_FORCEFILESYSTEM.
  NoValidate = 256, ---@type os.DialogFlags #Do not check for situations that would prevent an application from opening the selected file, such as sharing violations or access denied errors.
  AllowMultiselect = 512, ---@type os.DialogFlags #Enables the user to select multiple items in the open dialog. Note that when this flag is set, the IFileOpenDialog interface must be used to retrieve those items.
  PathMustExist = 2048, ---@type os.DialogFlags #The item returned must be in an existing folder. This is a default value.
  FileMustExist = 4096, ---@type os.DialogFlags #The item returned must exist. This is a default value for the Open dialog.
  CreatePrompt = 8192, ---@type os.DialogFlags #Prompt for creation if the item returned in the save dialog does not exist. Note that this does not actually create the item.
  ShareAware = 16384, ---@type os.DialogFlags #In the case of a sharing violation when an application is opening a file, call the application back through OnShareViolation for guidance. This flag is overridden by FOS_NOVALIDATE.
  NoReadonlyReturn = 32768, ---@type os.DialogFlags #Do not return read-only items. This is a default value for the Save dialog.
  NoTestFileCreate = 65536, ---@type os.DialogFlags #Do not test whether creation of the item as specified in the Save dialog will be successful. If this flag is not set, the calling application must handle errors, such as denial of access, discovered when the item is created.
  HideMRUPlaces = 131072, ---@type os.DialogFlags #Hide the list of places from which the user has recently opened or saved items. This value is not supported as of Windows 7.
  HidePinnedPlaces = 262144, ---@type os.DialogFlags #Hide items shown by default in the view's navigation pane. This flag is often used in conjunction with the IFileDialog::AddPlace method, to hide standard locations and replace them with custom locations.\n\nWindows 7 and later. Hide all of the standard namespace locations (such as Favorites, Libraries, Computer, and Network) shown in the navigation pane.\n\nWindows Vista. Hide the contents of the Favorite Links tree in the navigation pane. Note that the category itself is still displayed, but shown as empty.
  NoDereferenceLinks = 1048576, ---@type os.DialogFlags #Shortcuts should not be treated as their target items. This allows an application to open a .lnk file rather than what that file is a shortcut to.
  OkButtonNeedsInteraction = 2097152, ---@type os.DialogFlags #The OK button will be disabled until the user navigates the view or edits the filename (if applicable). Note: Disabling of the OK button does not prevent the dialog from being submitted by the Enter key.
  DontAddToRecent = 33554432, ---@type os.DialogFlags #Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
  ForceShowHidden = 268435456, ---@type os.DialogFlags #Include hidden and system items.
  DefaultNoMiniMode = 536870912, ---@type os.DialogFlags #Indicates to the Save As dialog box that it should open in expanded mode. Expanded mode is the mode that is set and unset by clicking the button in the lower-left corner of the Save As dialog box that switches between Browse Folders and Hide Folders when clicked. This value is not supported as of Windows 7.
  ForcePreviewPaneOn = 1073741824, ---@type os.DialogFlags #Indicates to the Open dialog box that the preview pane should always be displayed.
  SupportStreamableItems = 2147483648, ---@type os.DialogFlags #Indicates that the caller is opening a file as a stream (BHID_Stream), so there is no need to download that file.
}

---@alias ac.TurningLights
---| `ac.TurningLights.None` @Value: 0.
---| `ac.TurningLights.Left` @Value: 1.
---| `ac.TurningLights.Right` @Value: 2.
---| `ac.TurningLights.Hazards` @Value: 3.
ac.TurningLights = {
  None = 0, ---@type ac.TurningLights #Value: 0.
  Left = 1, ---@type ac.TurningLights #Value: 1.
  Right = 2, ---@type ac.TurningLights #Value: 2.
  Hazards = 3, ---@type ac.TurningLights #Value: 3.
}

---@alias ac.CarAudioEventID
---| `ac.CarAudioEventID.EngineExt` @Value: 0.
---| `ac.CarAudioEventID.EngineInt` @Value: 1.
---| `ac.CarAudioEventID.GearExt` @Value: 2.
---| `ac.CarAudioEventID.GearInt` @Value: 3.
---| `ac.CarAudioEventID.Bodywork` @Value: 4.
---| `ac.CarAudioEventID.Wind` @Value: 5.
---| `ac.CarAudioEventID.Dirt` @Value: 6.
---| `ac.CarAudioEventID.Downshift` @Value: 7.
---| `ac.CarAudioEventID.Horn` @Value: 8.
---| `ac.CarAudioEventID.GearGrind` @Value: 9.
---| `ac.CarAudioEventID.BackfireExt` @Value: 10.
---| `ac.CarAudioEventID.BackfireInt` @Value: 11.
---| `ac.CarAudioEventID.TractionControlExt` @Value: 12.
---| `ac.CarAudioEventID.TractionControlInt` @Value: 13.
---| `ac.CarAudioEventID.Transmission` @Value: 14.
---| `ac.CarAudioEventID.Limiter` @Value: 15.
---| `ac.CarAudioEventID.Turbo` @Value: 16.
---| `ac.CarAudioEventID.WheelLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.WheelRF` @Value: 21.
---| `ac.CarAudioEventID.WheelLR` @Value: 22.
---| `ac.CarAudioEventID.WheelRR` @Value: 23.
---| `ac.CarAudioEventID.SkidIntLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.SkidIntRF` @Value: 31.
---| `ac.CarAudioEventID.SkidIntLR` @Value: 32.
---| `ac.CarAudioEventID.SkidIntRR` @Value: 33.
---| `ac.CarAudioEventID.SkidExtLF` @Add 0-based index to this value for Nth wheel.
---| `ac.CarAudioEventID.SkidExtRF` @Value: 41.
---| `ac.CarAudioEventID.SkidExtLR` @Value: 42.
---| `ac.CarAudioEventID.SkidExtRR` @Value: 43.
ac.CarAudioEventID = {
  EngineExt = 0, ---@type ac.CarAudioEventID #Value: 0.
  EngineInt = 1, ---@type ac.CarAudioEventID #Value: 1.
  GearExt = 2, ---@type ac.CarAudioEventID #Value: 2.
  GearInt = 3, ---@type ac.CarAudioEventID #Value: 3.
  Bodywork = 4, ---@type ac.CarAudioEventID #Value: 4.
  Wind = 5, ---@type ac.CarAudioEventID #Value: 5.
  Dirt = 6, ---@type ac.CarAudioEventID #Value: 6.
  Downshift = 7, ---@type ac.CarAudioEventID #Value: 7.
  Horn = 8, ---@type ac.CarAudioEventID #Value: 8.
  GearGrind = 9, ---@type ac.CarAudioEventID #Value: 9.
  BackfireExt = 10, ---@type ac.CarAudioEventID #Value: 10.
  BackfireInt = 11, ---@type ac.CarAudioEventID #Value: 11.
  TractionControlExt = 12, ---@type ac.CarAudioEventID #Value: 12.
  TractionControlInt = 13, ---@type ac.CarAudioEventID #Value: 13.
  Transmission = 14, ---@type ac.CarAudioEventID #Value: 14.
  Limiter = 15, ---@type ac.CarAudioEventID #Value: 15.
  Turbo = 16, ---@type ac.CarAudioEventID #Value: 16.
  WheelLF = 20, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  WheelRF = 21, ---@type ac.CarAudioEventID #Value: 21.
  WheelLR = 22, ---@type ac.CarAudioEventID #Value: 22.
  WheelRR = 23, ---@type ac.CarAudioEventID #Value: 23.
  SkidIntLF = 30, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  SkidIntRF = 31, ---@type ac.CarAudioEventID #Value: 31.
  SkidIntLR = 32, ---@type ac.CarAudioEventID #Value: 32.
  SkidIntRR = 33, ---@type ac.CarAudioEventID #Value: 33.
  SkidExtLF = 40, ---@type ac.CarAudioEventID #Add 0-based index to this value for Nth wheel.
  SkidExtRF = 41, ---@type ac.CarAudioEventID #Value: 41.
  SkidExtLR = 42, ---@type ac.CarAudioEventID #Value: 42.
  SkidExtRR = 43, ---@type ac.CarAudioEventID #Value: 43.
}

---Flags specifying when to start calling the `update()` next time. Different conditions be combined with `bit.bor()`.---If your script only needs to, for example, reset a certain thing when car resets, don’t forget to call---`ac.pauseScriptUntil()` again once you’re done.------Other functions (such as `script.reset()` for car physics script), callbacks, timers or event listeners will still be---called. You can cancel out pause by calling `ac.pauseScriptUntil(ac.ScriptResumeCondition.NoPause)` from there.------Currently only available to car scripts, both display/extension and physics (since the major performance issue with Lua---is mostly when there are dozens or hundreds of cars all running even some lightweight Lua scripts, which is admittedly---a rare case).
---@alias ac.ScriptResumeCondition
---| `ac.ScriptResumeCondition.Resume` @Disable pause, keep calling `update()` as usual.
---| `ac.ScriptResumeCondition.None` @Do not resume script ever.
---| `ac.ScriptResumeCondition.Pitlane` @Resume script once car arrives in pitlane.
---| `ac.ScriptResumeCondition.Pits` @Resume script when car gets in pits.
---| `ac.ScriptResumeCondition.Reset` @Pause until car resets.
---| `ac.ScriptResumeCondition.Extra` @Pause until extra switch is used.
---| `ac.ScriptResumeCondition.MeshInteraction` @Pause until there is a change mesh could have been touched.
---| `ac.ScriptResumeCondition.Collision` @Pause until car had a contact with something (added in CSP 0.2.8, won’t work for remote cars for now).
ac.ScriptResumeCondition = {
  Resume = -1, ---@type ac.ScriptResumeCondition #Disable pause, keep calling `update()` as usual.
  None = 0x0, ---@type ac.ScriptResumeCondition #Do not resume script ever.
  Pitlane = 0x1, ---@type ac.ScriptResumeCondition #Resume script once car arrives in pitlane.
  Pits = 0x2, ---@type ac.ScriptResumeCondition #Resume script when car gets in pits.
  Reset = 0x4, ---@type ac.ScriptResumeCondition #Pause until car resets.
  Extra = 0x8, ---@type ac.ScriptResumeCondition #Pause until extra switch is used.
  MeshInteraction = 0x10, ---@type ac.ScriptResumeCondition #Pause until there is a change mesh could have been touched.
  Collision = 0x20, ---@type ac.ScriptResumeCondition #Pause until car had a contact with something (added in CSP 0.2.8, won’t work for remote cars for now).
}

---Key indices, pretty much mirrors all those “VK_…” key tables.
---@alias ui.KeyIndex
---| `ui.KeyIndex.LeftButton` @Value: 1.
---| `ui.KeyIndex.RightButton` @Value: 2.
---| `ui.KeyIndex.MiddleButton` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton1` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.XButton2` @Not contiguous with LeftButton and RightButton.
---| `ui.KeyIndex.Tab` @Value: 9.
---| `ui.KeyIndex.Return` @Value: 13.
---| `ui.KeyIndex.Shift` @Value: 16.
---| `ui.KeyIndex.Control` @Value: 17.
---| `ui.KeyIndex.Menu` @Aka Alt button.
---| `ui.KeyIndex.Escape` @Value: 27.
---| `ui.KeyIndex.Accept` @Value: 30.
---| `ui.KeyIndex.Space` @Value: 32.
---| `ui.KeyIndex.End` @Value: 35.
---| `ui.KeyIndex.Home` @Value: 36.
---| `ui.KeyIndex.Left` @Arrow ←.
---| `ui.KeyIndex.Up` @Arrow ↑.
---| `ui.KeyIndex.Right` @Arrow →.
---| `ui.KeyIndex.Down` @Arrow ↓.
---| `ui.KeyIndex.Insert` @Value: 45.
---| `ui.KeyIndex.Delete` @Value: 46.
---| `ui.KeyIndex.LeftWin` @Value: 91.
---| `ui.KeyIndex.RightWin` @Value: 92.
---| `ui.KeyIndex.NumPad0` @Value: 96.
---| `ui.KeyIndex.NumPad1` @Value: 97.
---| `ui.KeyIndex.NumPad2` @Value: 98.
---| `ui.KeyIndex.NumPad3` @Value: 99.
---| `ui.KeyIndex.NumPad4` @Value: 100.
---| `ui.KeyIndex.NumPad5` @Value: 101.
---| `ui.KeyIndex.NumPad6` @Value: 102.
---| `ui.KeyIndex.NumPad7` @Value: 103.
---| `ui.KeyIndex.NumPad8` @Value: 104.
---| `ui.KeyIndex.NumPad9` @Value: 105.
---| `ui.KeyIndex.Multiply` @Value: 106.
---| `ui.KeyIndex.Add` @Value: 107.
---| `ui.KeyIndex.Separator` @Value: 108.
---| `ui.KeyIndex.Subtract` @Value: 109.
---| `ui.KeyIndex.Decimal` @Value: 110.
---| `ui.KeyIndex.Divide` @Value: 111.
---| `ui.KeyIndex.F1` @Value: 112.
---| `ui.KeyIndex.F2` @Value: 113.
---| `ui.KeyIndex.F3` @Value: 114.
---| `ui.KeyIndex.F4` @Value: 115.
---| `ui.KeyIndex.F5` @Value: 116.
---| `ui.KeyIndex.F6` @Value: 117.
---| `ui.KeyIndex.F7` @Value: 118.
---| `ui.KeyIndex.F8` @Value: 119.
---| `ui.KeyIndex.F9` @Value: 120.
---| `ui.KeyIndex.F10` @Value: 121.
---| `ui.KeyIndex.F11` @Value: 122.
---| `ui.KeyIndex.F12` @Value: 123.
---| `ui.KeyIndex.NumLock` @Value: 144.
---| `ui.KeyIndex.Scroll` @Value: 145.
---| `ui.KeyIndex.OemNecEqual` @“.
---| `ui.KeyIndex.LeftShift` @Value: 160.
---| `ui.KeyIndex.RightShift` @Value: 161.
---| `ui.KeyIndex.LeftControl` @Value: 162.
---| `ui.KeyIndex.RightControl` @Value: 163.
---| `ui.KeyIndex.LeftMenu` @Aka left Alt button.
---| `ui.KeyIndex.RightMenu` @Aka right Alt button.
---| `ui.KeyIndex.Oem1` @“;:” for US.
---| `ui.KeyIndex.SquareOpenBracket` @Value: 219.
---| `ui.KeyIndex.SquareCloseBracket` @Value: 221.
---| `ui.KeyIndex.D0` @Digit 0.
---| `ui.KeyIndex.D1` @Digit 1.
---| `ui.KeyIndex.D2` @Digit 2.
---| `ui.KeyIndex.D3` @Digit 3.
---| `ui.KeyIndex.D4` @Digit 4.
---| `ui.KeyIndex.D5` @Digit 5.
---| `ui.KeyIndex.D6` @Digit 6.
---| `ui.KeyIndex.D7` @Digit 7.
---| `ui.KeyIndex.D8` @Digit 8.
---| `ui.KeyIndex.D9` @Digit 9.
---| `ui.KeyIndex.A` @Letter A.
---| `ui.KeyIndex.B` @Letter B.
---| `ui.KeyIndex.C` @Letter C.
---| `ui.KeyIndex.D` @Letter D.
---| `ui.KeyIndex.E` @Letter E.
---| `ui.KeyIndex.F` @Letter F.
---| `ui.KeyIndex.G` @Letter G.
---| `ui.KeyIndex.H` @Letter H.
---| `ui.KeyIndex.I` @Letter I.
---| `ui.KeyIndex.J` @Letter J.
---| `ui.KeyIndex.K` @Letter K.
---| `ui.KeyIndex.L` @Letter L.
---| `ui.KeyIndex.M` @Letter M.
---| `ui.KeyIndex.N` @Letter N.
---| `ui.KeyIndex.O` @Letter O.
---| `ui.KeyIndex.P` @Letter P.
---| `ui.KeyIndex.Q` @Letter Q.
---| `ui.KeyIndex.R` @Letter R.
---| `ui.KeyIndex.S` @Letter S.
---| `ui.KeyIndex.T` @Letter T.
---| `ui.KeyIndex.U` @Letter U.
---| `ui.KeyIndex.V` @Letter V.
---| `ui.KeyIndex.W` @Letter W.
---| `ui.KeyIndex.X` @Letter X.
---| `ui.KeyIndex.Y` @Letter Y.
---| `ui.KeyIndex.Z` @Letter Z.
ui.KeyIndex = {
  LeftButton = 1, ---@type ui.KeyIndex #Value: 1.
  RightButton = 2, ---@type ui.KeyIndex #Value: 2.
  Cancel = 3, ---@type ui.KeyIndex #Value: 3.
  MiddleButton = 4, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton1 = 5, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  XButton2 = 6, ---@type ui.KeyIndex #Not contiguous with LeftButton and RightButton.
  Back = 8, ---@type ui.KeyIndex #Value: 8.
  Tab = 9, ---@type ui.KeyIndex #Value: 9.
  Clear = 12, ---@type ui.KeyIndex #Value: 12.
  Return = 13, ---@type ui.KeyIndex #Value: 13.
  Shift = 16, ---@type ui.KeyIndex #Value: 16.
  Control = 17, ---@type ui.KeyIndex #Value: 17.
  Menu = 18, ---@type ui.KeyIndex #Aka Alt button.
  Pause = 19, ---@type ui.KeyIndex #Value: 19.
  Capital = 20, ---@type ui.KeyIndex #Value: 20.
  Kana = 21, ---@type ui.KeyIndex #Value: 21.
  Hangeul = 21, ---@type ui.KeyIndex #Old name - should be here for compatibility.
  Hangul = 21, ---@type ui.KeyIndex #Value: 21.
  Junja = 23, ---@type ui.KeyIndex #Value: 23.
  Final = 24, ---@type ui.KeyIndex #Value: 24.
  Hanja = 25, ---@type ui.KeyIndex #Value: 25.
  Kanji = 25, ---@type ui.KeyIndex #Value: 25.
  Escape = 27, ---@type ui.KeyIndex #Value: 27.
  Convert = 28, ---@type ui.KeyIndex #Value: 28.
  NonConvert = 29, ---@type ui.KeyIndex #Value: 29.
  Accept = 30, ---@type ui.KeyIndex #Value: 30.
  ModeChange = 31, ---@type ui.KeyIndex #Value: 31.
  Space = 32, ---@type ui.KeyIndex #Value: 32.
  Prior = 33, ---@type ui.KeyIndex #Value: 33.
  Next = 34, ---@type ui.KeyIndex #Value: 34.
  End = 35, ---@type ui.KeyIndex #Value: 35.
  Home = 36, ---@type ui.KeyIndex #Value: 36.
  Left = 37, ---@type ui.KeyIndex #Arrow ←.
  Up = 38, ---@type ui.KeyIndex #Arrow ↑.
  Right = 39, ---@type ui.KeyIndex #Arrow →.
  Down = 40, ---@type ui.KeyIndex #Arrow ↓.
  Select = 41, ---@type ui.KeyIndex #Value: 41.
  Print = 42, ---@type ui.KeyIndex #Value: 42.
  Execute = 43, ---@type ui.KeyIndex #Value: 43.
  Snapshot = 44, ---@type ui.KeyIndex #Value: 44.
  Insert = 45, ---@type ui.KeyIndex #Value: 45.
  Delete = 46, ---@type ui.KeyIndex #Value: 46.
  Help = 47, ---@type ui.KeyIndex #Value: 47.
  LeftWin = 91, ---@type ui.KeyIndex #Value: 91.
  RightWin = 92, ---@type ui.KeyIndex #Value: 92.
  Apps = 93, ---@type ui.KeyIndex #Value: 93.
  Sleep = 95, ---@type ui.KeyIndex #Value: 95.
  NumPad0 = 96, ---@type ui.KeyIndex #Value: 96.
  NumPad1 = 97, ---@type ui.KeyIndex #Value: 97.
  NumPad2 = 98, ---@type ui.KeyIndex #Value: 98.
  NumPad3 = 99, ---@type ui.KeyIndex #Value: 99.
  NumPad4 = 100, ---@type ui.KeyIndex #Value: 100.
  NumPad5 = 101, ---@type ui.KeyIndex #Value: 101.
  NumPad6 = 102, ---@type ui.KeyIndex #Value: 102.
  NumPad7 = 103, ---@type ui.KeyIndex #Value: 103.
  NumPad8 = 104, ---@type ui.KeyIndex #Value: 104.
  NumPad9 = 105, ---@type ui.KeyIndex #Value: 105.
  Multiply = 106, ---@type ui.KeyIndex #Value: 106.
  Add = 107, ---@type ui.KeyIndex #Value: 107.
  Separator = 108, ---@type ui.KeyIndex #Value: 108.
  Subtract = 109, ---@type ui.KeyIndex #Value: 109.
  Decimal = 110, ---@type ui.KeyIndex #Value: 110.
  Divide = 111, ---@type ui.KeyIndex #Value: 111.
  F1 = 112, ---@type ui.KeyIndex #Value: 112.
  F2 = 113, ---@type ui.KeyIndex #Value: 113.
  F3 = 114, ---@type ui.KeyIndex #Value: 114.
  F4 = 115, ---@type ui.KeyIndex #Value: 115.
  F5 = 116, ---@type ui.KeyIndex #Value: 116.
  F6 = 117, ---@type ui.KeyIndex #Value: 117.
  F7 = 118, ---@type ui.KeyIndex #Value: 118.
  F8 = 119, ---@type ui.KeyIndex #Value: 119.
  F9 = 120, ---@type ui.KeyIndex #Value: 120.
  F10 = 121, ---@type ui.KeyIndex #Value: 121.
  F11 = 122, ---@type ui.KeyIndex #Value: 122.
  F12 = 123, ---@type ui.KeyIndex #Value: 123.
  F13 = 124, ---@type ui.KeyIndex #Value: 124.
  F14 = 125, ---@type ui.KeyIndex #Value: 125.
  F15 = 126, ---@type ui.KeyIndex #Value: 126.
  F16 = 127, ---@type ui.KeyIndex #Value: 127.
  F17 = 128, ---@type ui.KeyIndex #Value: 128.
  F18 = 129, ---@type ui.KeyIndex #Value: 129.
  F19 = 130, ---@type ui.KeyIndex #Value: 130.
  F20 = 131, ---@type ui.KeyIndex #Value: 131.
  F21 = 132, ---@type ui.KeyIndex #Value: 132.
  F22 = 133, ---@type ui.KeyIndex #Value: 133.
  F23 = 134, ---@type ui.KeyIndex #Value: 134.
  F24 = 135, ---@type ui.KeyIndex #Value: 135.
  NavigationView = 136, ---@type ui.KeyIndex #Reserved.
  NavigationMenu = 137, ---@type ui.KeyIndex #Reserved.
  NavigationUp = 138, ---@type ui.KeyIndex #Reserved.
  NavigationDown = 139, ---@type ui.KeyIndex #Reserved.
  NavigationLeft = 140, ---@type ui.KeyIndex #Reserved.
  NavigationRight = 141, ---@type ui.KeyIndex #Reserved.
  NavigationAccept = 142, ---@type ui.KeyIndex #Reserved.
  NavigationCancel = 143, ---@type ui.KeyIndex #Reserved.
  NumLock = 144, ---@type ui.KeyIndex #Value: 144.
  Scroll = 145, ---@type ui.KeyIndex #Value: 145.
  OemNecEqual = 146, ---@type ui.KeyIndex #“.
  OemFjJisho = 146, ---@type ui.KeyIndex #“Dictionary” key.
  OemFjMasshou = 147, ---@type ui.KeyIndex #“Unregister word” key.
  OemFjTouroku = 148, ---@type ui.KeyIndex #“Register word” key.
  OemFjLoya = 149, ---@type ui.KeyIndex #“Left OYAYUBI” key.
  OemFjRoya = 150, ---@type ui.KeyIndex #“Right OYAYUBI” key.
  LeftShift = 160, ---@type ui.KeyIndex #Value: 160.
  RightShift = 161, ---@type ui.KeyIndex #Value: 161.
  LeftControl = 162, ---@type ui.KeyIndex #Value: 162.
  RightControl = 163, ---@type ui.KeyIndex #Value: 163.
  LeftMenu = 164, ---@type ui.KeyIndex #Aka left Alt button.
  RightMenu = 165, ---@type ui.KeyIndex #Aka right Alt button.
  BrowserBack = 166, ---@type ui.KeyIndex #Value: 166.
  BrowserForward = 167, ---@type ui.KeyIndex #Value: 167.
  BrowserRefresh = 168, ---@type ui.KeyIndex #Value: 168.
  BrowserStop = 169, ---@type ui.KeyIndex #Value: 169.
  BrowserSearch = 170, ---@type ui.KeyIndex #Value: 170.
  BrowserFavorites = 171, ---@type ui.KeyIndex #Value: 171.
  BrowserHome = 172, ---@type ui.KeyIndex #Value: 172.
  VolumeMute = 173, ---@type ui.KeyIndex #Value: 173.
  VolumeDown = 174, ---@type ui.KeyIndex #Value: 174.
  VolumeUp = 175, ---@type ui.KeyIndex #Value: 175.
  MediaNextTrack = 176, ---@type ui.KeyIndex #Value: 176.
  MediaPrevTrack = 177, ---@type ui.KeyIndex #Value: 177.
  MediaStop = 178, ---@type ui.KeyIndex #Value: 178.
  MediaPlayPause = 179, ---@type ui.KeyIndex #Value: 179.
  LaunchMail = 180, ---@type ui.KeyIndex #Value: 180.
  LaunchMediaSelect = 181, ---@type ui.KeyIndex #Value: 181.
  LaunchApp1 = 182, ---@type ui.KeyIndex #Value: 182.
  LaunchApp2 = 183, ---@type ui.KeyIndex #Value: 183.
  Oem1 = 186, ---@type ui.KeyIndex #“;:” for US.
  OemPlus = 187, ---@type ui.KeyIndex #“+” any country.
  OemComma = 188, ---@type ui.KeyIndex #“,” any country.
  OemMinus = 189, ---@type ui.KeyIndex #“-” any country.
  OemPeriod = 190, ---@type ui.KeyIndex #“.” any country.
  Oem2 = 191, ---@type ui.KeyIndex #“/?” for US.
  Oem3 = 192, ---@type ui.KeyIndex #“`~” for US.
  GamepadA = 195, ---@type ui.KeyIndex #Reserved.
  GamepadB = 196, ---@type ui.KeyIndex #Reserved.
  GamepadX = 197, ---@type ui.KeyIndex #Reserved.
  GamepadY = 198, ---@type ui.KeyIndex #Reserved.
  GamepadRightShoulder = 199, ---@type ui.KeyIndex #Reserved.
  GamepadLeftShoulder = 200, ---@type ui.KeyIndex #Reserved.
  GamepadLeftTrigger = 201, ---@type ui.KeyIndex #Reserved.
  GamepadRightTrigger = 202, ---@type ui.KeyIndex #Reserved.
  GamepadDpadUp = 203, ---@type ui.KeyIndex #Reserved.
  GamepadDpadDown = 204, ---@type ui.KeyIndex #Reserved.
  GamepadDpadLeft = 205, ---@type ui.KeyIndex #Reserved.
  GamepadDpadRight = 206, ---@type ui.KeyIndex #Reserved.
  GamepadMenu = 207, ---@type ui.KeyIndex #Reserved.
  GamepadView = 208, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickButton = 209, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickButton = 210, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickUp = 211, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickDown = 212, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickRight = 213, ---@type ui.KeyIndex #Reserved.
  GamepadLeftThumbstickLeft = 214, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickUp = 215, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickDown = 216, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickRight = 217, ---@type ui.KeyIndex #Reserved.
  GamepadRightThumbstickLeft = 218, ---@type ui.KeyIndex #Reserved.
  SquareOpenBracket = 219, ---@type ui.KeyIndex #Value: 219.
  SquareCloseBracket = 221, ---@type ui.KeyIndex #Value: 221.
  D0 = 48, ---@type ui.KeyIndex #Digit 0.
  D1 = 49, ---@type ui.KeyIndex #Digit 1.
  D2 = 50, ---@type ui.KeyIndex #Digit 2.
  D3 = 51, ---@type ui.KeyIndex #Digit 3.
  D4 = 52, ---@type ui.KeyIndex #Digit 4.
  D5 = 53, ---@type ui.KeyIndex #Digit 5.
  D6 = 54, ---@type ui.KeyIndex #Digit 6.
  D7 = 55, ---@type ui.KeyIndex #Digit 7.
  D8 = 56, ---@type ui.KeyIndex #Digit 8.
  D9 = 57, ---@type ui.KeyIndex #Digit 9.
  A = 65, ---@type ui.KeyIndex #Letter A.
  B = 66, ---@type ui.KeyIndex #Letter B.
  C = 67, ---@type ui.KeyIndex #Letter C.
  D = 68, ---@type ui.KeyIndex #Letter D.
  E = 69, ---@type ui.KeyIndex #Letter E.
  F = 70, ---@type ui.KeyIndex #Letter F.
  G = 71, ---@type ui.KeyIndex #Letter G.
  H = 72, ---@type ui.KeyIndex #Letter H.
  I = 73, ---@type ui.KeyIndex #Letter I.
  J = 74, ---@type ui.KeyIndex #Letter J.
  K = 75, ---@type ui.KeyIndex #Letter K.
  L = 76, ---@type ui.KeyIndex #Letter L.
  M = 77, ---@type ui.KeyIndex #Letter M.
  N = 78, ---@type ui.KeyIndex #Letter N.
  O = 79, ---@type ui.KeyIndex #Letter O.
  P = 80, ---@type ui.KeyIndex #Letter P.
  Q = 81, ---@type ui.KeyIndex #Letter Q.
  R = 82, ---@type ui.KeyIndex #Letter R.
  S = 83, ---@type ui.KeyIndex #Letter S.
  T = 84, ---@type ui.KeyIndex #Letter T.
  U = 85, ---@type ui.KeyIndex #Letter U.
  V = 86, ---@type ui.KeyIndex #Letter V.
  W = 87, ---@type ui.KeyIndex #Letter W.
  X = 88, ---@type ui.KeyIndex #Letter X.
  Y = 89, ---@type ui.KeyIndex #Letter Y.
  Z = 90, ---@type ui.KeyIndex #Letter Z.
}

---@alias ac.VAODebugMode
---| `ac.VAODebugMode.Active` @Value: 1.
---| `ac.VAODebugMode.Inactive` @Value: 3.
---| `ac.VAODebugMode.VAOOnly` @Value: 4.
---| `ac.VAODebugMode.ShowNormals` @Value: 5.
ac.VAODebugMode = {
  Active = 1, ---@type ac.VAODebugMode #Value: 1.
  Inactive = 3, ---@type ac.VAODebugMode #Value: 3.
  VAOOnly = 4, ---@type ac.VAODebugMode #Value: 4.
  ShowNormals = 5, ---@type ac.VAODebugMode #Value: 5.
}

---@alias ui.Icons
---| `ui.Icons.Air` @![Icon](https://acstuff.club/images/icons_24/air.png)
---| `ui.Icons.AppWindow` @![Icon](https://acstuff.club/images/icons_24/app_window.png)
---| `ui.Icons.Apps` @![Icon](https://acstuff.club/images/icons_24/apps.png)
---| `ui.Icons.ArrowDown` @![Icon](https://acstuff.club/images/icons_24/arrow_down.png)
---| `ui.Icons.ArrowLeft` @![Icon](https://acstuff.club/images/icons_24/arrow_left.png)
---| `ui.Icons.ArrowRight` @![Icon](https://acstuff.club/images/icons_24/arrow_right.png)
---| `ui.Icons.ArrowUp` @![Icon](https://acstuff.club/images/icons_24/arrow_up.png)
---| `ui.Icons.Assist` @![Icon](https://acstuff.club/images/icons_24/assist.png)
---| `ui.Icons.Attention` @![Icon](https://acstuff.club/images/icons_24/attention.png)
---| `ui.Icons.Avatar` @![Icon](https://acstuff.club/images/icons_24/avatar.png)
---| `ui.Icons.Back` @![Icon](https://acstuff.club/images/icons_24/back.png)
---| `ui.Icons.Backspace` @![Icon](https://acstuff.club/images/icons_24/backspace.png)
---| `ui.Icons.Ballast` @![Icon](https://acstuff.club/images/icons_24/ballast.png)
---| `ui.Icons.Ban` @![Icon](https://acstuff.club/images/icons_24/ban.png)
---| `ui.Icons.Barcode` @![Icon](https://acstuff.club/images/icons_24/barcode.png)
---| `ui.Icons.Bars` @![Icon](https://acstuff.club/images/icons_24/bars.png)
---| `ui.Icons.BatteryEmpty` @![Icon](https://acstuff.club/images/icons_24/battery_empty.png)
---| `ui.Icons.BatteryFull` @![Icon](https://acstuff.club/images/icons_24/battery_full.png)
---| `ui.Icons.Befriend` @![Icon](https://acstuff.club/images/icons_24/befriend.png)
---| `ui.Icons.Bell` @![Icon](https://acstuff.club/images/icons_24/bell.png)
---| `ui.Icons.Binocoulars` @![Icon](https://acstuff.club/images/icons_24/binocoulars.png)
---| `ui.Icons.Blackboard` @![Icon](https://acstuff.club/images/icons_24/blackboard.png)
---| `ui.Icons.Blanket` @![Icon](https://acstuff.club/images/icons_24/blanket.png)
---| `ui.Icons.Blast` @![Icon](https://acstuff.club/images/icons_24/blast.png)
---| `ui.Icons.Bluetooth` @![Icon](https://acstuff.club/images/icons_24/bluetooth.png)
---| `ui.Icons.Bomb` @![Icon](https://acstuff.club/images/icons_24/bomb.png)
---| `ui.Icons.Book` @![Icon](https://acstuff.club/images/icons_24/book.png)
---| `ui.Icons.Bookmark` @![Icon](https://acstuff.club/images/icons_24/bookmark.png)
---| `ui.Icons.Box` @![Icon](https://acstuff.club/images/icons_24/box.png)
---| `ui.Icons.Briefcase` @![Icon](https://acstuff.club/images/icons_24/briefcase.png)
---| `ui.Icons.Bug` @![Icon](https://acstuff.club/images/icons_24/bug.png)
---| `ui.Icons.Bulb` @![Icon](https://acstuff.club/images/icons_24/bulb.png)
---| `ui.Icons.Burn` @![Icon](https://acstuff.club/images/icons_24/burn.png)
---| `ui.Icons.Calculator` @![Icon](https://acstuff.club/images/icons_24/calculator.png)
---| `ui.Icons.Calendar` @![Icon](https://acstuff.club/images/icons_24/calendar.png)
---| `ui.Icons.CallBluetooth` @![Icon](https://acstuff.club/images/icons_24/call_bluetooth.png)
---| `ui.Icons.Call` @![Icon](https://acstuff.club/images/icons_24/call.png)
---| `ui.Icons.CameraAlt` @![Icon](https://acstuff.club/images/icons_24/camera_alt.png)
---| `ui.Icons.Camera` @![Icon](https://acstuff.club/images/icons_24/camera.png)
---| `ui.Icons.Cancel` @![Icon](https://acstuff.club/images/icons_24/cancel.png)
---| `ui.Icons.CarFront` @![Icon](https://acstuff.club/images/icons_24/car_front.png)
---| `ui.Icons.Cards` @![Icon](https://acstuff.club/images/icons_24/cards.png)
---| `ui.Icons.Cctv` @![Icon](https://acstuff.club/images/icons_24/cctv.png)
---| `ui.Icons.Cellphone` @![Icon](https://acstuff.club/images/icons_24/cellphone.png)
---| `ui.Icons.Chat` @![Icon](https://acstuff.club/images/icons_24/chat.png)
---| `ui.Icons.Clapperboard` @![Icon](https://acstuff.club/images/icons_24/clapperboard.png)
---| `ui.Icons.Clip` @![Icon](https://acstuff.club/images/icons_24/clip.png)
---| `ui.Icons.Clipboard` @![Icon](https://acstuff.club/images/icons_24/clipboard.png)
---| `ui.Icons.Clock` @![Icon](https://acstuff.club/images/icons_24/clock.png)
---| `ui.Icons.Cloud` @![Icon](https://acstuff.club/images/icons_24/cloud.png)
---| `ui.Icons.Code` @![Icon](https://acstuff.club/images/icons_24/code.png)
---| `ui.Icons.Coffee` @![Icon](https://acstuff.club/images/icons_24/coffee.png)
---| `ui.Icons.CollisionAlt` @![Icon](https://acstuff.club/images/icons_24/collision_alt.png)
---| `ui.Icons.Collision` @![Icon](https://acstuff.club/images/icons_24/collision.png)
---| `ui.Icons.CompassAlt` @![Icon](https://acstuff.club/images/icons_24/compass_alt.png)
---| `ui.Icons.Compass` @![Icon](https://acstuff.club/images/icons_24/compass.png)
---| `ui.Icons.Confirm` @![Icon](https://acstuff.club/images/icons_24/confirm.png)
---| `ui.Icons.Constellation` @![Icon](https://acstuff.club/images/icons_24/constellation.png)
---| `ui.Icons.Contacts` @![Icon](https://acstuff.club/images/icons_24/contacts.png)
---| `ui.Icons.Contrast` @![Icon](https://acstuff.club/images/icons_24/contrast.png)
---| `ui.Icons.Copy` @![Icon](https://acstuff.club/images/icons_24/copy.png)
---| `ui.Icons.CreditCard` @![Icon](https://acstuff.club/images/icons_24/credit_card.png)
---| `ui.Icons.Crop` @![Icon](https://acstuff.club/images/icons_24/crop.png)
---| `ui.Icons.Crosshair` @![Icon](https://acstuff.club/images/icons_24/crosshair.png)
---| `ui.Icons.Delete` @![Icon](https://acstuff.club/images/icons_24/delete.png)
---| `ui.Icons.Dice` @![Icon](https://acstuff.club/images/icons_24/dice.png)
---| `ui.Icons.Directions` @![Icon](https://acstuff.club/images/icons_24/directions.png)
---| `ui.Icons.Document` @![Icon](https://acstuff.club/images/icons_24/document.png)
---| `ui.Icons.DollarBill` @![Icon](https://acstuff.club/images/icons_24/dollar_bill.png)
---| `ui.Icons.DownAlt` @![Icon](https://acstuff.club/images/icons_24/down_alt.png)
---| `ui.Icons.Down` @![Icon](https://acstuff.club/images/icons_24/down.png)
---| `ui.Icons.Download` @![Icon](https://acstuff.club/images/icons_24/download.png)
---| `ui.Icons.Driver` @![Icon](https://acstuff.club/images/icons_24/driver.png)
---| `ui.Icons.Earth` @![Icon](https://acstuff.club/images/icons_24/earth.png)
---| `ui.Icons.Edit` @![Icon](https://acstuff.club/images/icons_24/edit.png)
---| `ui.Icons.Eject` @![Icon](https://acstuff.club/images/icons_24/eject.png)
---| `ui.Icons.Ellipsis` @![Icon](https://acstuff.club/images/icons_24/ellipsis.png)
---| `ui.Icons.Enter` @![Icon](https://acstuff.club/images/icons_24/enter.png)
---| `ui.Icons.Envelope` @![Icon](https://acstuff.club/images/icons_24/envelope.png)
---| `ui.Icons.Exit` @![Icon](https://acstuff.club/images/icons_24/exit.png)
---| `ui.Icons.Eye` @![Icon](https://acstuff.club/images/icons_24/eye.png)
---| `ui.Icons.FastForward` @![Icon](https://acstuff.club/images/icons_24/fast_forward.png)
---| `ui.Icons.File` @![Icon](https://acstuff.club/images/icons_24/file.png)
---| `ui.Icons.FilmRoll` @![Icon](https://acstuff.club/images/icons_24/film_roll.png)
---| `ui.Icons.Film` @![Icon](https://acstuff.club/images/icons_24/film.png)
---| `ui.Icons.Finish` @![Icon](https://acstuff.club/images/icons_24/finish.png)
---| `ui.Icons.FireExtinguisher` @![Icon](https://acstuff.club/images/icons_24/fire_extinguisher.png)
---| `ui.Icons.Fireplace` @![Icon](https://acstuff.club/images/icons_24/fireplace.png)
---| `ui.Icons.FlagAlt` @![Icon](https://acstuff.club/images/icons_24/flag_alt.png)
---| `ui.Icons.Flag` @![Icon](https://acstuff.club/images/icons_24/flag.png)
---| `ui.Icons.FM` @![Icon](https://acstuff.club/images/icons_24/fm.png)
---| `ui.Icons.Folder` @![Icon](https://acstuff.club/images/icons_24/folder.png)
---| `ui.Icons.Font` @![Icon](https://acstuff.club/images/icons_24/font.png)
---| `ui.Icons.Fuel` @![Icon](https://acstuff.club/images/icons_24/fuel.png)
---| `ui.Icons.Fullscreen` @![Icon](https://acstuff.club/images/icons_24/fullscreen.png)
---| `ui.Icons.Gamepad` @![Icon](https://acstuff.club/images/icons_24/gamepad.png)
---| `ui.Icons.Ghost` @![Icon](https://acstuff.club/images/icons_24/ghost.png)
---| `ui.Icons.Global` @![Icon](https://acstuff.club/images/icons_24/global.png)
---| `ui.Icons.GlowThick` @![Icon](https://acstuff.club/images/icons_24/glow_thick.png)
---| `ui.Icons.Glow` @![Icon](https://acstuff.club/images/icons_24/glow.png)
---| `ui.Icons.GPS` @![Icon](https://acstuff.club/images/icons_24/gps.png)
---| `ui.Icons.Group` @![Icon](https://acstuff.club/images/icons_24/group.png)
---| `ui.Icons.HammerAlt` @![Icon](https://acstuff.club/images/icons_24/hammer_alt.png)
---| `ui.Icons.Hammer` @![Icon](https://acstuff.club/images/icons_24/hammer.png)
---| `ui.Icons.Hazard` @![Icon](https://acstuff.club/images/icons_24/hazard.png)
---| `ui.Icons.Headphones` @![Icon](https://acstuff.club/images/icons_24/headphones.png)
---| `ui.Icons.HeartOutline` @![Icon](https://acstuff.club/images/icons_24/heart_outline.png)
---| `ui.Icons.Heart` @![Icon](https://acstuff.club/images/icons_24/heart.png)
---| `ui.Icons.Helmet` @![Icon](https://acstuff.club/images/icons_24/helmet.png)
---| `ui.Icons.Hide` @![Icon](https://acstuff.club/images/icons_24/hide.png)
---| `ui.Icons.Home` @![Icon](https://acstuff.club/images/icons_24/home.png)
---| `ui.Icons.Horizontal` @![Icon](https://acstuff.club/images/icons_24/horizontal.png)
---| `ui.Icons.Hourglass` @![Icon](https://acstuff.club/images/icons_24/hourglass.png)
---| `ui.Icons.InboxEmpty` @![Icon](https://acstuff.club/images/icons_24/inbox_empty.png)
---| `ui.Icons.InboxFull` @![Icon](https://acstuff.club/images/icons_24/inbox_full.png)
---| `ui.Icons.Info` @![Icon](https://acstuff.club/images/icons_24/info.png)
---| `ui.Icons.Key` @![Icon](https://acstuff.club/images/icons_24/key.png)
---| `ui.Icons.Keyboard` @![Icon](https://acstuff.club/images/icons_24/keyboard.png)
---| `ui.Icons.Kick` @![Icon](https://acstuff.club/images/icons_24/kick.png)
---| `ui.Icons.Landscape` @![Icon](https://acstuff.club/images/icons_24/landscape.png)
---| `ui.Icons.Laptop` @![Icon](https://acstuff.club/images/icons_24/laptop.png)
---| `ui.Icons.Leaderboard` @![Icon](https://acstuff.club/images/icons_24/leaderboard.png)
---| `ui.Icons.Leave` @![Icon](https://acstuff.club/images/icons_24/leave.png)
---| `ui.Icons.Lens` @![Icon](https://acstuff.club/images/icons_24/lens.png)
---| `ui.Icons.Levels` @![Icon](https://acstuff.club/images/icons_24/levels.png)
---| `ui.Icons.LinkBroken` @![Icon](https://acstuff.club/images/icons_24/link_broken.png)
---| `ui.Icons.Link` @![Icon](https://acstuff.club/images/icons_24/link.png)
---| `ui.Icons.ListAlt` @![Icon](https://acstuff.club/images/icons_24/list_alt.png)
---| `ui.Icons.List` @![Icon](https://acstuff.club/images/icons_24/list.png)
---| `ui.Icons.Loading` @![Icon](https://acstuff.club/images/icons_24/loading.png)
---| `ui.Icons.Location` @![Icon](https://acstuff.club/images/icons_24/location.png)
---| `ui.Icons.Lua` @![Icon](https://acstuff.club/images/icons_24/lua.png)
---| `ui.Icons.Magnet` @![Icon](https://acstuff.club/images/icons_24/magnet.png)
---| `ui.Icons.Map` @![Icon](https://acstuff.club/images/icons_24/map.png)
---| `ui.Icons.Maximize` @![Icon](https://acstuff.club/images/icons_24/maximize.png)
---| `ui.Icons.Menu` @![Icon](https://acstuff.club/images/icons_24/menu.png)
---| `ui.Icons.MicrophoneMuted` @![Icon](https://acstuff.club/images/icons_24/microphone_muted.png)
---| `ui.Icons.Microphone` @![Icon](https://acstuff.club/images/icons_24/microphone.png)
---| `ui.Icons.Minus` @![Icon](https://acstuff.club/images/icons_24/minus.png)
---| `ui.Icons.Monitor` @![Icon](https://acstuff.club/images/icons_24/monitor.png)
---| `ui.Icons.Moon` @![Icon](https://acstuff.club/images/icons_24/moon.png)
---| `ui.Icons.Mouse` @![Icon](https://acstuff.club/images/icons_24/mouse.png)
---| `ui.Icons.Music` @![Icon](https://acstuff.club/images/icons_24/music.png)
---| `ui.Icons.Mute` @![Icon](https://acstuff.club/images/icons_24/mute.png)
---| `ui.Icons.Navigation` @![Icon](https://acstuff.club/images/icons_24/navigation.png)
---| `ui.Icons.New` @![Icon](https://acstuff.club/images/icons_24/new.png)
---| `ui.Icons.Next` @![Icon](https://acstuff.club/images/icons_24/next.png)
---| `ui.Icons.NotificationsAny` @![Icon](https://acstuff.club/images/icons_24/notifications_any.png)
---| `ui.Icons.Notifications` @![Icon](https://acstuff.club/images/icons_24/notifications.png)
---| `ui.Icons.PadlockUnlocked` @![Icon](https://acstuff.club/images/icons_24/padlock_unlocked.png)
---| `ui.Icons.Padlock` @![Icon](https://acstuff.club/images/icons_24/padlock.png)
---| `ui.Icons.Palette` @![Icon](https://acstuff.club/images/icons_24/palette.png)
---| `ui.Icons.Paperclip` @![Icon](https://acstuff.club/images/icons_24/paperclip.png)
---| `ui.Icons.Paste` @![Icon](https://acstuff.club/images/icons_24/paste.png)
---| `ui.Icons.Pause` @![Icon](https://acstuff.club/images/icons_24/pause.png)
---| `ui.Icons.Pedals` @![Icon](https://acstuff.club/images/icons_24/pedals.png)
---| `ui.Icons.Person` @![Icon](https://acstuff.club/images/icons_24/person.png)
---| `ui.Icons.Photograph` @![Icon](https://acstuff.club/images/icons_24/photograph.png)
---| `ui.Icons.Pin` @![Icon](https://acstuff.club/images/icons_24/pin.png)
---| `ui.Icons.PitStopAlt` @![Icon](https://acstuff.club/images/icons_24/pit_stop_alt.png)
---| `ui.Icons.PitStop` @![Icon](https://acstuff.club/images/icons_24/pit_stop.png)
---| `ui.Icons.Pitlane` @![Icon](https://acstuff.club/images/icons_24/pitlane.png)
---| `ui.Icons.Plane` @![Icon](https://acstuff.club/images/icons_24/plane.png)
---| `ui.Icons.Play` @![Icon](https://acstuff.club/images/icons_24/play.png)
---| `ui.Icons.Plug` @![Icon](https://acstuff.club/images/icons_24/plug.png)
---| `ui.Icons.Plus` @![Icon](https://acstuff.club/images/icons_24/plus.png)
---| `ui.Icons.Preview` @![Icon](https://acstuff.club/images/icons_24/preview.png)
---| `ui.Icons.Previous` @![Icon](https://acstuff.club/images/icons_24/previous.png)
---| `ui.Icons.Print` @![Icon](https://acstuff.club/images/icons_24/print.png)
---| `ui.Icons.Process` @![Icon](https://acstuff.club/images/icons_24/process.png)
---| `ui.Icons.Puzzle` @![Icon](https://acstuff.club/images/icons_24/puzzle.png)
---| `ui.Icons.Python` @![Icon](https://acstuff.club/images/icons_24/python.png)
---| `ui.Icons.QR` @![Icon](https://acstuff.club/images/icons_24/qr.png)
---| `ui.Icons.QuestionSign` @![Icon](https://acstuff.club/images/icons_24/question_sign.png)
---| `ui.Icons.Question` @![Icon](https://acstuff.club/images/icons_24/question.png)
---| `ui.Icons.Radio` @![Icon](https://acstuff.club/images/icons_24/radio.png)
---| `ui.Icons.Recognition` @![Icon](https://acstuff.club/images/icons_24/recognition.png)
---| `ui.Icons.RecordAlt` @![Icon](https://acstuff.club/images/icons_24/record_alt.png)
---| `ui.Icons.Record` @![Icon](https://acstuff.club/images/icons_24/record.png)
---| `ui.Icons.Redo` @![Icon](https://acstuff.club/images/icons_24/redo.png)
---| `ui.Icons.Referee` @![Icon](https://acstuff.club/images/icons_24/referee.png)
---| `ui.Icons.Repair` @![Icon](https://acstuff.club/images/icons_24/repair.png)
---| `ui.Icons.Reset` @![Icon](https://acstuff.club/images/icons_24/reset.png)
---| `ui.Icons.RestartWarning` @![Icon](https://acstuff.club/images/icons_24/restart_warning.png)
---| `ui.Icons.Restart` @![Icon](https://acstuff.club/images/icons_24/restart.png)
---| `ui.Icons.Restrictor` @![Icon](https://acstuff.club/images/icons_24/restrictor.png)
---| `ui.Icons.Resume` @![Icon](https://acstuff.club/images/icons_24/resume.png)
---| `ui.Icons.Rewind` @![Icon](https://acstuff.club/images/icons_24/rewind.png)
---| `ui.Icons.Road` @![Icon](https://acstuff.club/images/icons_24/road.png)
---| `ui.Icons.Route` @![Icon](https://acstuff.club/images/icons_24/route.png)
---| `ui.Icons.Rubber` @![Icon](https://acstuff.club/images/icons_24/rubber.png)
---| `ui.Icons.SatelliteDishLow` @![Icon](https://acstuff.club/images/icons_24/satellite_dish_low.png)
---| `ui.Icons.SatelliteDishNone` @![Icon](https://acstuff.club/images/icons_24/satellite_dish_none.png)
---| `ui.Icons.SatelliteDish` @![Icon](https://acstuff.club/images/icons_24/satellite_dish.png)
---| `ui.Icons.Save` @![Icon](https://acstuff.club/images/icons_24/save.png)
---| `ui.Icons.Scissors` @![Icon](https://acstuff.club/images/icons_24/scissors.png)
---| `ui.Icons.Sea` @![Icon](https://acstuff.club/images/icons_24/sea.png)
---| `ui.Icons.Search` @![Icon](https://acstuff.club/images/icons_24/search.png)
---| `ui.Icons.Send` @![Icon](https://acstuff.club/images/icons_24/send.png)
---| `ui.Icons.Service` @![Icon](https://acstuff.club/images/icons_24/service.png)
---| `ui.Icons.SettingsAlt` @![Icon](https://acstuff.club/images/icons_24/settings_alt.png)
---| `ui.Icons.Settings` @![Icon](https://acstuff.club/images/icons_24/settings.png)
---| `ui.Icons.ShieldWithLock` @![Icon](https://acstuff.club/images/icons_24/shield_with_lock.png)
---| `ui.Icons.Shield` @![Icon](https://acstuff.club/images/icons_24/shield.png)
---| `ui.Icons.ShiftActive` @![Icon](https://acstuff.club/images/icons_24/shift_active.png)
---| `ui.Icons.Shift` @![Icon](https://acstuff.club/images/icons_24/shift.png)
---| `ui.Icons.Shopping` @![Icon](https://acstuff.club/images/icons_24/shopping.png)
---| `ui.Icons.Shuffle` @![Icon](https://acstuff.club/images/icons_24/shuffle.png)
---| `ui.Icons.Skip` @![Icon](https://acstuff.club/images/icons_24/skip.png)
---| `ui.Icons.Sleep` @![Icon](https://acstuff.club/images/icons_24/sleep.png)
---| `ui.Icons.Sliders` @![Icon](https://acstuff.club/images/icons_24/sliders.png)
---| `ui.Icons.SlowMotion` @![Icon](https://acstuff.club/images/icons_24/slow_motion.png)
---| `ui.Icons.Smile` @![Icon](https://acstuff.club/images/icons_24/smile.png)
---| `ui.Icons.Spaceship` @![Icon](https://acstuff.club/images/icons_24/spaceship.png)
---| `ui.Icons.Speaker` @![Icon](https://acstuff.club/images/icons_24/speaker.png)
---| `ui.Icons.Speedometer` @![Icon](https://acstuff.club/images/icons_24/speedometer.png)
---| `ui.Icons.Spotify` @![Icon](https://acstuff.club/images/icons_24/spotify.png)
---| `ui.Icons.SquaresHorizontal` @![Icon](https://acstuff.club/images/icons_24/squares_horizontal.png)
---| `ui.Icons.SquaresVertical` @![Icon](https://acstuff.club/images/icons_24/squares_vertical.png)
---| `ui.Icons.StarEmpty` @![Icon](https://acstuff.club/images/icons_24/star_empty.png)
---| `ui.Icons.StarFull` @![Icon](https://acstuff.club/images/icons_24/star_full.png)
---| `ui.Icons.StarHalf` @![Icon](https://acstuff.club/images/icons_24/star_half.png)
---| `ui.Icons.Start` @![Icon](https://acstuff.club/images/icons_24/start.png)
---| `ui.Icons.Stats` @![Icon](https://acstuff.club/images/icons_24/stats.png)
---| `ui.Icons.Stay` @![Icon](https://acstuff.club/images/icons_24/stay.png)
---| `ui.Icons.SteeringWheel` @![Icon](https://acstuff.club/images/icons_24/steering_wheel.png)
---| `ui.Icons.StopAlt` @![Icon](https://acstuff.club/images/icons_24/stop_alt.png)
---| `ui.Icons.Stop` @![Icon](https://acstuff.club/images/icons_24/stop.png)
---| `ui.Icons.Stopwatch` @![Icon](https://acstuff.club/images/icons_24/stopwatch.png)
---| `ui.Icons.Sweeping` @![Icon](https://acstuff.club/images/icons_24/sweeping.png)
---| `ui.Icons.Tag` @![Icon](https://acstuff.club/images/icons_24/tag.png)
---| `ui.Icons.Target` @![Icon](https://acstuff.club/images/icons_24/target.png)
---| `ui.Icons.Team` @![Icon](https://acstuff.club/images/icons_24/team.png)
---| `ui.Icons.Teleport` @![Icon](https://acstuff.club/images/icons_24/teleport.png)
---| `ui.Icons.Tent` @![Icon](https://acstuff.club/images/icons_24/tent.png)
---| `ui.Icons.Thermometer` @![Icon](https://acstuff.club/images/icons_24/thermometer.png)
---| `ui.Icons.ThumbDown` @![Icon](https://acstuff.club/images/icons_24/thumb_down.png)
---| `ui.Icons.ThumbUp` @![Icon](https://acstuff.club/images/icons_24/thumb_up.png)
---| `ui.Icons.TimeRewind` @![Icon](https://acstuff.club/images/icons_24/time_rewind.png)
---| `ui.Icons.TopHat` @![Icon](https://acstuff.club/images/icons_24/top_hat.png)
---| `ui.Icons.TrafficLight` @![Icon](https://acstuff.club/images/icons_24/traffic_light.png)
---| `ui.Icons.Transmission` @![Icon](https://acstuff.club/images/icons_24/transmission.png)
---| `ui.Icons.Trash` @![Icon](https://acstuff.club/images/icons_24/trash.png)
---| `ui.Icons.Treat` @![Icon](https://acstuff.club/images/icons_24/treat.png)
---| `ui.Icons.Trophy` @![Icon](https://acstuff.club/images/icons_24/trophy.png)
---| `ui.Icons.TurnSignalLeft` @![Icon](https://acstuff.club/images/icons_24/turn_signal_left.png)
---| `ui.Icons.TurnSignalRight` @![Icon](https://acstuff.club/images/icons_24/turn_signal_right.png)
---| `ui.Icons.Tv` @![Icon](https://acstuff.club/images/icons_24/tv.png)
---| `ui.Icons.Tyre` @![Icon](https://acstuff.club/images/icons_24/tyre.png)
---| `ui.Icons.Umbrella` @![Icon](https://acstuff.club/images/icons_24/umbrella.png)
---| `ui.Icons.Undo` @![Icon](https://acstuff.club/images/icons_24/undo.png)
---| `ui.Icons.UpAlt` @![Icon](https://acstuff.club/images/icons_24/up_alt.png)
---| `ui.Icons.Up` @![Icon](https://acstuff.club/images/icons_24/up.png)
---| `ui.Icons.User` @![Icon](https://acstuff.club/images/icons_24/user.png)
---| `ui.Icons.Verified` @![Icon](https://acstuff.club/images/icons_24/verified.png)
---| `ui.Icons.VideoCameraAlt` @![Icon](https://acstuff.club/images/icons_24/video_camera_alt.png)
---| `ui.Icons.VideoCamera` @![Icon](https://acstuff.club/images/icons_24/video_camera.png)
---| `ui.Icons.VIP` @![Icon](https://acstuff.club/images/icons_24/vip.png)
---| `ui.Icons.VolumeHigh` @![Icon](https://acstuff.club/images/icons_24/volume_high.png)
---| `ui.Icons.VolumeLow` @![Icon](https://acstuff.club/images/icons_24/volume_low.png)
---| `ui.Icons.VolumeMedium` @![Icon](https://acstuff.club/images/icons_24/volume_medium.png)
---| `ui.Icons.Wallet` @![Icon](https://acstuff.club/images/icons_24/wallet.png)
---| `ui.Icons.Warning` @![Icon](https://acstuff.club/images/icons_24/warning.png)
---| `ui.Icons.WeatherClear` @![Icon](https://acstuff.club/images/icons_24/weather_clear.png)
---| `ui.Icons.WeatherCold` @![Icon](https://acstuff.club/images/icons_24/weather_cold.png)
---| `ui.Icons.WeatherDrizzle` @![Icon](https://acstuff.club/images/icons_24/weather_drizzle.png)
---| `ui.Icons.WeatherFewClouds` @![Icon](https://acstuff.club/images/icons_24/weather_few_clouds.png)
---| `ui.Icons.WeatherFog` @![Icon](https://acstuff.club/images/icons_24/weather_fog.png)
---| `ui.Icons.WeatherHail` @![Icon](https://acstuff.club/images/icons_24/weather_hail.png)
---| `ui.Icons.WeatherHot` @![Icon](https://acstuff.club/images/icons_24/weather_hot.png)
---| `ui.Icons.WeatherHurricane` @![Icon](https://acstuff.club/images/icons_24/weather_hurricane.png)
---| `ui.Icons.WeatherOvercast` @![Icon](https://acstuff.club/images/icons_24/weather_overcast.png)
---| `ui.Icons.WeatherRainLight` @![Icon](https://acstuff.club/images/icons_24/weather_rain_light.png)
---| `ui.Icons.WeatherRain` @![Icon](https://acstuff.club/images/icons_24/weather_rain.png)
---| `ui.Icons.WeatherSleet` @![Icon](https://acstuff.club/images/icons_24/weather_sleet.png)
---| `ui.Icons.WeatherSnowLight` @![Icon](https://acstuff.club/images/icons_24/weather_snow_light.png)
---| `ui.Icons.WeatherSnow` @![Icon](https://acstuff.club/images/icons_24/weather_snow.png)
---| `ui.Icons.WeatherStormLight` @![Icon](https://acstuff.club/images/icons_24/weather_storm_light.png)
---| `ui.Icons.WeatherStorm` @![Icon](https://acstuff.club/images/icons_24/weather_storm.png)
---| `ui.Icons.WeatherTornado` @![Icon](https://acstuff.club/images/icons_24/weather_tornado.png)
---| `ui.Icons.WeatherWarm` @![Icon](https://acstuff.club/images/icons_24/weather_warm.png)
---| `ui.Icons.WeatherWindySun` @![Icon](https://acstuff.club/images/icons_24/weather_windy_sun.png)
---| `ui.Icons.WeatherWindy` @![Icon](https://acstuff.club/images/icons_24/weather_windy.png)
---| `ui.Icons.Webcam` @![Icon](https://acstuff.club/images/icons_24/webcam.png)
---| `ui.Icons.Wheel` @![Icon](https://acstuff.club/images/icons_24/wheel.png)
---| `ui.Icons.Wind` @![Icon](https://acstuff.club/images/icons_24/wind.png)
---| `ui.Icons.Wrench` @![Icon](https://acstuff.club/images/icons_24/wrench.png)
---| `ui.Icons.YandexMusic` @![Icon](https://acstuff.club/images/icons_24/yandex_music.png)
---| `ui.Icons.YoutubeSolid` @![Icon](https://acstuff.club/images/icons_24/youtube_solid.png)
---| `ui.Icons.Youtube` @![Icon](https://acstuff.club/images/icons_24/youtube.png)
---| `ui.Icons.ZoomIn` @![Icon](https://acstuff.club/images/icons_24/zoom_in.png)
---| `ui.Icons.ZoomOut` @![Icon](https://acstuff.club/images/icons_24/zoom_out.png)
---| `ui.Icons.LoadingSpinner` @Value: 'fx:loading'.
ui.Icons = {
  Air = 'AIR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/air.png)
  AppWindow = 'APP_WINDOW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/app_window.png)
  Apps = 'APPS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/apps.png)
  ArrowDown = 'ARROW_DOWN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/arrow_down.png)
  ArrowLeft = 'ARROW_LEFT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/arrow_left.png)
  ArrowRight = 'ARROW_RIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/arrow_right.png)
  ArrowUp = 'ARROW_UP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/arrow_up.png)
  Assist = 'ASSIST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/assist.png)
  Attention = 'ATTENTION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/attention.png)
  Avatar = 'AVATAR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/avatar.png)
  Back = 'BACK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/back.png)
  Backspace = 'BACKSPACE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/backspace.png)
  Ballast = 'BALLAST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/ballast.png)
  Ban = 'BAN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/ban.png)
  Barcode = 'BARCODE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/barcode.png)
  Bars = 'BARS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bars.png)
  BatteryEmpty = 'BATTERY_EMPTY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/battery_empty.png)
  BatteryFull = 'BATTERY_FULL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/battery_full.png)
  Befriend = 'BEFRIEND', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/befriend.png)
  Bell = 'BELL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bell.png)
  Binocoulars = 'BINOCOULARS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/binocoulars.png)
  Blackboard = 'BLACKBOARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/blackboard.png)
  Blanket = 'BLANKET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/blanket.png)
  Blast = 'BLAST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/blast.png)
  Bluetooth = 'BLUETOOTH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bluetooth.png)
  Bomb = 'BOMB', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bomb.png)
  Book = 'BOOK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/book.png)
  Bookmark = 'BOOKMARK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bookmark.png)
  Box = 'BOX', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/box.png)
  Briefcase = 'BRIEFCASE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/briefcase.png)
  Bug = 'BUG', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bug.png)
  Bulb = 'BULB', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/bulb.png)
  Burn = 'BURN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/burn.png)
  Calculator = 'CALCULATOR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/calculator.png)
  Calendar = 'CALENDAR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/calendar.png)
  CallBluetooth = 'CALL_BLUETOOTH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/call_bluetooth.png)
  Call = 'CALL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/call.png)
  CameraAlt = 'CAMERA_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/camera_alt.png)
  Camera = 'CAMERA', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/camera.png)
  Cancel = 'CANCEL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/cancel.png)
  CarFront = 'CAR_FRONT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/car_front.png)
  Cards = 'CARDS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/cards.png)
  Cctv = 'CCTV', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/cctv.png)
  Cellphone = 'CELLPHONE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/cellphone.png)
  Chat = 'CHAT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/chat.png)
  Clapperboard = 'CLAPPERBOARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/clapperboard.png)
  Clip = 'CLIP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/clip.png)
  Clipboard = 'CLIPBOARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/clipboard.png)
  Clock = 'CLOCK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/clock.png)
  Cloud = 'CLOUD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/cloud.png)
  Code = 'CODE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/code.png)
  Coffee = 'COFFEE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/coffee.png)
  CollisionAlt = 'COLLISION_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/collision_alt.png)
  Collision = 'COLLISION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/collision.png)
  CompassAlt = 'COMPASS_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/compass_alt.png)
  Compass = 'COMPASS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/compass.png)
  Confirm = 'CONFIRM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/confirm.png)
  Constellation = 'CONSTELLATION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/constellation.png)
  Contacts = 'CONTACTS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/contacts.png)
  Contrast = 'CONTRAST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/contrast.png)
  Copy = 'COPY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/copy.png)
  CreditCard = 'CREDIT_CARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/credit_card.png)
  Crop = 'CROP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/crop.png)
  Crosshair = 'CROSSHAIR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/crosshair.png)
  Delete = 'DELETE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/delete.png)
  Dice = 'DICE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/dice.png)
  Directions = 'DIRECTIONS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/directions.png)
  Document = 'DOCUMENT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/document.png)
  DollarBill = 'DOLLAR_BILL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/dollar_bill.png)
  DownAlt = 'DOWN_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/down_alt.png)
  Down = 'DOWN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/down.png)
  Download = 'DOWNLOAD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/download.png)
  Driver = 'DRIVER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/driver.png)
  Earth = 'EARTH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/earth.png)
  Edit = 'EDIT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/edit.png)
  Eject = 'EJECT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/eject.png)
  Ellipsis = 'ELLIPSIS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/ellipsis.png)
  Enter = 'ENTER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/enter.png)
  Envelope = 'ENVELOPE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/envelope.png)
  Exit = 'EXIT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/exit.png)
  Eye = 'EYE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/eye.png)
  FastForward = 'FAST_FORWARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fast_forward.png)
  File = 'FILE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/file.png)
  FilmRoll = 'FILM_ROLL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/film_roll.png)
  Film = 'FILM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/film.png)
  Finish = 'FINISH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/finish.png)
  FireExtinguisher = 'FIRE_EXTINGUISHER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fire_extinguisher.png)
  Fireplace = 'FIREPLACE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fireplace.png)
  FlagAlt = 'FLAG_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/flag_alt.png)
  Flag = 'FLAG', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/flag.png)
  FM = 'FM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fm.png)
  Folder = 'FOLDER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/folder.png)
  Font = 'FONT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/font.png)
  Fuel = 'FUEL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fuel.png)
  Fullscreen = 'FULLSCREEN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/fullscreen.png)
  Gamepad = 'GAMEPAD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/gamepad.png)
  Ghost = 'GHOST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/ghost.png)
  Global = 'GLOBAL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/global.png)
  GlowThick = 'GLOW_THICK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/glow_thick.png)
  Glow = 'GLOW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/glow.png)
  GPS = 'GPS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/gps.png)
  Group = 'GROUP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/group.png)
  HammerAlt = 'HAMMER_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/hammer_alt.png)
  Hammer = 'HAMMER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/hammer.png)
  Hazard = 'HAZARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/hazard.png)
  Headphones = 'HEADPHONES', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/headphones.png)
  HeartOutline = 'HEART_OUTLINE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/heart_outline.png)
  Heart = 'HEART', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/heart.png)
  Helmet = 'HELMET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/helmet.png)
  Hide = 'HIDE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/hide.png)
  Home = 'HOME', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/home.png)
  Horizontal = 'HORIZONTAL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/horizontal.png)
  Hourglass = 'HOURGLASS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/hourglass.png)
  InboxEmpty = 'INBOX_EMPTY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/inbox_empty.png)
  InboxFull = 'INBOX_FULL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/inbox_full.png)
  Info = 'INFO', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/info.png)
  Key = 'KEY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/key.png)
  Keyboard = 'KEYBOARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/keyboard.png)
  Kick = 'KICK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/kick.png)
  Landscape = 'LANDSCAPE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/landscape.png)
  Laptop = 'LAPTOP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/laptop.png)
  Leaderboard = 'LEADERBOARD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/leaderboard.png)
  Leave = 'LEAVE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/leave.png)
  Lens = 'LENS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/lens.png)
  Levels = 'LEVELS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/levels.png)
  LinkBroken = 'LINK_BROKEN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/link_broken.png)
  Link = 'LINK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/link.png)
  ListAlt = 'LIST_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/list_alt.png)
  List = 'LIST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/list.png)
  Loading = 'LOADING', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/loading.png)
  Location = 'LOCATION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/location.png)
  Lua = 'LUA', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/lua.png)
  Magnet = 'MAGNET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/magnet.png)
  Map = 'MAP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/map.png)
  Maximize = 'MAXIMIZE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/maximize.png)
  Menu = 'MENU', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/menu.png)
  MicrophoneMuted = 'MICROPHONE_MUTED', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/microphone_muted.png)
  Microphone = 'MICROPHONE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/microphone.png)
  Minus = 'MINUS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/minus.png)
  Monitor = 'MONITOR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/monitor.png)
  Moon = 'MOON', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/moon.png)
  Mouse = 'MOUSE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/mouse.png)
  Music = 'MUSIC', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/music.png)
  Mute = 'MUTE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/mute.png)
  Navigation = 'NAVIGATION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/navigation.png)
  New = 'NEW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/new.png)
  Next = 'NEXT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/next.png)
  NotificationsAny = 'NOTIFICATIONS_ANY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/notifications_any.png)
  Notifications = 'NOTIFICATIONS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/notifications.png)
  PadlockUnlocked = 'PADLOCK_UNLOCKED', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/padlock_unlocked.png)
  Padlock = 'PADLOCK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/padlock.png)
  Palette = 'PALETTE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/palette.png)
  Paperclip = 'PAPERCLIP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/paperclip.png)
  Paste = 'PASTE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/paste.png)
  Pause = 'PAUSE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pause.png)
  Pedals = 'PEDALS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pedals.png)
  Person = 'PERSON', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/person.png)
  Photograph = 'PHOTOGRAPH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/photograph.png)
  Pin = 'PIN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pin.png)
  PitStopAlt = 'PIT_STOP_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pit_stop_alt.png)
  PitStop = 'PIT_STOP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pit_stop.png)
  Pitlane = 'PITLANE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/pitlane.png)
  Plane = 'PLANE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/plane.png)
  Play = 'PLAY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/play.png)
  Plug = 'PLUG', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/plug.png)
  Plus = 'PLUS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/plus.png)
  Preview = 'PREVIEW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/preview.png)
  Previous = 'PREVIOUS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/previous.png)
  Print = 'PRINT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/print.png)
  Process = 'PROCESS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/process.png)
  Puzzle = 'PUZZLE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/puzzle.png)
  Python = 'PYTHON', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/python.png)
  QR = 'QR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/qr.png)
  QuestionSign = 'QUESTION_SIGN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/question_sign.png)
  Question = 'QUESTION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/question.png)
  Radio = 'RADIO', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/radio.png)
  Recognition = 'RECOGNITION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/recognition.png)
  RecordAlt = 'RECORD_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/record_alt.png)
  Record = 'RECORD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/record.png)
  Redo = 'REDO', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/redo.png)
  Referee = 'REFEREE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/referee.png)
  Repair = 'REPAIR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/repair.png)
  Reset = 'RESET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/reset.png)
  RestartWarning = 'RESTART_WARNING', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/restart_warning.png)
  Restart = 'RESTART', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/restart.png)
  Restrictor = 'RESTRICTOR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/restrictor.png)
  Resume = 'RESUME', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/resume.png)
  Rewind = 'REWIND', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/rewind.png)
  Road = 'ROAD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/road.png)
  Route = 'ROUTE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/route.png)
  Rubber = 'RUBBER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/rubber.png)
  SatelliteDishLow = 'SATELLITE_DISH_LOW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/satellite_dish_low.png)
  SatelliteDishNone = 'SATELLITE_DISH_NONE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/satellite_dish_none.png)
  SatelliteDish = 'SATELLITE_DISH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/satellite_dish.png)
  Save = 'SAVE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/save.png)
  Scissors = 'SCISSORS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/scissors.png)
  Sea = 'SEA', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/sea.png)
  Search = 'SEARCH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/search.png)
  Send = 'SEND', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/send.png)
  Service = 'SERVICE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/service.png)
  SettingsAlt = 'SETTINGS_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/settings_alt.png)
  Settings = 'SETTINGS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/settings.png)
  ShieldWithLock = 'SHIELD_WITH_LOCK', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shield_with_lock.png)
  Shield = 'SHIELD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shield.png)
  ShiftActive = 'SHIFT_ACTIVE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shift_active.png)
  Shift = 'SHIFT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shift.png)
  Shopping = 'SHOPPING', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shopping.png)
  Shuffle = 'SHUFFLE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/shuffle.png)
  Skip = 'SKIP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/skip.png)
  Sleep = 'SLEEP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/sleep.png)
  Sliders = 'SLIDERS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/sliders.png)
  SlowMotion = 'SLOW_MOTION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/slow_motion.png)
  Smile = 'SMILE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/smile.png)
  Spaceship = 'SPACESHIP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/spaceship.png)
  Speaker = 'SPEAKER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/speaker.png)
  Speedometer = 'SPEEDOMETER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/speedometer.png)
  Spotify = 'SPOTIFY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/spotify.png)
  SquaresHorizontal = 'SQUARES_HORIZONTAL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/squares_horizontal.png)
  SquaresVertical = 'SQUARES_VERTICAL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/squares_vertical.png)
  StarEmpty = 'STAR_EMPTY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/star_empty.png)
  StarFull = 'STAR_FULL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/star_full.png)
  StarHalf = 'STAR_HALF', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/star_half.png)
  Start = 'START', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/start.png)
  Stats = 'STATS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/stats.png)
  Stay = 'STAY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/stay.png)
  SteeringWheel = 'STEERING_WHEEL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/steering_wheel.png)
  StopAlt = 'STOP_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/stop_alt.png)
  Stop = 'STOP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/stop.png)
  Stopwatch = 'STOPWATCH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/stopwatch.png)
  Sweeping = 'SWEEPING', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/sweeping.png)
  Tag = 'TAG', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/tag.png)
  Target = 'TARGET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/target.png)
  Team = 'TEAM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/team.png)
  Teleport = 'TELEPORT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/teleport.png)
  Tent = 'TENT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/tent.png)
  Thermometer = 'THERMOMETER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/thermometer.png)
  ThumbDown = 'THUMB_DOWN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/thumb_down.png)
  ThumbUp = 'THUMB_UP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/thumb_up.png)
  TimeRewind = 'TIME_REWIND', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/time_rewind.png)
  TopHat = 'TOP_HAT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/top_hat.png)
  TrafficLight = 'TRAFFIC_LIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/traffic_light.png)
  Transmission = 'TRANSMISSION', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/transmission.png)
  Trash = 'TRASH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/trash.png)
  Treat = 'TREAT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/treat.png)
  Trophy = 'TROPHY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/trophy.png)
  TurnSignalLeft = 'TURN_SIGNAL_LEFT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/turn_signal_left.png)
  TurnSignalRight = 'TURN_SIGNAL_RIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/turn_signal_right.png)
  Tv = 'TV', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/tv.png)
  Tyre = 'TYRE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/tyre.png)
  Umbrella = 'UMBRELLA', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/umbrella.png)
  Undo = 'UNDO', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/undo.png)
  UpAlt = 'UP_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/up_alt.png)
  Up = 'UP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/up.png)
  User = 'USER', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/user.png)
  Verified = 'VERIFIED', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/verified.png)
  VideoCameraAlt = 'VIDEO_CAMERA_ALT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/video_camera_alt.png)
  VideoCamera = 'VIDEO_CAMERA', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/video_camera.png)
  VIP = 'VIP', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/vip.png)
  VolumeHigh = 'VOLUME_HIGH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/volume_high.png)
  VolumeLow = 'VOLUME_LOW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/volume_low.png)
  VolumeMedium = 'VOLUME_MEDIUM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/volume_medium.png)
  Wallet = 'WALLET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/wallet.png)
  Warning = 'WARNING', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/warning.png)
  WeatherClear = 'WEATHER_CLEAR', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_clear.png)
  WeatherCold = 'WEATHER_COLD', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_cold.png)
  WeatherDrizzle = 'WEATHER_DRIZZLE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_drizzle.png)
  WeatherFewClouds = 'WEATHER_FEW_CLOUDS', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_few_clouds.png)
  WeatherFog = 'WEATHER_FOG', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_fog.png)
  WeatherHail = 'WEATHER_HAIL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_hail.png)
  WeatherHot = 'WEATHER_HOT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_hot.png)
  WeatherHurricane = 'WEATHER_HURRICANE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_hurricane.png)
  WeatherOvercast = 'WEATHER_OVERCAST', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_overcast.png)
  WeatherRainLight = 'WEATHER_RAIN_LIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_rain_light.png)
  WeatherRain = 'WEATHER_RAIN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_rain.png)
  WeatherSleet = 'WEATHER_SLEET', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_sleet.png)
  WeatherSnowLight = 'WEATHER_SNOW_LIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_snow_light.png)
  WeatherSnow = 'WEATHER_SNOW', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_snow.png)
  WeatherStormLight = 'WEATHER_STORM_LIGHT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_storm_light.png)
  WeatherStorm = 'WEATHER_STORM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_storm.png)
  WeatherTornado = 'WEATHER_TORNADO', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_tornado.png)
  WeatherWarm = 'WEATHER_WARM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_warm.png)
  WeatherWindySun = 'WEATHER_WINDY_SUN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_windy_sun.png)
  WeatherWindy = 'WEATHER_WINDY', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/weather_windy.png)
  Webcam = 'WEBCAM', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/webcam.png)
  Wheel = 'WHEEL', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/wheel.png)
  Wind = 'WIND', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/wind.png)
  Wrench = 'WRENCH', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/wrench.png)
  YandexMusic = 'YANDEX_MUSIC', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/yandex_music.png)
  YoutubeSolid = 'YOUTUBE_SOLID', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/youtube_solid.png)
  Youtube = 'YOUTUBE', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/youtube.png)
  ZoomIn = 'ZOOM_IN', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/zoom_in.png)
  ZoomOut = 'ZOOM_OUT', ---@type ui.Icons #![Icon](https://acstuff.club/images/icons_24/zoom_out.png)
  LoadingSpinner = 'fx:loading', ---@type ui.Icons #Value: 'fx:loading'.
}

---@alias render.ProjectFace
---| `render.ProjectFace.Auto` @Use current triple screen face during main rendering pass, or the whole screen during post-processing.
---| `render.ProjectFace.Screen` @`vec2(0, 0)` for the upper left corner of the screen, `vec2(0.5, 0.5)` for the center.
---| `render.ProjectFace.Current` @During main rendering pass, points to currently drawn face.
---| `render.ProjectFace.Left` @Value: 0.
---| `render.ProjectFace.Center` @Value: 1.
---| `render.ProjectFace.Right` @Value: 2.
render.ProjectFace = {
  Auto = -3, ---@type render.ProjectFace #Use current triple screen face during main rendering pass, or the whole screen during post-processing.
  Screen = -2, ---@type render.ProjectFace #`vec2(0, 0)` for the upper left corner of the screen, `vec2(0.5, 0.5)` for the center.
  Current = -1, ---@type render.ProjectFace #During main rendering pass, points to currently drawn face.
  Left = 0, ---@type render.ProjectFace #Value: 0.
  Center = 1, ---@type render.ProjectFace #Value: 1.
  Right = 2, ---@type render.ProjectFace #Value: 2.
}

---@alias render.PassID
---| `render.PassID.None` @No special options.
---| `render.PassID.Main` @Value: 0x1.
---| `render.PassID.Mirror` @Value: 0x2.
---| `render.PassID.CubeMap` @Value: 0x4.
---| `render.PassID.Extras` @Value: 0x8.
---| `render.PassID.All` @Value: 0xf.
render.PassID = {
  None = 0x0, ---@type render.PassID #No special options.
  Main = 0x1, ---@type render.PassID #Value: 0x1.
  Mirror = 0x2, ---@type render.PassID #Value: 0x2.
  CubeMap = 0x4, ---@type render.PassID #Value: 0x4.
  Extras = 0x8, ---@type render.PassID #Value: 0x8.
  All = 0xf, ---@type render.PassID #Value: 0xf.
}

---@alias render.BlendMode
---| `render.BlendMode.Opaque` @Value: 0.
---| `render.BlendMode.AlphaBlend` @Value: 1.
---| `render.BlendMode.AlphaTest` @Value: 2.
---| `render.BlendMode.BlendAdd` @Value: 4.
---| `render.BlendMode.BlendMultiply` @Value: 5.
---| `render.BlendMode.BlendSubtract` @Value: 12.
---| `render.BlendMode.BlendAccurate` @Value: 13.
---| `render.BlendMode.BlendPremultiplied` @Value: 14.
---| `render.BlendMode.OpaqueForced` @Works even in transparent pass.
render.BlendMode = {
  Opaque = 0, ---@type render.BlendMode #Value: 0.
  AlphaBlend = 1, ---@type render.BlendMode #Value: 1.
  AlphaTest = 2, ---@type render.BlendMode #Value: 2.
  BlendAdd = 4, ---@type render.BlendMode #Value: 4.
  BlendMultiply = 5, ---@type render.BlendMode #Value: 5.
  BlendSubtract = 12, ---@type render.BlendMode #Value: 12.
  BlendAccurate = 13, ---@type render.BlendMode #Value: 13.
  BlendPremultiplied = 14, ---@type render.BlendMode #Value: 14.
  OpaqueForced = 27, ---@type render.BlendMode #Works even in transparent pass.
}

---@alias render.CullMode
---| `render.CullMode.Front` @Value: 0.
---| `render.CullMode.Back` @Value: 1.
---| `render.CullMode.None` @Value: 2.
---| `render.CullMode.Wireframe` @Value: 4.
---| `render.CullMode.WireframeAntialised` @Value: 7.
---| `render.CullMode.ShadowsDouble` @Value: 9.
---| `render.CullMode.ShadowsSingle` @Value: 10.
render.CullMode = {
  Front = 0, ---@type render.CullMode #Value: 0.
  Back = 1, ---@type render.CullMode #Value: 1.
  None = 2, ---@type render.CullMode #Value: 2.
  Wireframe = 4, ---@type render.CullMode #Value: 4.
  WireframeAntialised = 7, ---@type render.CullMode #Value: 7.
  ShadowsDouble = 9, ---@type render.CullMode #Value: 9.
  ShadowsSingle = 10, ---@type render.CullMode #Value: 10.
}

---@alias render.DepthMode
---| `render.DepthMode.Normal` @Value: 0.
---| `render.DepthMode.ReadOnly` @Value: 1.
---| `render.DepthMode.Off` @Value: 2.
---| `render.DepthMode.LessEqual` @Value: 3.
---| `render.DepthMode.ReadOnlyLessEqual` @Value: 4.
---| `render.DepthMode.WriteOnly` @Value: 7.
render.DepthMode = {
  Normal = 0, ---@type render.DepthMode #Value: 0.
  ReadOnly = 1, ---@type render.DepthMode #Value: 1.
  Off = 2, ---@type render.DepthMode #Value: 2.
  LessEqual = 3, ---@type render.DepthMode #Value: 3.
  ReadOnlyLessEqual = 4, ---@type render.DepthMode #Value: 4.
  WriteOnly = 7, ---@type render.DepthMode #Value: 7.
}

---@alias render.GLPrimitiveType
---| `render.GLPrimitiveType.Lines` @Value: 0.
---| `render.GLPrimitiveType.LinesStrip` @Value: 1.
---| `render.GLPrimitiveType.Triangles` @Value: 2.
---| `render.GLPrimitiveType.Quads` @Value: 3.
render.GLPrimitiveType = {
  Lines = 0, ---@type render.GLPrimitiveType #Value: 0.
  LinesStrip = 1, ---@type render.GLPrimitiveType #Value: 1.
  Triangles = 2, ---@type render.GLPrimitiveType #Value: 2.
  Quads = 3, ---@type render.GLPrimitiveType #Value: 3.
}

---@alias render.FontAlign
---| `render.FontAlign.Left` @Value: 0.
---| `render.FontAlign.Right` @Value: 1.
---| `render.FontAlign.Center` @Value: 2.
render.FontAlign = {
  Left = 0, ---@type render.FontAlign #Value: 0.
  Right = 1, ---@type render.FontAlign #Value: 1.
  Center = 2, ---@type render.FontAlign #Value: 2.
}

---@alias render.ShadersType
---| `render.ShadersType.Main` @With lights and advanced version of shaders (when possible, consider using SimplifiedWithLights instead).
---| `render.ShadersType.Simplified` @Used by reflections and mirrors, without lights.
---| `render.ShadersType.SimplifiedWithLights` @Used by reflections and mirrors, with lights.
---| `render.ShadersType.Simplest` @The most basic option, without lights.
---| `render.ShadersType.SampleColor` @Get diffuse color as accurate as possible.
---| `render.ShadersType.SampleNormal` @Get surface normal in world space.
---| `render.ShadersType.SampleEmissive` @Get emissive color.
---| `render.ShadersType.Shadows` @@deprecated If you want cool looks, use `Main` instead, this was originally meant to draw shadow maps, but due to some general issues isn’t working as intended, and for actual shadows use `SampleDepth`.
---| `render.ShadersType.SampleDepth` @Efficient option for generating depth map without wasting time on drawing the image, doesn’t update the main color texture (only meshes casting shadows are included).
render.ShadersType = {
  Main = 0, ---@type render.ShadersType #With lights and advanced version of shaders (when possible, consider using SimplifiedWithLights instead).
  Simplified = 13, ---@type render.ShadersType #Used by reflections and mirrors, without lights.
  SimplifiedWithLights = 14, ---@type render.ShadersType #Used by reflections and mirrors, with lights.
  Simplest = 16, ---@type render.ShadersType #The most basic option, without lights.
  SampleColor = 18, ---@type render.ShadersType #Get diffuse color as accurate as possible.
  SampleNormal = 19, ---@type render.ShadersType #Get surface normal in world space.
  SampleEmissive = 20, ---@type render.ShadersType #Get emissive color.
  Shadows = 0, ---@type render.ShadersType #@deprecated If you want cool looks, use `Main` instead, this was originally meant to draw shadow maps, but due to some general issues isn’t working as intended, and for actual shadows use `SampleDepth`.
  SampleDepth = 27, ---@type render.ShadersType #Efficient option for generating depth map without wasting time on drawing the image, doesn’t update the main color texture (only meshes casting shadows are included).
}

---These flags can be combined together with `bit.bor()`.
---@alias render.TextureMaskFlags
---| `render.TextureMaskFlags.Default` @Default: use alpha and red channel as multipliers.
---| `render.TextureMaskFlags.UseColorAverage` @Use average of RGB values.
---| `render.TextureMaskFlags.UseAlpha` @Use alpha of a mask as a multiplier.
---| `render.TextureMaskFlags.UseRed` @Use red channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseGreen` @Use green channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseBlue` @Use blue channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedAlpha` @Use inverted alpha of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedRed` @Use inverted red channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedGreen` @Use inverted green channel of a mask as a multiplier.
---| `render.TextureMaskFlags.UseInvertedBlue` @Use inverted blue channel of a mask as a multiplier.
---| `render.TextureMaskFlags.MixColors` @Use colors of a mask as a multiplier for main colors.
---| `render.TextureMaskFlags.MixInvertedColors` @Use inverted colors of a mask as a multiplier for main colors.
---| `render.TextureMaskFlags.AltUV` @Use alternative UV (for projecting textures onto meshes, uses original mesh UV instead of projection UV).
render.TextureMaskFlags = {
  Default = 0x6, ---@type render.TextureMaskFlags #Default: use alpha and red channel as multipliers.
  UseColorAverage = 0x1, ---@type render.TextureMaskFlags #Use average of RGB values.
  UseAlpha = 0x2, ---@type render.TextureMaskFlags #Use alpha of a mask as a multiplier.
  UseRed = 0x4, ---@type render.TextureMaskFlags #Use red channel of a mask as a multiplier.
  UseGreen = 0x8, ---@type render.TextureMaskFlags #Use green channel of a mask as a multiplier.
  UseBlue = 0x10, ---@type render.TextureMaskFlags #Use blue channel of a mask as a multiplier.
  UseInvertedAlpha = 0x20, ---@type render.TextureMaskFlags #Use inverted alpha of a mask as a multiplier.
  UseInvertedRed = 0x40, ---@type render.TextureMaskFlags #Use inverted red channel of a mask as a multiplier.
  UseInvertedGreen = 0x80, ---@type render.TextureMaskFlags #Use inverted green channel of a mask as a multiplier.
  UseInvertedBlue = 0x100, ---@type render.TextureMaskFlags #Use inverted blue channel of a mask as a multiplier.
  MixColors = 0x200, ---@type render.TextureMaskFlags #Use colors of a mask as a multiplier for main colors.
  MixInvertedColors = 0x400, ---@type render.TextureMaskFlags #Use inverted colors of a mask as a multiplier for main colors.
  AltUV = 0x10000, ---@type render.TextureMaskFlags #Use alternative UV (for projecting textures onto meshes, uses original mesh UV instead of projection UV).
}

---@alias render.AntialiasingMode
---| `render.AntialiasingMode.None` @No antialiasing.
---| `render.AntialiasingMode.FXAA` @Blurry and slower than CMAA.
---| `render.AntialiasingMode.CMAA` @Faster and sharper option comparing to FXAA.
---| `render.AntialiasingMode.ExtraSharpCMAA` @Like CMAA, but even sharper.
---| `render.AntialiasingMode.YEBIS` @Applies YEBIS antialiasing together with the whole filtering HDR→LDR conversion using main PP settings. Note: first run for each resolution can take a lot of time. Each resolution creates its own YEBIS post-processing step, with many different resolutions things might get too expensive.
render.AntialiasingMode = {
  None = 0, ---@type render.AntialiasingMode #No antialiasing.
  FXAA = 101, ---@type render.AntialiasingMode #Blurry and slower than CMAA.
  CMAA = 102, ---@type render.AntialiasingMode #Faster and sharper option comparing to FXAA.
  ExtraSharpCMAA = 103, ---@type render.AntialiasingMode #Like CMAA, but even sharper.
  YEBIS = 104, ---@type render.AntialiasingMode #Applies YEBIS antialiasing together with the whole filtering HDR→LDR conversion using main PP settings. Note: first run for each resolution can take a lot of time. Each resolution creates its own YEBIS post-processing step, with many different resolutions things might get too expensive.
}

---@alias render.TextureFormat
---| `render.TextureFormat.R32G32B32A32.Float` @Value: '2'.
---| `render.TextureFormat.R32G32B32A32.UInt` @Value: '3'.
---| `render.TextureFormat.R32G32B32A32.SInt` @Value: '4'.
---| `render.TextureFormat.R32G32B32.Float` @Value: '6'.
---| `render.TextureFormat.R32G32B32.UInt` @Value: '7'.
---| `render.TextureFormat.R32G32B32.SInt` @Value: '8'.
---| `render.TextureFormat.R32G32.Float` @Value: '16'.
---| `render.TextureFormat.R32G32.UInt` @Value: '17'.
---| `render.TextureFormat.R32G32.SInt` @Value: '18'.
---| `render.TextureFormat.R32.Float` @Value: '41'.
---| `render.TextureFormat.R32.UInt` @Value: '42'.
---| `render.TextureFormat.R32.SInt` @Value: '43'.
---| `render.TextureFormat.R16G16B16A16.Float` @Value: '10'.
---| `render.TextureFormat.R16G16B16A16.UNorm` @Value: '11'.
---| `render.TextureFormat.R16G16B16A16.UInt` @Value: '12'.
---| `render.TextureFormat.R16G16B16A16.SNorm` @Value: '13'.
---| `render.TextureFormat.R16G16B16A16.SInt` @Value: '14'.
---| `render.TextureFormat.R16G16.Float` @Value: '34'.
---| `render.TextureFormat.R16G16.UNorm` @Value: '35'.
---| `render.TextureFormat.R16G16.UInt` @Value: '36'.
---| `render.TextureFormat.R16G16.SNorm` @Value: '37'.
---| `render.TextureFormat.R16G16.SInt` @Value: '38'.
---| `render.TextureFormat.R16.Float` @Value: '54'.
---| `render.TextureFormat.R16.UNorm` @Value: '56'.
---| `render.TextureFormat.R16.UInt` @Value: '57'.
---| `render.TextureFormat.R16.SNorm` @Value: '58'.
---| `render.TextureFormat.R16.SInt` @Value: '59'.
---| `render.TextureFormat.R10G10B10A2.UNorm` @Value: '24'.
---| `render.TextureFormat.R10G10B10A2.UInt` @Value: '25'.
---| `render.TextureFormat.R11G11B10.Float` @Value: '26'.
---| `render.TextureFormat.R8G8B8A8.UNorm` @Value: '28'.
---| `render.TextureFormat.R8G8B8A8.UInt` @Value: '30'.
---| `render.TextureFormat.R8G8B8A8.SNorm` @Value: '31'.
---| `render.TextureFormat.R8G8B8A8.SInt` @Value: '32'.
---| `render.TextureFormat.R8G8.UNorm` @Value: '49'.
---| `render.TextureFormat.R8G8.UInt` @Value: '50'.
---| `render.TextureFormat.R8G8.SNorm` @Value: '51'.
---| `render.TextureFormat.R8G8.SInt` @Value: '52'.
---| `render.TextureFormat.R8.UNorm` @Value: '61'.
---| `render.TextureFormat.R8.UInt` @Value: '62'.
---| `render.TextureFormat.R8.SNorm` @Value: '63'.
---| `render.TextureFormat.R8.SInt` @Value: '64'.
---| `render.TextureFormat.R1.UNorm` @Value: '66'.
render.TextureFormat = {
  R32G32B32A32 = {Float = 2,UInt = 3,SInt = 4}, ---Value: {Float = 2,UInt = 3,SInt = 4}.
  R32G32B32 = {Float = 6,UInt = 7,SInt = 8}, ---Value: {Float = 6,UInt = 7,SInt = 8}.
  R32G32 = {Float = 16,UInt = 17,SInt = 18}, ---Value: {Float = 16,UInt = 17,SInt = 18}.
  R32 = {Float = 41,UInt = 42,SInt = 43}, ---Value: {Float = 41,UInt = 42,SInt = 43}.
  R16G16B16A16 = {Float = 10,UNorm = 11,UInt = 12,SNorm = 13,SInt = 14}, ---Value: {Float = 10,UNorm = 11,UInt = 12,SNorm = 13,SInt = 14}.
  R16G16 = {Float = 34,UNorm = 35,UInt = 36,SNorm = 37,SInt = 38}, ---Value: {Float = 34,UNorm = 35,UInt = 36,SNorm = 37,SInt = 38}.
  R16 = {Float = 54,UNorm = 56,UInt = 57,SNorm = 58,SInt = 59}, ---Value: {Float = 54,UNorm = 56,UInt = 57,SNorm = 58,SInt = 59}.
  R10G10B10A2 = {UNorm = 24,UInt = 25}, ---Value: {UNorm = 24,UInt = 25}.
  R11G11B10 = {Float = 26}, ---Value: {Float = 26}.
  R8G8B8A8 = {UNorm = 28,UInt = 30,SNorm = 31,SInt = 32}, ---Value: {UNorm = 28,UInt = 30,SNorm = 31,SInt = 32}.
  R8G8 = {UNorm = 49,UInt = 50,SNorm = 51,SInt = 52}, ---Value: {UNorm = 49,UInt = 50,SNorm = 51,SInt = 52}.
  R8 = {UNorm = 61,UInt = 62,SNorm = 63,SInt = 64}, ---Value: {UNorm = 61,UInt = 62,SNorm = 63,SInt = 64}.
  R1 = {UNorm = 66}, ---Value: {UNorm = 66}.
}

---@alias render.TextureFlags
---| `render.TextureFlags.None` @Value: 0.
---| `render.TextureFlags.Shared` @Shared texture (D3D11_RESOURCE_MISC_SHARED).
render.TextureFlags = {
  None = 0, ---@type render.TextureFlags #Value: 0.
  Shared = 1, ---@type render.TextureFlags #Shared texture (D3D11_RESOURCE_MISC_SHARED).
}

---@alias ui.ImageFit
---| `ui.ImageFit.Stretch` @Do not preserve aspect ratio (a bit faster too).
---| `ui.ImageFit.Fill` @Preserve aspect ratio, stretch image to fill out the area.
---| `ui.ImageFit.Fit` @Preserve aspect ratio, shrink image leaving blank areas.
ui.ImageFit = {
  Stretch = 0, ---@type ui.ImageFit #Do not preserve aspect ratio (a bit faster too).
  Fill = 1, ---@type ui.ImageFit #Preserve aspect ratio, stretch image to fill out the area.
  Fit = 2, ---@type ui.ImageFit #Preserve aspect ratio, shrink image leaving blank areas.
}

---@alias ui.CornerFlags
---| `ui.CornerFlags.None` @Value: 0.
---| `ui.CornerFlags.TopLeft` @Value: 1.
---| `ui.CornerFlags.TopRight` @Value: 2.
---| `ui.CornerFlags.BottomLeft` @Value: 4.
---| `ui.CornerFlags.BottomRight` @Value: 8.
---| `ui.CornerFlags.Top` @Value: 3.
---| `ui.CornerFlags.Bottom` @Value: 12.
---| `ui.CornerFlags.Left` @Value: 5.
---| `ui.CornerFlags.Right` @Value: 10.
---| `ui.CornerFlags.All` @Value: 15.
ui.CornerFlags = {
  None = 0, ---@type ui.CornerFlags #Value: 0.
  TopLeft = 1, ---@type ui.CornerFlags #Value: 1.
  TopRight = 2, ---@type ui.CornerFlags #Value: 2.
  BottomLeft = 4, ---@type ui.CornerFlags #Value: 4.
  BottomRight = 8, ---@type ui.CornerFlags #Value: 8.
  Top = 3, ---@type ui.CornerFlags #Value: 3.
  Bottom = 12, ---@type ui.CornerFlags #Value: 12.
  Left = 5, ---@type ui.CornerFlags #Value: 5.
  Right = 10, ---@type ui.CornerFlags #Value: 10.
  All = 15, ---@type ui.CornerFlags #Value: 15.
}

---@alias ui.Direction
---| `ui.Direction.None` @Value: -1.
---| `ui.Direction.Left` @Value: 0.
---| `ui.Direction.Right` @Value: 1.
---| `ui.Direction.Up` @Value: 2.
---| `ui.Direction.Down` @Value: 3.
ui.Direction = {
  None = -1, ---@type ui.Direction #Value: -1.
  Left = 0, ---@type ui.Direction #Value: 0.
  Right = 1, ---@type ui.Direction #Value: 1.
  Up = 2, ---@type ui.Direction #Value: 2.
  Down = 3, ---@type ui.Direction #Value: 3.
}

---@alias ui.HoveredFlags
---| `ui.HoveredFlags.None` @Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
---| `ui.HoveredFlags.ChildWindows` @`ac.windowHovered()` only: Return true if any children of the window is hovered.
---| `ui.HoveredFlags.RootWindow` @`ac.windowHovered()` only: Test from root window (top most parent of the current hierarchy).
---| `ui.HoveredFlags.AnyWindow` @`ac.windowHovered()` only: Return true if any window is hovered.
---| `ui.HoveredFlags.AllowWhenBlockedByPopup` @Return true even if a popup window is normally blocking access to this item/window.
---| `ui.HoveredFlags.AllowWhenBlockedByActiveItem` @Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
---| `ui.HoveredFlags.AllowWhenOverlapped` @Return true even if the position is obstructed or overlapped by another window.
---| `ui.HoveredFlags.AllowWhenDisabled` @Return true even if the item is disabled.
---| `ui.HoveredFlags.RectOnly` @Combination of flags: AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped (use `bit.bor(ui.HoveredFlags.RectOnly, …)` to combine it with other flags safely).
---| `ui.HoveredFlags.RootAndChildWindows` @Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.HoveredFlags.RootAndChildWindows, …)` to combine it with other flags safely).
ui.HoveredFlags = {
  None = 0, ---@type ui.HoveredFlags #Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
  ChildWindows = 1, ---@type ui.HoveredFlags #`ac.windowHovered()` only: Return true if any children of the window is hovered.
  RootWindow = 2, ---@type ui.HoveredFlags #`ac.windowHovered()` only: Test from root window (top most parent of the current hierarchy).
  AnyWindow = 4, ---@type ui.HoveredFlags #`ac.windowHovered()` only: Return true if any window is hovered.
  AllowWhenBlockedByPopup = 8, ---@type ui.HoveredFlags #Return true even if a popup window is normally blocking access to this item/window.
  AllowWhenBlockedByActiveItem = 32, ---@type ui.HoveredFlags #Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
  AllowWhenOverlapped = 64, ---@type ui.HoveredFlags #Return true even if the position is obstructed or overlapped by another window.
  AllowWhenDisabled = 128, ---@type ui.HoveredFlags #Return true even if the item is disabled.
  RectOnly = 104, ---@type ui.HoveredFlags #Combination of flags: AllowWhenBlockedByPopup|AllowWhenBlockedByActiveItem|AllowWhenOverlapped (use `bit.bor(ui.HoveredFlags.RectOnly, …)` to combine it with other flags safely).
  RootAndChildWindows = 3, ---@type ui.HoveredFlags #Combination of flags: RootWindow|ChildWindows (use `bit.bor(ui.HoveredFlags.RootAndChildWindows, …)` to combine it with other flags safely).
}

---@alias ui.FocusedFlags
---| `ui.FocusedFlags.None` @Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
---| `ui.FocusedFlags.ChildWindows` @`ac.windowFocused()` only: Return true if any children of the window is hovered.
---| `ui.FocusedFlags.RootWindow` @`ac.windowFocused()` only: Test from root window (top most parent of the current hierarchy).
---| `ui.FocusedFlags.AnyWindow` @`ac.windowFocused()` only: Return true if any window is hovered.
---| `ui.FocusedFlags.RootAndChildWindows` @Combination of flags: RootWindow | ChildWindows (use `bit.bor(ui.FocusedFlags.RootAndChildWindows, …)` to combine it with other flags safely).
ui.FocusedFlags = {
  None = 0, ---@type ui.FocusedFlags #Return true if directly over the item/window, not obstructed by another window, not obstructed by an active popup or modal blocking inputs under them.
  ChildWindows = 1, ---@type ui.FocusedFlags #`ac.windowFocused()` only: Return true if any children of the window is hovered.
  RootWindow = 2, ---@type ui.FocusedFlags #`ac.windowFocused()` only: Test from root window (top most parent of the current hierarchy).
  AnyWindow = 4, ---@type ui.FocusedFlags #`ac.windowFocused()` only: Return true if any window is hovered.
  RootAndChildWindows = 3, ---@type ui.FocusedFlags #Combination of flags: RootWindow|ChildWindows (use `bit.bor(ui.FocusedFlags.RootAndChildWindows, …)` to combine it with other flags safely).
}

---@alias ui.MouseCursor
---| `ui.MouseCursor.None` @No cursor.
---| `ui.MouseCursor.Arrow` @Default arrow.
---| `ui.MouseCursor.TextInput` @When hovering over `ui.inputText()`, etc.
---| `ui.MouseCursor.ResizeAll` @Unused by default controls.
---| `ui.MouseCursor.ResizeNS` @When hovering over an horizontal border.
---| `ui.MouseCursor.ResizeEW` @When hovering over a vertical border or a column.
---| `ui.MouseCursor.ResizeNESW` @When hovering over the bottom-left corner of a window.
---| `ui.MouseCursor.ResizeNWSE` @When hovering over the bottom-right corner of a window.
---| `ui.MouseCursor.Hand` @Unused by default controls. Use for e.g. hyperlinks.
---| `ui.MouseCursor.Cross` @Value: 9.
---| `ui.MouseCursor.UpArrow` @Value: 10.
---| `ui.MouseCursor.Size` @Value: 11.
---| `ui.MouseCursor.Icon` @Value: 12.
---| `ui.MouseCursor.No` @Value: 13.
---| `ui.MouseCursor.Wait` @Value: 14.
---| `ui.MouseCursor.AppStarting` @Value: 15.
---| `ui.MouseCursor.Help` @Value: 16.
---| `ui.MouseCursor.Pin` @Value: 17.
---| `ui.MouseCursor.Person` @Value: 18.
ui.MouseCursor = {
  None = -1, ---@type ui.MouseCursor #No cursor.
  Arrow = 0, ---@type ui.MouseCursor #Default arrow.
  TextInput = 1, ---@type ui.MouseCursor #When hovering over `ui.inputText()`, etc.
  ResizeAll = 2, ---@type ui.MouseCursor #Unused by default controls.
  ResizeNS = 3, ---@type ui.MouseCursor #When hovering over an horizontal border.
  ResizeEW = 4, ---@type ui.MouseCursor #When hovering over a vertical border or a column.
  ResizeNESW = 5, ---@type ui.MouseCursor #When hovering over the bottom-left corner of a window.
  ResizeNWSE = 6, ---@type ui.MouseCursor #When hovering over the bottom-right corner of a window.
  Hand = 7, ---@type ui.MouseCursor #Unused by default controls. Use for e.g. hyperlinks.
  Cross = 9, ---@type ui.MouseCursor #Value: 9.
  UpArrow = 10, ---@type ui.MouseCursor #Value: 10.
  Size = 11, ---@type ui.MouseCursor #Value: 11.
  Icon = 12, ---@type ui.MouseCursor #Value: 12.
  No = 13, ---@type ui.MouseCursor #Value: 13.
  Wait = 14, ---@type ui.MouseCursor #Value: 14.
  AppStarting = 15, ---@type ui.MouseCursor #Value: 15.
  Help = 16, ---@type ui.MouseCursor #Value: 16.
  Pin = 17, ---@type ui.MouseCursor #Value: 17.
  Person = 18, ---@type ui.MouseCursor #Value: 18.
}

---@alias ui.MouseButton
---| `ui.MouseButton.Left` @Value: 0.
---| `ui.MouseButton.Right` @Value: 1.
---| `ui.MouseButton.Middle` @Value: 2.
---| `ui.MouseButton.Extra1` @Value: 3.
---| `ui.MouseButton.Extra2` @Value: 4.
ui.MouseButton = {
  Left = 0, ---@type ui.MouseButton #Value: 0.
  Right = 1, ---@type ui.MouseButton #Value: 1.
  Middle = 2, ---@type ui.MouseButton #Value: 2.
  Extra1 = 3, ---@type ui.MouseButton #Value: 3.
  Extra2 = 4, ---@type ui.MouseButton #Value: 4.
}

---@alias ui.Font
---| `ui.Font.Small` @Value: 1.
---| `ui.Font.Tiny` @Value: 2.
---| `ui.Font.Monospace` @Value: 3.
---| `ui.Font.Main` @Value: 4.
---| `ui.Font.Italic` @Value: 5.
---| `ui.Font.Title` @Value: 6.
---| `ui.Font.Huge` @Value: 7.
---| `ui.Font.SmallItalic` @Value: 8.
ui.Font = {
  Small = 1, ---@type ui.Font #Value: 1.
  Tiny = 2, ---@type ui.Font #Value: 2.
  Monospace = 3, ---@type ui.Font #Value: 3.
  Main = 4, ---@type ui.Font #Value: 4.
  Italic = 5, ---@type ui.Font #Value: 5.
  Title = 6, ---@type ui.Font #Value: 6.
  Huge = 7, ---@type ui.Font #Value: 7.
  SmallItalic = 8, ---@type ui.Font #Value: 8.
}

---@alias ui.Alignment
---| `ui.Alignment.Start` @Value: -1.
---| `ui.Alignment.Center` @Value: 0.
---| `ui.Alignment.End` @Value: 1.
ui.Alignment = {
  Start = -1, ---@type ui.Alignment #Value: -1.
  Center = 0, ---@type ui.Alignment #Value: 0.
  End = 1, ---@type ui.Alignment #Value: 1.
}

---Special codes for keys with certain UI roles.
---@alias ui.Key
---| `ui.Key.Tab` @Value: 0.
---| `ui.Key.Left` @Value: 1.
---| `ui.Key.Right` @Value: 2.
---| `ui.Key.Up` @Value: 3.
---| `ui.Key.Down` @Value: 4.
---| `ui.Key.PageUp` @Value: 5.
---| `ui.Key.PageDown` @Value: 6.
---| `ui.Key.Home` @Value: 7.
---| `ui.Key.End` @Value: 8.
---| `ui.Key.Insert` @Value: 9.
---| `ui.Key.Delete` @Value: 10.
---| `ui.Key.Backspace` @Value: 11.
---| `ui.Key.Space` @Value: 12.
---| `ui.Key.Enter` @Value: 13.
---| `ui.Key.Escape` @Value: 14.
---| `ui.Key.KeyPadEnter` @Value: 15.
---| `ui.Key.A` @Value: 16.
---| `ui.Key.C` @Value: 17.
---| `ui.Key.D` @Value: 18.
---| `ui.Key.S` @Value: 19.
---| `ui.Key.V` @Value: 20.
---| `ui.Key.W` @Value: 21.
---| `ui.Key.X` @Value: 22.
---| `ui.Key.Y` @Value: 23.
---| `ui.Key.Z` @Value: 24.
ui.Key = {
  Tab = 0, ---@type ui.Key #Value: 0.
  Left = 1, ---@type ui.Key #Value: 1.
  Right = 2, ---@type ui.Key #Value: 2.
  Up = 3, ---@type ui.Key #Value: 3.
  Down = 4, ---@type ui.Key #Value: 4.
  PageUp = 5, ---@type ui.Key #Value: 5.
  PageDown = 6, ---@type ui.Key #Value: 6.
  Home = 7, ---@type ui.Key #Value: 7.
  End = 8, ---@type ui.Key #Value: 8.
  Insert = 9, ---@type ui.Key #Value: 9.
  Delete = 10, ---@type ui.Key #Value: 10.
  Backspace = 11, ---@type ui.Key #Value: 11.
  Space = 12, ---@type ui.Key #Value: 12.
  Enter = 13, ---@type ui.Key #Value: 13.
  Escape = 14, ---@type ui.Key #Value: 14.
  KeyPadEnter = 15, ---@type ui.Key #Value: 15.
  A = 16, ---@type ui.Key #Value: 16.
  C = 17, ---@type ui.Key #Value: 17.
  D = 18, ---@type ui.Key #Value: 18.
  S = 19, ---@type ui.Key #Value: 19.
  V = 20, ---@type ui.Key #Value: 20.
  W = 21, ---@type ui.Key #Value: 21.
  X = 22, ---@type ui.Key #Value: 22.
  Y = 23, ---@type ui.Key #Value: 23.
  Z = 24, ---@type ui.Key #Value: 24.
}

---@alias ui.StyleVar
---| `ui.StyleVar.Alpha` @Expects a number.
---| `ui.StyleVar.WindowRounding` @Expects a number.
---| `ui.StyleVar.WindowBorderSize` @Expects a number.
---| `ui.StyleVar.ChildRounding` @Expects a number.
---| `ui.StyleVar.ChildBorderSize` @Expects a number.
---| `ui.StyleVar.PopupRounding` @Expects a number.
---| `ui.StyleVar.PopupBorderSize` @Expects a number.
---| `ui.StyleVar.FrameRounding` @Expects a number.
---| `ui.StyleVar.FrameBorderSize` @Expects a number.
---| `ui.StyleVar.IndentSpacing` @Expects a number.
---| `ui.StyleVar.ScrollbarSize` @Expects a number.
---| `ui.StyleVar.ScrollbarRounding` @Expects a number.
---| `ui.StyleVar.GrabMinSize` @Expects a number.
---| `ui.StyleVar.GrabRounding` @Expects a number.
---| `ui.StyleVar.TabRounding` @Expects a number.
---| `ui.StyleVar.WindowPadding` @Expects a `vec2` value.
---| `ui.StyleVar.WindowMinSize` @Expects a `vec2` value.
---| `ui.StyleVar.WindowTitleAlign` @Expects a `vec2` value.
---| `ui.StyleVar.FramePadding` @Expects a `vec2` value.
---| `ui.StyleVar.ItemSpacing` @Expects a `vec2` value.
---| `ui.StyleVar.ItemInnerSpacing` @Expects a `vec2` value.
---| `ui.StyleVar.ButtonTextAlign` @Expects a `vec2` value.
---| `ui.StyleVar.SelectableTextAlign` @Expects a `vec2` value.
---| `ui.StyleVar.SelectablePadding` @Expects a `vec2` value.
---| `ui.StyleVar.SliderTextAlign` @Expects a `vec2` value. Added in 0.2.8.
ui.StyleVar = {
  Alpha = 0, ---@type ui.StyleVar #Expects a number.
  WindowRounding = 1, ---@type ui.StyleVar #Expects a number.
  WindowBorderSize = 2, ---@type ui.StyleVar #Expects a number.
  ChildRounding = 3, ---@type ui.StyleVar #Expects a number.
  ChildBorderSize = 4, ---@type ui.StyleVar #Expects a number.
  PopupRounding = 5, ---@type ui.StyleVar #Expects a number.
  PopupBorderSize = 6, ---@type ui.StyleVar #Expects a number.
  FrameRounding = 7, ---@type ui.StyleVar #Expects a number.
  FrameBorderSize = 8, ---@type ui.StyleVar #Expects a number.
  IndentSpacing = 9, ---@type ui.StyleVar #Expects a number.
  ScrollbarSize = 10, ---@type ui.StyleVar #Expects a number.
  ScrollbarRounding = 11, ---@type ui.StyleVar #Expects a number.
  GrabMinSize = 12, ---@type ui.StyleVar #Expects a number.
  GrabRounding = 13, ---@type ui.StyleVar #Expects a number.
  TabRounding = 14, ---@type ui.StyleVar #Expects a number.
  WindowPadding = 15, ---@type ui.StyleVar #Expects a `vec2` value.
  WindowMinSize = 16, ---@type ui.StyleVar #Expects a `vec2` value.
  WindowTitleAlign = 17, ---@type ui.StyleVar #Expects a `vec2` value.
  FramePadding = 18, ---@type ui.StyleVar #Expects a `vec2` value.
  ItemSpacing = 19, ---@type ui.StyleVar #Expects a `vec2` value.
  ItemInnerSpacing = 20, ---@type ui.StyleVar #Expects a `vec2` value.
  ButtonTextAlign = 21, ---@type ui.StyleVar #Expects a `vec2` value.
  SelectableTextAlign = 22, ---@type ui.StyleVar #Expects a `vec2` value.
  SelectablePadding = 23, ---@type ui.StyleVar #Expects a `vec2` value.
  SliderTextAlign = 24, ---@type ui.StyleVar #Expects a `vec2` value. Added in 0.2.8.
}

---@alias ui.StyleColor
---| `ui.StyleColor.Text` @Value: 0.
---| `ui.StyleColor.TextDisabled` @Value: 1.
---| `ui.StyleColor.WindowBg` @Value: 2.
---| `ui.StyleColor.ChildBg` @Value: 3.
---| `ui.StyleColor.PopupBg` @Value: 4.
---| `ui.StyleColor.Border` @Value: 5.
---| `ui.StyleColor.BorderShadow` @Value: 6.
---| `ui.StyleColor.FrameBg` @Value: 7.
---| `ui.StyleColor.FrameBgHovered` @Value: 8.
---| `ui.StyleColor.FrameBgActive` @Value: 9.
---| `ui.StyleColor.TitleBg` @Value: 10.
---| `ui.StyleColor.TitleBgActive` @Value: 11.
---| `ui.StyleColor.TitleBgCollapsed` @Value: 12.
---| `ui.StyleColor.MenuBarBg` @Value: 13.
---| `ui.StyleColor.ScrollbarBg` @Value: 14.
---| `ui.StyleColor.ScrollbarGrab` @Value: 15.
---| `ui.StyleColor.ScrollbarGrabHovered` @Value: 16.
---| `ui.StyleColor.ScrollbarGrabActive` @Value: 17.
---| `ui.StyleColor.CheckMark` @Value: 18.
---| `ui.StyleColor.SliderGrab` @Value: 19.
---| `ui.StyleColor.SliderGrabActive` @Value: 20.
---| `ui.StyleColor.Button` @Value: 21.
---| `ui.StyleColor.ButtonHovered` @Value: 22.
---| `ui.StyleColor.ButtonActive` @Value: 23.
---| `ui.StyleColor.Header` @Value: 24.
---| `ui.StyleColor.HeaderHovered` @Value: 25.
---| `ui.StyleColor.HeaderActive` @Value: 26.
---| `ui.StyleColor.Separator` @Value: 27.
---| `ui.StyleColor.SeparatorHovered` @Value: 28.
---| `ui.StyleColor.SeparatorActive` @Value: 29.
---| `ui.StyleColor.ResizeGrip` @Value: 30.
---| `ui.StyleColor.ResizeGripHovered` @Value: 31.
---| `ui.StyleColor.ResizeGripActive` @Value: 32.
---| `ui.StyleColor.Tab` @Value: 33.
---| `ui.StyleColor.TabHovered` @Value: 34.
---| `ui.StyleColor.TabActive` @Value: 35.
---| `ui.StyleColor.TabUnfocused` @Value: 36.
---| `ui.StyleColor.TabUnfocusedActive` @Value: 37.
---| `ui.StyleColor.PlotLines` @Value: 38.
---| `ui.StyleColor.PlotLinesHovered` @Value: 39.
---| `ui.StyleColor.PlotHistogram` @Value: 40.
---| `ui.StyleColor.PlotHistogramHovered` @Value: 41.
---| `ui.StyleColor.TextSelectedBg` @Value: 42.
---| `ui.StyleColor.DragDropTarget` @Value: 43.
---| `ui.StyleColor.NavHighlight` @Value: 44.
---| `ui.StyleColor.NavWindowingHighlight` @Value: 45.
---| `ui.StyleColor.NavWindowingDimBg` @Value: 46.
---| `ui.StyleColor.ModalWindowDimBg` @Value: 47.
---| `ui.StyleColor.TextHovered` @Value: 48.
---| `ui.StyleColor.TextActive` @Value: 49.
ui.StyleColor = {
  Text = 0, ---@type ui.StyleColor #Value: 0.
  TextDisabled = 1, ---@type ui.StyleColor #Value: 1.
  WindowBg = 2, ---@type ui.StyleColor #Value: 2.
  ChildBg = 3, ---@type ui.StyleColor #Value: 3.
  PopupBg = 4, ---@type ui.StyleColor #Value: 4.
  Border = 5, ---@type ui.StyleColor #Value: 5.
  BorderShadow = 6, ---@type ui.StyleColor #Value: 6.
  FrameBg = 7, ---@type ui.StyleColor #Value: 7.
  FrameBgHovered = 8, ---@type ui.StyleColor #Value: 8.
  FrameBgActive = 9, ---@type ui.StyleColor #Value: 9.
  TitleBg = 10, ---@type ui.StyleColor #Value: 10.
  TitleBgActive = 11, ---@type ui.StyleColor #Value: 11.
  TitleBgCollapsed = 12, ---@type ui.StyleColor #Value: 12.
  MenuBarBg = 13, ---@type ui.StyleColor #Value: 13.
  ScrollbarBg = 14, ---@type ui.StyleColor #Value: 14.
  ScrollbarGrab = 15, ---@type ui.StyleColor #Value: 15.
  ScrollbarGrabHovered = 16, ---@type ui.StyleColor #Value: 16.
  ScrollbarGrabActive = 17, ---@type ui.StyleColor #Value: 17.
  CheckMark = 18, ---@type ui.StyleColor #Value: 18.
  SliderGrab = 19, ---@type ui.StyleColor #Value: 19.
  SliderGrabActive = 20, ---@type ui.StyleColor #Value: 20.
  Button = 21, ---@type ui.StyleColor #Value: 21.
  ButtonHovered = 22, ---@type ui.StyleColor #Value: 22.
  ButtonActive = 23, ---@type ui.StyleColor #Value: 23.
  Header = 24, ---@type ui.StyleColor #Value: 24.
  HeaderHovered = 25, ---@type ui.StyleColor #Value: 25.
  HeaderActive = 26, ---@type ui.StyleColor #Value: 26.
  Separator = 27, ---@type ui.StyleColor #Value: 27.
  SeparatorHovered = 28, ---@type ui.StyleColor #Value: 28.
  SeparatorActive = 29, ---@type ui.StyleColor #Value: 29.
  ResizeGrip = 30, ---@type ui.StyleColor #Value: 30.
  ResizeGripHovered = 31, ---@type ui.StyleColor #Value: 31.
  ResizeGripActive = 32, ---@type ui.StyleColor #Value: 32.
  Tab = 33, ---@type ui.StyleColor #Value: 33.
  TabHovered = 34, ---@type ui.StyleColor #Value: 34.
  TabActive = 35, ---@type ui.StyleColor #Value: 35.
  TabUnfocused = 36, ---@type ui.StyleColor #Value: 36.
  TabUnfocusedActive = 37, ---@type ui.StyleColor #Value: 37.
  PlotLines = 38, ---@type ui.StyleColor #Value: 38.
  PlotLinesHovered = 39, ---@type ui.StyleColor #Value: 39.
  PlotHistogram = 40, ---@type ui.StyleColor #Value: 40.
  PlotHistogramHovered = 41, ---@type ui.StyleColor #Value: 41.
  TextSelectedBg = 42, ---@type ui.StyleColor #Value: 42.
  DragDropTarget = 43, ---@type ui.StyleColor #Value: 43.
  NavHighlight = 44, ---@type ui.StyleColor #Value: 44.
  NavWindowingHighlight = 45, ---@type ui.StyleColor #Value: 45.
  NavWindowingDimBg = 46, ---@type ui.StyleColor #Value: 46.
  ModalWindowDimBg = 47, ---@type ui.StyleColor #Value: 47.
  TextHovered = 48, ---@type ui.StyleColor #Value: 48.
  TextActive = 49, ---@type ui.StyleColor #Value: 49.
}

---@alias ui.ButtonFlags
---| `ui.ButtonFlags.None` @No special options.
---| `ui.ButtonFlags.Repeat` @Hold to repeat.
---| `ui.ButtonFlags.PressedOnClickRelease` @Return true on click + release on same item.
---| `ui.ButtonFlags.PressedOnClick` @Return true on click (default requires click+release).
---| `ui.ButtonFlags.PressedOnRelease` @Return true on release (default requires click+release).
---| `ui.ButtonFlags.PressedOnDoubleClick` @Return true on double-click (default requires click+release).
---| `ui.ButtonFlags.FlattenChildren` @Allow interactions even if a child window is overlapping.
---| `ui.ButtonFlags.AllowItemOverlap` @Require previous frame HoveredId to either match id or be null before being usable, use along with SetItemAllowOverlap().
---| `ui.ButtonFlags.DontClosePopups` @Disable automatically closing parent popup on press.
---| `ui.ButtonFlags.Disabled` @Disable interactions.
---| `ui.ButtonFlags.NoKeyModifiers` @Disable interaction if a key modifier is held.
---| `ui.ButtonFlags.PressedOnDragDropHold` @Press when held into while we are drag and dropping another item (used by e.g. tree nodes, collapsing headers).
---| `ui.ButtonFlags.NoNavFocus` @Don’t override navigation focus when activated.
---| `ui.ButtonFlags.NoHoveredOnNav` @Don’t report as hovered when navigated on.
---| `ui.ButtonFlags.Error` @For modern buttons.
---| `ui.ButtonFlags.Confirm` @For modern buttons.
---| `ui.ButtonFlags.Cancel` @For modern buttons.
---| `ui.ButtonFlags.VerticalLayout` @For modern buttons.
---| `ui.ButtonFlags.TextAsIcon` @For modern buttons.
---| `ui.ButtonFlags.Active` @Button is correctly active (checked).
---| `ui.ButtonFlags.Activable` @If not set, _Active would make background brighter.
ui.ButtonFlags = {
  None = 0x0, ---@type ui.ButtonFlags #No special options.
  Repeat = 0x1, ---@type ui.ButtonFlags #Hold to repeat.
  PressedOnClickRelease = 0x2, ---@type ui.ButtonFlags #Return true on click + release on same item.
  PressedOnClick = 0x4, ---@type ui.ButtonFlags #Return true on click (default requires click+release).
  PressedOnRelease = 0x8, ---@type ui.ButtonFlags #Return true on release (default requires click+release).
  PressedOnDoubleClick = 0x10, ---@type ui.ButtonFlags #Return true on double-click (default requires click+release).
  FlattenChildren = 0x20, ---@type ui.ButtonFlags #Allow interactions even if a child window is overlapping.
  AllowItemOverlap = 0x40, ---@type ui.ButtonFlags #Require previous frame HoveredId to either match id or be null before being usable, use along with SetItemAllowOverlap().
  DontClosePopups = 0x80, ---@type ui.ButtonFlags #Disable automatically closing parent popup on press.
  Disabled = 0x100, ---@type ui.ButtonFlags #Disable interactions.
  NoKeyModifiers = 0x400, ---@type ui.ButtonFlags #Disable interaction if a key modifier is held.
  PressedOnDragDropHold = 0x1000, ---@type ui.ButtonFlags #Press when held into while we are drag and dropping another item (used by e.g. tree nodes, collapsing headers).
  NoNavFocus = 0x2000, ---@type ui.ButtonFlags #Don’t override navigation focus when activated.
  NoHoveredOnNav = 0x4000, ---@type ui.ButtonFlags #Don’t report as hovered when navigated on.
  Error = 0x8000, ---@type ui.ButtonFlags #For modern buttons.
  Confirm = 0x10000, ---@type ui.ButtonFlags #For modern buttons.
  Cancel = 0x20000, ---@type ui.ButtonFlags #For modern buttons.
  VerticalLayout = 0x40000, ---@type ui.ButtonFlags #For modern buttons.
  TextAsIcon = 0x80000, ---@type ui.ButtonFlags #For modern buttons.
  Active = 0x100000, ---@type ui.ButtonFlags #Button is correctly active (checked).
  Activable = 0x200000, ---@type ui.ButtonFlags #If not set, _Active would make background brighter.
}

---@alias ui.WindowFlags
---| `ui.WindowFlags.None` @No special options.
---| `ui.WindowFlags.NoTitleBar` @Disable title-bar.
---| `ui.WindowFlags.NoResize` @Disable user resizing with the lower-right grip.
---| `ui.WindowFlags.NoMove` @Disable user moving the window.
---| `ui.WindowFlags.NoScrollbar` @Disable scrollbars (window can still scroll with mouse or programmatically).
---| `ui.WindowFlags.NoScrollWithMouse` @Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
---| `ui.WindowFlags.NoCollapse` @Disable user collapsing window by double-clicking on it.
---| `ui.WindowFlags.AlwaysAutoResize` @Resize every window to its content every frame.
---| `ui.WindowFlags.NoBackground` @Disable drawing background and outside border.
---| `ui.WindowFlags.NoSavedSettings` @Never load/save settings in .ini file.
---| `ui.WindowFlags.NoMouseInputs` @Disable catching mouse, hovering test with pass through.
---| `ui.WindowFlags.MenuBar` @Has a menu-bar.
---| `ui.WindowFlags.HorizontalScrollbar` @Allow horizontal scrollbar to appear (off by default).
---| `ui.WindowFlags.NoFocusOnAppearing` @Disable taking focus when transitioning from hidden to visible state.
---| `ui.WindowFlags.NoBringToFrontOnFocus` @Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus).
---| `ui.WindowFlags.AlwaysVerticalScrollbar` @Always show vertical scrollbar (even if ContentSize.y < Size.y).
---| `ui.WindowFlags.AlwaysHorizontalScrollbar` @Always show horizontal scrollbar (even if ContentSize.x < Size.x).
---| `ui.WindowFlags.AlwaysUseWindowPadding` @Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient).
---| `ui.WindowFlags.NoNavInputs` @No gamepad/keyboard navigation within the window.
---| `ui.WindowFlags.NoNavFocus` @No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB).
---| `ui.WindowFlags.UnsavedDocument` @Append “*” to title without affecting the ID, as a convenience to avoid using the “###” operator.
---| `ui.WindowFlags.NoNav` @Combination of flags: NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoNav, …)` to combine it with other flags safely).
---| `ui.WindowFlags.NoDecoration` @Combination of flags: NoTitleBar | NoResize | NoScrollbar | NoCollapse (use `bit.bor(ui.WindowFlags.NoDecoration, …)` to combine it with other flags safely).
---| `ui.WindowFlags.NoInputs` @Combination of flags: NoMouseInputs | NoNavInputs | NoNavFocus (use `bit.bor(ui.WindowFlags.NoInputs, …)` to combine it with other flags safely).
---| `ui.WindowFlags.BitmapCache` @Cache window contents.
---| `ui.WindowFlags.ThinScrollbar` @Thin scrollbar.
ui.WindowFlags = {
  None = 0x0, ---@type ui.WindowFlags #No special options.
  NoTitleBar = 0x1, ---@type ui.WindowFlags #Disable title-bar.
  NoResize = 0x2, ---@type ui.WindowFlags #Disable user resizing with the lower-right grip.
  NoMove = 0x4, ---@type ui.WindowFlags #Disable user moving the window.
  NoScrollbar = 0x8, ---@type ui.WindowFlags #Disable scrollbars (window can still scroll with mouse or programmatically).
  NoScrollWithMouse = 0x10, ---@type ui.WindowFlags #Disable user vertically scrolling with mouse wheel. On child window, mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
  NoCollapse = 0x20, ---@type ui.WindowFlags #Disable user collapsing window by double-clicking on it.
  AlwaysAutoResize = 0x40, ---@type ui.WindowFlags #Resize every window to its content every frame.
  NoBackground = 0x80, ---@type ui.WindowFlags #Disable drawing background and outside border.
  NoSavedSettings = 0x100, ---@type ui.WindowFlags #Never load/save settings in .ini file.
  NoMouseInputs = 0x200, ---@type ui.WindowFlags #Disable catching mouse, hovering test with pass through.
  MenuBar = 0x400, ---@type ui.WindowFlags #Has a menu-bar.
  HorizontalScrollbar = 0x800, ---@type ui.WindowFlags #Allow horizontal scrollbar to appear (off by default).
  NoFocusOnAppearing = 0x1000, ---@type ui.WindowFlags #Disable taking focus when transitioning from hidden to visible state.
  NoBringToFrontOnFocus = 0x2000, ---@type ui.WindowFlags #Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus).
  AlwaysVerticalScrollbar = 0x4000, ---@type ui.WindowFlags #Always show vertical scrollbar (even if ContentSize.y < Size.y).
  AlwaysHorizontalScrollbar = 0x8000, ---@type ui.WindowFlags #Always show horizontal scrollbar (even if ContentSize.x < Size.x).
  AlwaysUseWindowPadding = 0x10000, ---@type ui.WindowFlags #Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows, because more convenient).
  NoNavInputs = 0x40000, ---@type ui.WindowFlags #No gamepad/keyboard navigation within the window.
  NoNavFocus = 0x80000, ---@type ui.WindowFlags #No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB).
  UnsavedDocument = 0x100000, ---@type ui.WindowFlags #Append “*” to title without affecting the ID, as a convenience to avoid using the “###” operator.
  NoNav = 0xc0000, ---@type ui.WindowFlags #Combination of flags: NoNavInputs|NoNavFocus (use `bit.bor(ui.WindowFlags.NoNav, …)` to combine it with other flags safely).
  NoDecoration = 0x2b, ---@type ui.WindowFlags #Combination of flags: NoTitleBar|NoResize|NoScrollbar|NoCollapse (use `bit.bor(ui.WindowFlags.NoDecoration, …)` to combine it with other flags safely).
  NoInputs = 0xc0200, ---@type ui.WindowFlags #Combination of flags: NoMouseInputs|NoNavInputs|NoNavFocus (use `bit.bor(ui.WindowFlags.NoInputs, …)` to combine it with other flags safely).
  BitmapCache = 0x40000000, ---@type ui.WindowFlags #Cache window contents.
  ThinScrollbar = 0x80000000, ---@type ui.WindowFlags #Thin scrollbar.
}

---@alias ui.ComboFlags
---| `ui.ComboFlags.None` @No special options.
---| `ui.ComboFlags.PopupAlignLeft` @Align the popup toward the left by default.
---| `ui.ComboFlags.HeightSmall` @Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo().
---| `ui.ComboFlags.HeightRegular` @Max ~8 items visible (default).
---| `ui.ComboFlags.HeightLarge` @Max ~20 items visible.
---| `ui.ComboFlags.HeightLargest` @As many fitting items as possible.
---| `ui.ComboFlags.NoArrowButton` @Display on the preview box without the square arrow button.
---| `ui.ComboFlags.NoPreview` @Display only a square arrow button.
---| `ui.ComboFlags.GoUp` @Dropdown goes up.
---| `ui.ComboFlags.HeightChubby` @Height between regular and large.
ui.ComboFlags = {
  None = 0x0, ---@type ui.ComboFlags #No special options.
  PopupAlignLeft = 0x1, ---@type ui.ComboFlags #Align the popup toward the left by default.
  HeightSmall = 0x2, ---@type ui.ComboFlags #Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo().
  HeightRegular = 0x4, ---@type ui.ComboFlags #Max ~8 items visible (default).
  HeightLarge = 0x8, ---@type ui.ComboFlags #Max ~20 items visible.
  HeightLargest = 0x10, ---@type ui.ComboFlags #As many fitting items as possible.
  NoArrowButton = 0x20, ---@type ui.ComboFlags #Display on the preview box without the square arrow button.
  NoPreview = 0x40, ---@type ui.ComboFlags #Display only a square arrow button.
  GoUp = 0x80, ---@type ui.ComboFlags #Dropdown goes up.
  HeightChubby = 0x100, ---@type ui.ComboFlags #Height between regular and large.
}

---@alias ui.InputTextFlags
---| `ui.InputTextFlags.None` @No special options.
---| `ui.InputTextFlags.CharsDecimal` @Allow “0123456789.+-*/”.
---| `ui.InputTextFlags.CharsHexadecimal` @Allow “0123456789ABCDEFabcdef”.
---| `ui.InputTextFlags.CharsUppercase` @Turn a…z into A…Z.
---| `ui.InputTextFlags.CharsNoBlank` @Filter out spaces, tabs.
---| `ui.InputTextFlags.AutoSelectAll` @Select entire text when first taking mouse focus.
---| `ui.InputTextFlags.AllowTabInput` @Pressing TAB input a '\t' character into the text field.
---| `ui.InputTextFlags.CtrlEnterForNewLine` @In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
---| `ui.InputTextFlags.NoHorizontalScroll` @Disable following the cursor horizontally.
---| `ui.InputTextFlags.AlwaysInsertMode` @Insert mode.
---| `ui.InputTextFlags.ReadOnly` @Read-only mode.
---| `ui.InputTextFlags.Password` @Password mode, display all characters as “*”.
---| `ui.InputTextFlags.NoUndoRedo` @Disable undo/redo. Note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
---| `ui.InputTextFlags.CharsScientific` @Allow “0123456789.+-*/eE” (Scientific notation input).
---| `ui.InputTextFlags.Placeholder` @Show label as a placeholder.
---| `ui.InputTextFlags.ClearButton` @Add button erasing text.
---| `ui.InputTextFlags.RetainSelection` @Do not lose selection when Enter is pressed, do not select all with focusing in code.
ui.InputTextFlags = {
  None = 0x0, ---@type ui.InputTextFlags #No special options.
  CharsDecimal = 0x1, ---@type ui.InputTextFlags #Allow “0123456789.+-*/”.
  CharsHexadecimal = 0x2, ---@type ui.InputTextFlags #Allow “0123456789ABCDEFabcdef”.
  CharsUppercase = 0x4, ---@type ui.InputTextFlags #Turn a…z into A…Z.
  CharsNoBlank = 0x8, ---@type ui.InputTextFlags #Filter out spaces, tabs.
  AutoSelectAll = 0x10, ---@type ui.InputTextFlags #Select entire text when first taking mouse focus.
  AllowTabInput = 0x400, ---@type ui.InputTextFlags #Pressing TAB input a '\t' character into the text field.
  CtrlEnterForNewLine = 0x800, ---@type ui.InputTextFlags #In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
  NoHorizontalScroll = 0x1000, ---@type ui.InputTextFlags #Disable following the cursor horizontally.
  AlwaysInsertMode = 0x2000, ---@type ui.InputTextFlags #Insert mode.
  ReadOnly = 0x4000, ---@type ui.InputTextFlags #Read-only mode.
  Password = 0x8000, ---@type ui.InputTextFlags #Password mode, display all characters as “*”.
  NoUndoRedo = 0x10000, ---@type ui.InputTextFlags #Disable undo/redo. Note that input text owns the text data while active, if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
  CharsScientific = 0x20000, ---@type ui.InputTextFlags #Allow “0123456789.+-*/eE” (Scientific notation input).
  Placeholder = 0x400000, ---@type ui.InputTextFlags #Show label as a placeholder.
  ClearButton = 0x800000, ---@type ui.InputTextFlags #Add button erasing text.
  RetainSelection = 0x1000000, ---@type ui.InputTextFlags #Do not lose selection when Enter is pressed, do not select all with focusing in code.
}

---@alias ui.SelectableFlags
---| `ui.SelectableFlags.None` @No special options.
---| `ui.SelectableFlags.DontClosePopups` @Clicking this don’t close parent popup window.
---| `ui.SelectableFlags.SpanAllColumns` @Selectable frame can span all columns (text will still fit in current column).
---| `ui.SelectableFlags.AllowDoubleClick` @Generate press events on double clicks too.
---| `ui.SelectableFlags.Disabled` @Cannot be selected, display grayed out text.
---| `ui.SelectableFlags.SpanClipRect` @Span entire left to right current clip rect boundary (use carefully).
ui.SelectableFlags = {
  None = 0x0, ---@type ui.SelectableFlags #No special options.
  DontClosePopups = 0x1, ---@type ui.SelectableFlags #Clicking this don’t close parent popup window.
  SpanAllColumns = 0x2, ---@type ui.SelectableFlags #Selectable frame can span all columns (text will still fit in current column).
  AllowDoubleClick = 0x4, ---@type ui.SelectableFlags #Generate press events on double clicks too.
  Disabled = 0x8, ---@type ui.SelectableFlags #Cannot be selected, display grayed out text.
  SpanClipRect = 0x80, ---@type ui.SelectableFlags #Span entire left to right current clip rect boundary (use carefully).
}

---@alias ui.TabBarFlags
---| `ui.TabBarFlags.None` @No special options.
---| `ui.TabBarFlags.Reorderable` @Allow manually dragging tabs to re-order them + New tabs are appended at the end of list.
---| `ui.TabBarFlags.AutoSelectNewTabs` @Automatically select new tabs when they appear.
---| `ui.TabBarFlags.TabListPopupButton` @Disable buttons to open the tab list popup.
---| `ui.TabBarFlags.NoCloseWithMiddleMouseButton` @Disable behavior of closing tabs with middle mouse button.
---| `ui.TabBarFlags.NoTabListScrollingButtons` @Disable scrolling buttons (apply when fitting policy is FittingPolicyScroll).
---| `ui.TabBarFlags.NoTooltip` @Disable tooltips when hovering a tab.
---| `ui.TabBarFlags.FittingPolicyResizeDown` @Resize tabs when they don’t fit.
---| `ui.TabBarFlags.FittingPolicyScroll` @Add scroll buttons when tabs don’t fit.
---| `ui.TabBarFlags.IntegratedTabs` @Integrates tab bar into a window title (call it first when drawing a window).
---| `ui.TabBarFlags.SaveSelected` @Save selected tab based on tab ID (make sure tab ID is unique).
ui.TabBarFlags = {
  None = 0x0, ---@type ui.TabBarFlags #No special options.
  Reorderable = 0x1, ---@type ui.TabBarFlags #Allow manually dragging tabs to re-order them + New tabs are appended at the end of list.
  AutoSelectNewTabs = 0x2, ---@type ui.TabBarFlags #Automatically select new tabs when they appear.
  TabListPopupButton = 0x4, ---@type ui.TabBarFlags #Disable buttons to open the tab list popup.
  NoCloseWithMiddleMouseButton = 0x8, ---@type ui.TabBarFlags #Disable behavior of closing tabs with middle mouse button.
  NoTabListScrollingButtons = 0x10, ---@type ui.TabBarFlags #Disable scrolling buttons (apply when fitting policy is FittingPolicyScroll).
  NoTooltip = 0x20, ---@type ui.TabBarFlags #Disable tooltips when hovering a tab.
  FittingPolicyResizeDown = 0x40, ---@type ui.TabBarFlags #Resize tabs when they don’t fit.
  FittingPolicyScroll = 0x80, ---@type ui.TabBarFlags #Add scroll buttons when tabs don’t fit.
  IntegratedTabs = 0x8000, ---@type ui.TabBarFlags #Integrates tab bar into a window title (call it first when drawing a window).
  SaveSelected = 0x10000, ---@type ui.TabBarFlags #Save selected tab based on tab ID (make sure tab ID is unique).
}

---@alias ui.TabItemFlags
---| `ui.TabItemFlags.None` @Value: 0.
---| `ui.TabItemFlags.UnsavedDocument` @Append '*' to title without affecting the ID, as a convenience to avoid using the ### operator. Also: tab is selected on closure and closure is deferred by one frame to allow code to undo it without flicker.
---| `ui.TabItemFlags.SetSelected` @Trigger flag to programmatically make the tab selected when calling BeginTabItem().
---| `ui.TabItemFlags.NoCloseWithMiddleMouseButton` @Disable behavior of closing tabs (that are submitted with p_open !
ui.TabItemFlags = {
  None = 0, ---@type ui.TabItemFlags #Value: 0.
  UnsavedDocument = 1, ---@type ui.TabItemFlags #Append '*' to title without affecting the ID, as a convenience to avoid using the ### operator. Also: tab is selected on closure and closure is deferred by one frame to allow code to undo it without flicker.
  SetSelected = 2, ---@type ui.TabItemFlags #Trigger flag to programmatically make the tab selected when calling BeginTabItem().
  NoCloseWithMiddleMouseButton = 4, ---@type ui.TabItemFlags #Disable behavior of closing tabs (that are submitted with p_open !
}

---@alias ui.ColumnsFlags
---| `ui.ColumnsFlags.None` @No special options.
---| `ui.ColumnsFlags.NoBorder` @Disable column dividers.
---| `ui.ColumnsFlags.NoResize` @Disable resizing columns when clicking on the dividers.
---| `ui.ColumnsFlags.NoPreserveWidths` @Disable column width preservation when adjusting columns.
---| `ui.ColumnsFlags.NoForceWithinWindow` @Disable forcing columns to fit within window.
ui.ColumnsFlags = {
  None = 0x0, ---@type ui.ColumnsFlags #No special options.
  NoBorder = 0x1, ---@type ui.ColumnsFlags #Disable column dividers.
  NoResize = 0x2, ---@type ui.ColumnsFlags #Disable resizing columns when clicking on the dividers.
  NoPreserveWidths = 0x4, ---@type ui.ColumnsFlags #Disable column width preservation when adjusting columns.
  NoForceWithinWindow = 0x8, ---@type ui.ColumnsFlags #Disable forcing columns to fit within window.
}

---@alias ui.TreeNodeFlags
---| `ui.TreeNodeFlags.None` @No special options.
---| `ui.TreeNodeFlags.Selected` @Draw as selected.
---| `ui.TreeNodeFlags.Framed` @Full colored frame (e.g. for CollapsingHeader).
---| `ui.TreeNodeFlags.AllowItemOverlap` @Hit testing to allow subsequent widgets to overlap this one.
---| `ui.TreeNodeFlags.NoTreePushOnOpen` @Don’t do a TreePush() when open (e.g. for CollapsingHeader).
---| `ui.TreeNodeFlags.NoAutoOpenOnLog` @Don’t automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes).
---| `ui.TreeNodeFlags.DefaultOpen` @Default node to be open.
---| `ui.TreeNodeFlags.OpenOnDoubleClick` @Need double-click to open node.
---| `ui.TreeNodeFlags.OpenOnArrow` @Only open when clicking on the arrow part. If OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
---| `ui.TreeNodeFlags.Leaf` @No collapsing, no arrow (use as a convenience for leaf nodes).
---| `ui.TreeNodeFlags.Bullet` @Display a bullet instead of arrow.
---| `ui.TreeNodeFlags.FramePadding` @Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
---| `ui.TreeNodeFlags.CollapsingHeader` @Combination of flags: Framed | NoTreePushOnOpen | NoAutoOpenOnLog (use `bit.bor(ui.TreeNodeFlags.CollapsingHeader, …)` to combine it with other flags safely).
---| `ui.TreeNodeFlags.NoArrow` @Value: 0x4000.
---| `ui.TreeNodeFlags.SpanClipRect` @Span entire left to right current clip rect boundary (use carefully).
---| `ui.TreeNodeFlags.Animated` @Value: 0xf0000000.
ui.TreeNodeFlags = {
  None = 0x0, ---@type ui.TreeNodeFlags #No special options.
  Selected = 0x1, ---@type ui.TreeNodeFlags #Draw as selected.
  Framed = 0x2, ---@type ui.TreeNodeFlags #Full colored frame (e.g. for CollapsingHeader).
  AllowItemOverlap = 0x4, ---@type ui.TreeNodeFlags #Hit testing to allow subsequent widgets to overlap this one.
  NoTreePushOnOpen = 0x8, ---@type ui.TreeNodeFlags #Don’t do a TreePush() when open (e.g. for CollapsingHeader).
  NoAutoOpenOnLog = 0x10, ---@type ui.TreeNodeFlags #Don’t automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes).
  DefaultOpen = 0x20, ---@type ui.TreeNodeFlags #Default node to be open.
  OpenOnDoubleClick = 0x40, ---@type ui.TreeNodeFlags #Need double-click to open node.
  OpenOnArrow = 0x80, ---@type ui.TreeNodeFlags #Only open when clicking on the arrow part. If OpenOnDoubleClick is also set, single-click arrow or double-click all box to open.
  Leaf = 0x100, ---@type ui.TreeNodeFlags #No collapsing, no arrow (use as a convenience for leaf nodes).
  Bullet = 0x200, ---@type ui.TreeNodeFlags #Display a bullet instead of arrow.
  FramePadding = 0x400, ---@type ui.TreeNodeFlags #Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
  CollapsingHeader = 0x1a, ---@type ui.TreeNodeFlags #Combination of flags: Framed|NoTreePushOnOpen|NoAutoOpenOnLog (use `bit.bor(ui.TreeNodeFlags.CollapsingHeader, …)` to combine it with other flags safely).
  NoArrow = 0x4000, ---@type ui.TreeNodeFlags #Value: 0x4000.
  SpanClipRect = 0x8000, ---@type ui.TreeNodeFlags #Span entire left to right current clip rect boundary (use carefully).
  Animated = 0xf0000000, ---@type ui.TreeNodeFlags #Value: 0xf0000000.
}

---@alias ui.ColorPickerFlags
---| `ui.ColorPickerFlags.None` @Value: 0.
---| `ui.ColorPickerFlags.NoAlpha` @Ignore Alpha component (will only read 3 components from the input pointer).
---| `ui.ColorPickerFlags.NoPicker` @Disable picker when clicking on colored square.
---| `ui.ColorPickerFlags.NoOptions` @Disable toggling options menu when right-clicking on inputs/small preview.
---| `ui.ColorPickerFlags.NoSmallPreview` @Disable colored square preview next to the inputs. (e.g. to show only the inputs).
---| `ui.ColorPickerFlags.NoInputs` @Disable inputs sliders/text widgets (e.g. to show only the small preview colored square).
---| `ui.ColorPickerFlags.NoTooltip` @Disable tooltip when hovering the preview.
---| `ui.ColorPickerFlags.NoLabel` @Disable display of inline text label (the label is still forwarded to the tooltip and picker).
---| `ui.ColorPickerFlags.NoSidePreview` @Disable bigger color preview on right side of the picker, use small colored square preview instead.
---| `ui.ColorPickerFlags.NoDragDrop` @Disable drag and drop target. ColorButton: disable drag and drop source.
---| `ui.ColorPickerFlags.AlphaBar` @Show vertical alpha bar/gradient in picker.
---| `ui.ColorPickerFlags.AlphaPreview` @Display preview as a transparent color over a checkerboard, instead of opaque.
---| `ui.ColorPickerFlags.AlphaPreviewHalf` @Display half opaque / half checkerboard, instead of opaque.
---| `ui.ColorPickerFlags.DisplayRGB` @Override _display_ type among RGB/HSV/Hex. select any combination using one or more of RGB/HSV/Hex.
---| `ui.ColorPickerFlags.DisplayHSV` @Value: 2097152.
---| `ui.ColorPickerFlags.DisplayHex` @Value: 4194304.
---| `ui.ColorPickerFlags.UInt8` @Display values formatted as 0..255.
---| `ui.ColorPickerFlags.Float` @Display values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
---| `ui.ColorPickerFlags.PickerHueBar` @Bar for Hue, rectangle for Sat/Value.
---| `ui.ColorPickerFlags.PickerHueWheel` @Wheel for Hue, triangle for Sat/Value.
ui.ColorPickerFlags = {
  None = 0, ---@type ui.ColorPickerFlags #Value: 0.
  NoAlpha = 2, ---@type ui.ColorPickerFlags #Ignore Alpha component (will only read 3 components from the input pointer).
  NoPicker = 4, ---@type ui.ColorPickerFlags #Disable picker when clicking on colored square.
  NoOptions = 8, ---@type ui.ColorPickerFlags #Disable toggling options menu when right-clicking on inputs/small preview.
  NoSmallPreview = 16, ---@type ui.ColorPickerFlags #Disable colored square preview next to the inputs. (e.g. to show only the inputs).
  NoInputs = 32, ---@type ui.ColorPickerFlags #Disable inputs sliders/text widgets (e.g. to show only the small preview colored square).
  NoTooltip = 64, ---@type ui.ColorPickerFlags #Disable tooltip when hovering the preview.
  NoLabel = 128, ---@type ui.ColorPickerFlags #Disable display of inline text label (the label is still forwarded to the tooltip and picker).
  NoSidePreview = 256, ---@type ui.ColorPickerFlags #Disable bigger color preview on right side of the picker, use small colored square preview instead.
  NoDragDrop = 512, ---@type ui.ColorPickerFlags #Disable drag and drop target. ColorButton: disable drag and drop source.
  AlphaBar = 65536, ---@type ui.ColorPickerFlags #Show vertical alpha bar/gradient in picker.
  AlphaPreview = 131072, ---@type ui.ColorPickerFlags #Display preview as a transparent color over a checkerboard, instead of opaque.
  AlphaPreviewHalf = 262144, ---@type ui.ColorPickerFlags #Display half opaque / half checkerboard, instead of opaque.
  DisplayRGB = 1048576, ---@type ui.ColorPickerFlags #Override _display_ type among RGB/HSV/Hex. select any combination using one or more of RGB/HSV/Hex.
  DisplayHSV = 2097152, ---@type ui.ColorPickerFlags #Value: 2097152.
  DisplayHex = 4194304, ---@type ui.ColorPickerFlags #Value: 4194304.
  UInt8 = 8388608, ---@type ui.ColorPickerFlags #Display values formatted as 0..255.
  Float = 16777216, ---@type ui.ColorPickerFlags #Display values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
  PickerHueBar = 33554432, ---@type ui.ColorPickerFlags #Bar for Hue, rectangle for Sat/Value.
  PickerHueWheel = 67108864, ---@type ui.ColorPickerFlags #Wheel for Hue, triangle for Sat/Value.
}

---@alias ui.OnlineExtraFlags
---| `ui.OnlineExtraFlags.None` @Value: 0.
---| `ui.OnlineExtraFlags.Admin` @Feature will be available only to people signed up as admins with access to admin menu in that new chat app.
---| `ui.OnlineExtraFlags.Tool` @Instead of creating a modal popup blocking rest of UI, a tool would create a small window staying on screen continuously and be able to use rest of UI API there.
ui.OnlineExtraFlags = {
  None = 0, ---@type ui.OnlineExtraFlags #Value: 0.
  Admin = 1, ---@type ui.OnlineExtraFlags #Feature will be available only to people signed up as admins with access to admin menu in that new chat app.
  Tool = 2, ---@type ui.OnlineExtraFlags #Instead of creating a modal popup blocking rest of UI, a tool would create a small window staying on screen continuously and be able to use rest of UI API there.
}

---@alias ui.FileIcon.Style
---| `ui.FileIcon.Style.Small` @Value: 'S'.
---| `ui.FileIcon.Style.Large` @Value: 'L'.
ui.FileIcon.Style = {
  Small = 'S', ---@type ui.FileIcon.Style #Value: 'S'.
  Large = 'L', ---@type ui.FileIcon.Style #Value: 'L'.
}

---@alias ui.DWriteFont.Weight
---| `ui.DWriteFont.Weight.Thin` @- Thin (100).
---| `ui.DWriteFont.Weight.UltraLight` @- Ultra-light (200).
---| `ui.DWriteFont.Weight.Light` @- Light (300).
---| `ui.DWriteFont.Weight.SemiLight` @- Semi-light (350).
---| `ui.DWriteFont.Weight.Regular` @- Regular (400).
---| `ui.DWriteFont.Weight.Medium` @- Medium (500).
---| `ui.DWriteFont.Weight.SemiBold` @- Semi-bold (600).
---| `ui.DWriteFont.Weight.Bold` @- Bold (700).
---| `ui.DWriteFont.Weight.UltraBold` @- Ultra-bold (800).
---| `ui.DWriteFont.Weight.Black` @- Black (900).
---| `ui.DWriteFont.Weight.UltraBlack` @- Ultra-black (950).
ui.DWriteFont.Weight = {
  Thin = 'Thin', ---@type ui.DWriteFont.Weight #- Thin (100).
  UltraLight = 'UltraLight', ---@type ui.DWriteFont.Weight #- Ultra-light (200).
  Light = 'Light', ---@type ui.DWriteFont.Weight #- Light (300).
  SemiLight = 'SemiLight', ---@type ui.DWriteFont.Weight #- Semi-light (350).
  Regular = 'Regular', ---@type ui.DWriteFont.Weight #- Regular (400).
  Medium = 'Medium', ---@type ui.DWriteFont.Weight #- Medium (500).
  SemiBold = 'SemiBold', ---@type ui.DWriteFont.Weight #- Semi-bold (600).
  Bold = 'Bold', ---@type ui.DWriteFont.Weight #- Bold (700).
  UltraBold = 'UltraBold', ---@type ui.DWriteFont.Weight #- Ultra-bold (800).
  Black = 'Black', ---@type ui.DWriteFont.Weight #- Black (900).
  UltraBlack = 'UltraBlack', ---@type ui.DWriteFont.Weight #- Ultra-black (950).
}

---@alias ui.DWriteFont.Style
---| `ui.DWriteFont.Style.Normal` @- Charachers are upright in most fonts.
---| `ui.DWriteFont.Style.Italic` @- In italic style, characters are truly slanted and appear as they were designed.
---| `ui.DWriteFont.Style.Oblique` @- With oblique style characters are artificially slanted.
ui.DWriteFont.Style = {
  Normal = 'Normal', ---@type ui.DWriteFont.Style #- Charachers are upright in most fonts.
  Italic = 'Italic', ---@type ui.DWriteFont.Style #- In italic style, characters are truly slanted and appear as they were designed.
  Oblique = 'Oblique', ---@type ui.DWriteFont.Style #- With oblique style characters are artificially slanted.
}

---@alias ui.DWriteFont.Stretch
---| `ui.DWriteFont.Stretch.UltraCondensed` @Value: 'UltraCondensed'.
---| `ui.DWriteFont.Stretch.ExtraCondensed` @Value: 'ExtraCondensed'.
---| `ui.DWriteFont.Stretch.Condensed` @Value: 'Condensed'.
---| `ui.DWriteFont.Stretch.SemiCondensed` @Value: 'SemiCondensed'.
---| `ui.DWriteFont.Stretch.Medium` @Value: 'Medium'.
---| `ui.DWriteFont.Stretch.SemiExpanded` @Value: 'SemiExpanded'.
---| `ui.DWriteFont.Stretch.Expanded` @Value: 'Expanded'.
---| `ui.DWriteFont.Stretch.ExtraExpanded` @Value: 'ExtraExpanded'.
---| `ui.DWriteFont.Stretch.UltraExpanded` @Value: 'UltraExpanded'.
ui.DWriteFont.Stretch = {
  UltraCondensed = 'UltraCondensed', ---@type ui.DWriteFont.Stretch #Value: 'UltraCondensed'.
  ExtraCondensed = 'ExtraCondensed', ---@type ui.DWriteFont.Stretch #Value: 'ExtraCondensed'.
  Condensed = 'Condensed', ---@type ui.DWriteFont.Stretch #Value: 'Condensed'.
  SemiCondensed = 'SemiCondensed', ---@type ui.DWriteFont.Stretch #Value: 'SemiCondensed'.
  Medium = 'Medium', ---@type ui.DWriteFont.Stretch #Value: 'Medium'.
  SemiExpanded = 'SemiExpanded', ---@type ui.DWriteFont.Stretch #Value: 'SemiExpanded'.
  Expanded = 'Expanded', ---@type ui.DWriteFont.Stretch #Value: 'Expanded'.
  ExtraExpanded = 'ExtraExpanded', ---@type ui.DWriteFont.Stretch #Value: 'ExtraExpanded'.
  UltraExpanded = 'UltraExpanded', ---@type ui.DWriteFont.Stretch #Value: 'UltraExpanded'.
}

--[[ common/common.lua ]]

---Path to a folder with currently running script.
---@type string
__dirname = nil

---If set to `true`, app is being viewed in Lua Debug app. Could be a good condition for calling `ac.debug()`, if you want for script to run as fast as possible.
---@type boolean
__monitored = false

---A filename, either absolute or relative. If relative, will be resolved against AC root folder. Use `os.setCurrentFolder()` to change current folder.
---@alias path string

---Could be either a string, a number or a boolean value (will be converted into string).
---String can store any binary data including zero bytes. Could also be an FFI struct and it will
---be processed as its binary form.
---@alias binary string|number|boolean

---Could be either a string, a number, a boolean value or a table (without circular references or any non-serializable
---items). Will be serialized here and deserialized in a different script. String can store any binary data including zero bytes.
---@alias serializable string|number|boolean|table|nil

---Main CSP namespace.
ac = {}

---FFI-accelerated list, acts like a regular list (consequent items, size and capacity, automatically growing, etc.)
---Doesn’t store nil values to act more like a Lua table.
---
---Few notes:
---• Use `:get()` and `:set()` to access elements instead of square brakets;
---• Indices are 1-based;
---• For fastest access to individual elements use `.raw` field: it’s a raw pointer, so use 0-based indices there and
---make sure not to access things outside of list size.
---
---For slightly better performance it might be benefitial to preallocate memory with `list:reserve(expectedSizeOrABitMore)`.
---@class ac.GenericList
---@field raw any @Raw pointer for fastest unchecked access with 0-based indices. Use very carefully!
local _ac_genericList = {}

---Return an element at given index.
---@param index integer @1-based index.
---@return any
function _ac_genericList:get(index) end

---Sets an element at given index.
---@param index integer @1-based index.
---@param value any 
function _ac_genericList:set(index, value) end

---Number of items in the list.
---@return integer
function _ac_genericList:size() end

---Size of list in bytes (not capacity, for that use `list:capacityBytes()`).
---@return integer
function _ac_genericList:sizeBytes() end

---Checks if list is empty.
---@return boolean
function _ac_genericList:isEmpty() end

---Capacity of the list.
---@return integer
function _ac_genericList:capacity() end

---Size of list in bytes (capacity).
---@return integer
function _ac_genericList:capacityBytes() end

---Makes sure list can fit `newSize` of elements without reallocating memory.
---@param newSize integer
---@return integer
function _ac_genericList:reserve(newSize) end

---If capacity is greater than current size, reallocates a smaller bit of memory and moves data there.
function _ac_genericList:shrinkToFit() end

---Removes all elements.
function _ac_genericList:clear() end

---Creates a new list with the same contents as the existing one.
---@return ac.GenericList
function _ac_genericList:clone() end
---Custom FFI namespace. Be very careful around here.
---@class ffilibex
---@field C nil @Avoid using functions directly.
ffi = {}

---@param def     string
---@param params? any
function ffi.cdef(def, params, ...) end

---@param ct  ffi.ct*
---@param obj any
---@return boolean
---@nodiscard
function ffi.istype(ct, obj) end

---@param ptr  any
---@param len? integer
---@return string
function ffi.string(ptr, len) end

---@param ct      ffi.ct*
---@param params? any
---@return ffi.ctype*
---@nodiscard
function ffi.typeof(ct, params, ...) end

---@param ct   ffi.ct*
---@param init any
---@return ffi.cdata*
---@nodiscard
function ffi.cast(ct, init) end

---@param ct        ffi.ct*
---@param metatable table
---@return ffi.ctype*
function ffi.metatype(ct, metatable) end

---@param cdata     ffi.cdata*
---@param finalizer? function
---@return ffi.cdata*
function ffi.gc(cdata, finalizer) end

---@param destination any
---@param data any|string
---@param size integer?
function ffi.copy(destination, data, size) end

---Namespace only available for background workers. Use `ac.startBackgroundWorker()` to start a background worker.
worker = {}

---Input data passed to a worker during launch.
---@type nil|boolean|number|string|table
worker.input = nil

---Input data passed to a worker during launch.
---@type nil|boolean|number|string|table
worker.input = nil

---Available only in background worker scripts. Sleep function pauses execution for a certain time. 
---Before unpaused, any callbacks (such as `setTimeout()`, `setInterval()` and
---other custom enqueued callbacks) will be called. This is the only way for those callbacks to fire in a background worker. Note:
---if parent thread is closed, `worker.sleep()` won’t return back and instead script will be unloaded, this way worker can be reloaded
---as well.
---
---If your worker does a lot of async operations, consider using `worker.wait()` instead, setting resulting value with `worker.result`.
---Or maybe not even use anything at all: for basic (non-repeating) callbacks, timers and intervals script will continue running until
---all the postponed actions are complete (updating once every 100 ms).
---@param time number @Time in seconds to pause worker by.
function worker.sleep(time) end

---Wait for `worker.result` value to be set. Stops the worker once `worker.result` value has been provided (or any `error()` has been raised).
---Works the best if your worker uses a lot of async operations. 
---@param time number? @Time in seconds for timeout. Default value: 60. Feel free to pass something like `math.huge` if you don’t need timeout for some reason.
function worker.wait(time) end

---Resulting value used when using `worker.wait()`.
---@type nil|boolean|number|string|table
worker.result = nil

--[[ common/class.lua ]]

---@alias ClassDefinition {__name: string}
---@alias ClassMixin {included: fun(classDefinition: ClassDefinition)}

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly.
ClassBase = {}

---Checks if object is an instance of a class created by `class()` function.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassBase` or any class inheriting from it.
function ClassBase.isInstanceOf(obj) end

---Checks if ClassBase is a subsclass of a class created by `class()` function. It wouldn’t be, function is here just for
---keeping things even.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @Always false.
function ClassBase:isSubclassOf(classDefinition) end

---Creates a new class. Pretty much the same as calling `class()` (all classes are inheriting from `ClassBase` anyway).
---@return ClassDefinition @New class definition
function ClassBase:subclass(...) end

---Adds a mixin to all subsequently created classes. Use it early in case you want to add a method or some data to all of your objects.
---If `mixin` has a property `included`, it would be called each time new class is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassBase:include(mixin) end

---Define this function and it would be called each time a new class without a parent (or `ClassBase` for parent) is created.
---@param classDefinition ClassDefinition
function ClassBase:subclassed(classDefinition) end

---A base class for objects with pooling. Note: all classes created with `class.Pool` flag are inheriting from this one even if they’re not using
---`ClassPool` as a parent class explicitly.
ClassPool = {}

---Checks if object is an instance of a class with pooling active.
---@param obj any|nil @Any table, vector, nil, anything.
---@return boolean @True if type of `obj` is `ClassPool` or any class inheriting from it.
function ClassPool.isInstanceOf(obj) end

---Checks if ClassPool is a subsclass of a class created by `class()` function. It wouldn’t be unless you’re passing `ClassBase`, function is here just for
---keeping things even.
---@param classDefinition ClassBase @Class created by `class()` function.
---@return boolean @True if you’ve passed ClassBase here.
function ClassPool:isSubclassOf(classDefinition) end

---Creates a new class with pooling. Pretty much the same as calling `class(class.Pool, ...)` (all classes with `class.Pool` are 
---inheriting from `ClassPool` anyway).
---@return ClassDefinition @New class definition
function ClassPool:subclass(...) end

---Adds a mixin to subsequently created classes with pooling. Use it early in case you want to add a method or some data to all of your objects that use pooling.
---If `mixin` has a property `included`, it would be called each time new class with pooling is created with a reference to the newly created class.
---@param mixin ClassMixin
function ClassPool:include(mixin) end

---Define this function and it would be called each time a new pooling class without a parent (or `ClassPool` for parent) is created.
---@param classDefinition ClassDefinition
function ClassPool:subclassed(classDefinition) end

---A base class. Note: all classes are inheriting from this one even if they’re not using
---`ClassBase` as a parent class explicitly. You might still want to put it in EmmyDoc comment to get hints for functions like `YourClass.isInstanceOf()`.
---@class ClassBase
local _classBase = {}

---Checks if object is an instance of this class. Can be used either as `obj:isInstanceOf(YourClass)` or, as a safer alternative,
---`YourClass.isInstanceOf(obj)` — this one would work even if `obj` is nil, a number, a vector, anything like that. And in all of those
---cases, of course, it would return `false`.
---@param classDefinition ClassDefinition @Used with `obj:isInstanceOf(YourClass)` variant.
---@return boolean @True if argument is an instance of this class.
---@overload fun(): boolean
function _classBase:isInstanceOf(classDefinition) end

---Class method. Checks if class itself is a child class of a different class (or a child of a child, etc). 
---Can be used as `YourClass:isInstanceOf(YourOtherClass)`.
---@param classDefinition ClassDefinition @Class created by `class()` function.
---@return boolean @True if this class is a child of another class (or a child of a child, etc).
function _classBase:isSubclassOf(classDefinition) end

---Class method. Includes mixin, adding new methods to a preexising class. If mixin has a property `included`, it will be called
---with an argument referencing a class mixin is being added to. Can be used as `YourClass:include({ newMethod = function(self, arg) end })`.
---@param mixin ClassMixin @Any mixin.
function _classBase:include(mixin) end

---Class method. Creates a new child class.
---@return ClassDefinition @New class definition
function _classBase:subclass(...) end

---Class method. Called when a new child class is created using this class as a parent one. Redefine this function for
---your class if you need some advanced processing, like adding new methods to a child class.
---@param classDefinition ClassDefinition @New class definition
function _classBase:subclassed(classDefinition) end

---A base class for objects with pooling. Doesn’t add anything, but you can add it as a parent class
---so that `recycled()` would be documented.
---@class ClassPool : ClassBase
local _classPool = {}

---Called when object is about to get recycled.
---@return boolean @Return false if this object should not be recycled and instead destroyed as usual.
function _classPool:recycled() end

---Create a new class. Example:
---
---```
---local MyClass = class('MyClass')        -- class declaration
---
---function MyClass:initialize(arg1, arg2) -- constructor
---  self.myField = arg1 + arg2            -- field
---end
---
---function MyClass:doMyThing()            -- method
---  print(self.myField)
---end
---
---local instance = MyClass(1, 2)          -- creating instance of a class
---instance:doMyThing()                    -- calling a method
---```
---
---Whole thing is very similar to [middleclass](https://github.com/kikito/middleclass), but it’s a different
---implementation that should be somewhat faster. Main differences:
---
---1. Class name is stored in `YourClass.__name` instead of `YourClass.name`.
---
---2. There is no `.static` subtable, all static fields and methods are instead stored in main class
---   table and thus are available as instance fields and methods as well (that’s why `YourClass.name` was
---   renamed to `YourClass.__name`, to avoid possible confusion with a common field name). It’s a bit
---   messier, especially with class methods such as `:subclass()`, but it has some advantages as well:
---   objects creation is faster, and it’s more EmmyLua-friendly (both of which is what it’s all about).
---
---3. Overloaded `__tostring`, `__len` and `__call` are inherited, but not other operators.
---
---4. Method `YourClass.allocate()` works differently here and is used to create a simple table which will be
---   passed to `setmetatable()`. This can help with performance if objects are created often.
---
---Everything else should work the same, including inheritance and mixins. As for performance, some simple
---tests show up to 30% faster objects creation and 40% less memory used for objects with two fields when
---using `YourClass.allocate()` method instead of `YourClass:initialize()` (that alone gives about 15% increase in speed
---when creating an object with two fields):
---
---```
---function YourClass.allocate(arg1, arg2)  -- notice . instead of :
---  return { myField = arg1 + arg2 }     -- also notice, methods are not available at this stage
---end
---```
---
---Other differences (new features rather than something breaking compatibility) and important notes:
---
---1. Function `class()` takes string for class name, another class to act like a parent,
---   allocate and initialize functions and flags. Everything is optional and can go in any order (with one caveat:
---   allocate function should go before initialize function unless you’re using `class.Pool`). Generally there is no
---   benefit in passing allocate and initialize functions here though.
---
---2. With flag `class.NoInitialize` constructor would not look for `YourClass:initialize()` method to call at all,
---   instead using only `YourClass.allocate()`. Might speed things up a bit further.
---
---3. If you’re creating new instances really often, there is a `class.Pool` flag. It would disable the use of
---   `YourClass.allocate()`, but instead allow to reuse unused objects by using `class.recycle(object)`. Recycled objects
---   would end up in a pool of objects to be reused next time an instance would need to be created. Of course, it
---   introduces a whole new type of errors (imagine storing a reference to a recycled item somewhere not knowing it was
---   recycled and now represents something else entirely), so please be careful.
---
---   Note 1: Method `class.recycle()` can be used with nils or non-recycle, no need to have extra checks before calling it.
--- 
---   Note 2: Instances of child classes won’t end up in parent class pool. For such arrangements, consider adding pooling
---           flag to all of child classes where appropriate.
---
---4. Before recycling, method `YourClass:recycled()` will be called. Good time to recycle any inner elements. Also,
---   return `false` from it and object would not be recycled at all.
---
---5. To check type, `YourClass.isInstanceOf(item)` can also be used. Notice that it’s a static method, no “:” here.
---
---All classes are considered children classes of `ClassBase`, that one is mostly for EmmyLua to pick up methods like 
---`YourClass.isInstanceOf(object)`. If you’re creating your own class and want to use such methods, just add `: ClassBase`
---to its EmmyLua annotation. And objects with pooling are children of `ClassPool` which is a child of `ClassBase`. Note: 
---to speed things up, those classes aren’t fully real, but you can access them and their methods and even call things like
---`ClassBase:include()`. Please read documentation for those functions before using them though, just to check.
---@param name string @Class name.
---@param parentClass ClassBase @Parent class.
---@param flags nil|integer|`class.NoInitialize`|`class.Pool`|`class.Minimal` @Flags.
---@overload fun(name: string, flags: nil|integer|`class.NoInitialize`|`class.Pool`|`class.Minimal`)  @Regular parent-less class with some flags
---@overload fun(name: string, allocateFn: function|`function() return {} end, class.NoInitialize`)    @Inline allocate function for slightly faster creation
---@overload fun(name: string, initializeFn: `function (self) end, class.Pool`)               @With pooling for best memory reuse
---@overload fun(allocateFn: `function() return {} end, class.NoInitialize + class.Minimal`)  @Most minimal version
---@return ClassDefinition @New class definition
function class(name, parentClass, flags) end

class = {}

---Skip initialization function completely. Might slightly speed up object creation.
class.NoInitialize = 1

---Reuse recycled objects instead of creating new ones. Disables `.allocate()` and switches to `:initialize()`,
---but performance gain from not having to allocate new tables is worth it. Don’t forget to recycle unused elements
---with `class.recycle(item)`.
class.Pool = 2

---Minimal version of a class, skips creation of all static methods and default to-string operators.
---
---To use with either pooling or no-initialize setup, pass two flags separated by a comma, or just sum them together
---(would work only if values are powers of two and you’re not summing together the same flag twice). Or, use
---`bit.bor(flag1, flag2)`, courtesy of LuaJIT and its BitOp extension.
class.Minimal = 4

---Recycle an item to its pool, to speed up creation and reduce work for GC. Requires class to be created with
---`class.Pool` flag.
---
---This method has protection from double recycling, recycling nils or non-recycleable items, so don’t worry about it.
---@param item ClassPool|nil
function class.recycle(item) end

---A trick to get `class()` to work with EmmyLua annotations nicely. Call `class.emmy(YourClass, YourClass.initialize)`
---or `class.emmy(YourClass, YourClass.allocate)` (whatever you’re using) and it would give you a constructor function.
---Then, use it for local reference or as a return value from module. For best results add annotations to function you’re
---passing here, such as return value or argument types.
---
---In reality is simply returns the class back and ignores second argument, but because of this definition EmmyLua thinks
---it got the constructor.
---@generic T1
---@generic T2
---@param classFn T1
---@param constructorFn T2
---@return T1|T2
function class.emmy(classFn, constructorFn) return constructorFn end

---@return string?
function ac.getPatchVersion() end

---Increments with every CSP build.
---@return integer
function ac.getPatchVersionCode() end

---Load and parse INIpp configuration file (supports includes and such), return it as JSON. Deprecated, use `ac.INIConfig.load()` instead.
---@deprecated
---@param iniFilename string
---@param includeDirs string|nil @Newline separated path to folders to search for included files in. Default value: `nil`.
---@return string?
function ac.loadINIppFile(iniFilename, includeDirs) end

---Returns name of MGUK delivery program. If there is no such car or program, returns `nil`.
---@param carIndex integer @0-based car index.
---@param programIndex integer? @0-based program index (if negative, name of currently selected program will be returned. Default value: -1.
---@return string?
function ac.getMGUKDeliveryName(carIndex, programIndex) end

---Get short name of a tyre set, either currently selected or with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@return string?
function ac.getTyresName(carIndex, compoundIndex) end

---Get 0-based index of a tyres set with a given short name, or -1 if there is no such tyres set (or such car).
---@param carIndex integer @0-based car index.
---@param tyresShortName string @Short tyres set name (usually a couple of symbols long).
---@return integer
function ac.getTyresIndex(carIndex, tyresShortName) end

---Returns long name of a tyre set with certain index. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param compoundIndex integer? @0-based tyre set index, if set to -1, short name of currently selected tyre set will be returned. Default value: -1.
---@param includePostfix boolean? @Set to `false` to skip short name postfix. Default value: `true`.
---@return string?
function ac.getTyresLongName(carIndex, compoundIndex, includePostfix) end

---Get car ID (name of its folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarID(carIndex) end

---Get car name (from its JSON file) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@param includeYearPostfix boolean? @Set to `true` to add a year postfix. Default value: `false`.
---@return string?
function ac.getCarName(carIndex, includeYearPostfix) end

---Get selected skin ID of (name of skin’s folder) of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarSkinID(carIndex) end

---Get name of a manufacturer of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarBrand(carIndex) end

---Get name of manufactoring country of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarCountry(carIndex) end

---Refers to AI spline.
---@return boolean
function ac.hasTrackSpline() end

---Finds nearest point on track AI spline (fast_lane) and returns its normalized position. If there is no track spline, returns -1.
---@param v vec3
---@return number
function ac.worldCoordinateToTrackProgress(v) end

---Returns distance from AI spline to left and right track boundaries.
---@param v number @Lap progress from 0 to 1.
---@return vec2 @X for left side, Y for right side.
function ac.getTrackAISplineSides(v) end

---@param v number
---@param linear boolean? @Use linear interpolation. Default value: `false`.
---@return vec3
function ac.trackProgressToWorldCoordinate(v, linear) end

---@param v number
---@param r vec3
---@param linear boolean? @Use linear interpolation. Default value: `false`.
function ac.trackProgressToWorldCoordinateTo(v, r, linear) end

---Converts world coordinates into track coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.worldCoordinateToTrack(v) end

---Converts track coordinates into world coordinates. Track coordinates:
--- - X for normalized position (0 — right in the middle, -1 — left side of the track, 1 — right size);
--- - Y for height above track in meters;
--- - Z for track progress.
---@param v vec3
---@return vec3
function ac.trackCoordinateToWorld(v) end

---Returns track world coordinates in degrees.
---@param worldPos vec3|nil @Added in 0.2.8. If set, function returns coordinates of this point instead. Default value: `nil`.
---@return vec2 @X for latitude, Y for longitude.
function ac.getTrackCoordinatesDeg(worldPos) end

---Returns timezone offset for the track in seconds.
---@param time number? @If set, returns timezone for given timestamp (DST might differ). Default value: `nil`.
---@return vec2 @X for base offset, Y for summer time offset.
function ac.getTrackTimezoneBaseDst(time) end

---Name of a sector.
---@param trackProgress number @Track position from 0 to 1.
---@return string
function ac.getTrackSectorName(trackProgress) end

---Returns directory of the script.
---@return string
function ac.dirname() end

---If `fileName` is not an absolute path, looks for a file in script directory, then relative to CSP folder,
---then relative to AC root folder. If anything is found, returns an absolute path to found file, otherwise
---returns input parameter. If such a filename is not allowed, or `fileName` is `nil`, returns an empty string.
---@param fileName string @File name relative to script folder, or CSP folder, or AC root folder.
---@return path
function ac.findFile(fileName) end

---Returns full path to one of known folders. Some folders might not exist, make sure to create them before writing.
---@param folderID ac.FolderID|string @Could also be a system GUID in “{XX…}” form.
---@return string @Returns empty string if there is no match.
function ac.getFolder(folderID) end

---Turns time in milliseconds into common lap time presentation, like 00:00.123. If minutes exceed 60,
---hours will also be added, but only if `allow_hours` is `true` (default is `false`).
---@param time number @Time in milliseconds.
---@param allowHours boolean? @Set to `true` to add hours as well. If `false` (default value), instead it would produce 99:99.999. If `true`, milliseconds will use two digits instead of three. Default value: `false`.
---@return string
function ac.lapTimeToString(time, allowHours) end

---Returns country name based on nation code (three symbols for country ID).
---@param nationCode ac.NationCode
---@return string
function ac.getCountryName(nationCode) end

---Reads a file and returns it as a text. Aware of “data.acd”, so can be used to access files in “data.acd” and, for example, read car specs.
---@param filename string
---@return string
function ac.readDataFile(filename) end

---Parse INIpp configuration file, return it as JSON. Deprecated, use `ac.INIConfig.parse()` instead.
---@deprecated
---@param iniData string
---@return string
function ac.parseINIppFile(iniData) end

---Use `ac.getTrackID()` instead.
---@deprecated
---@return string
function ac.getTrackId() end

---Returns track ID (name of its folder).
---@return string
function ac.getTrackID() end

---Returns track layout ID (name of layout folder, without name of track folder), or empty string if there is no layout.
---@return string
function ac.getTrackLayout() end

---Returns full track ID (name of track folder and layout folder joined by some string, or just name of track folder if there is no layout).
---@param separator string?? @Default value: '-'.
---@return string
function ac.getTrackFullID(separator) end

---Returns track name (as set in its JSON file).
---@return string
function ac.getTrackName() end

---Given name, returns a path like …/assettocorsa/content/tracks/[track ID]/data/[name], taking into account layout as well.
---@param fileName string
---@return string
function ac.getTrackDataFilename(fileName) end

---Get car tags. If there is no such car, returns `nil`. @nodiscard
---@param carIndex integer @0-based car index.
---@return string[]|nil
function ac.getCarTags(carIndex) end

---A key unique for each individual PC (uses serial numbers of processor and motherboard).
---@return string
function ac.uniqueMachineKey() end

---A key unique for each individual PC (uses serial numbers of processor and motherboard). Asynchronous version. Returned value is in binary,
--- use something like `ac.encodeBase64()` to encode data in readable format. Since 0.3.0-preview144, feel free to use `ac.uniqueMachineKey()` instead,
--- value is computed once sometime at the launch.
---@param callback fun(err: string?, response: string?)
function ac.uniqueMachineKeyAsync(callback) end

---Returns ordered list of data file names (not full paths, just the names) of a certain car. Works for both packed and unpacked cars. If failed,
---returns empty list. @nodiscard
---@param carIndex integer? @0-based car index.
---@return string[]
function ac.getCarDataFiles(carIndex) end

---Returns list of car colliders. @nodiscard
---@param carIndex integer? @0-based car index.
---@param actualColliders boolean? @Set to `true` to draw actual physics colliders (might differ due to some physics alterations). Default value: `false`.
---@return {position: vec3, size: vec3}[]
function ac.getCarColliders(carIndex, actualColliders) end

---Returns squared distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@return number
function ac.distanceToRenderSquared(pos) end

---Returns distance to main camera. In splitscreen mode, returns smallest distance between to cameras. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@return number
function ac.distanceToRender(pos) end

---Returns `true` if position is closer to main camera than the threshold. In splitscreen mode, considers secondary camera. In the future, might be altered by
---more entities, such as additional OBS cameras. Useful if you have a detail level changing with distance.
---@param pos vec3
---@param distance number
---@return boolean
function ac.closerToRenderThan(pos, distance) end

---Encodes float into FP16 format and returns it as uint16.
---@param v number
---@return integer
function ac.encodeHalf(v) end

---Encodes two floats from a vector into FP16 format and returns it as uint32.
---@param v number|vec2
---@return integer
function ac.encodeHalf2(v) end

---Decodes float from FP16 format (represented as uint16) and returns a regular number.
---@param v integer
---@return number
function ac.decodeHalf(v) end

---Decodes two floats from FP16 format (represented as uint32) and returns a vector.
---@param v integer
---@return vec2
function ac.decodeHalf2(v) end

---Computes SHA-256 checksum for given binary data. Very secure, but might be slow with large amounts of data. Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.checksumSHA256(data) end

---Computes 64-bit xxHash checksum for given binary data. Very fast, not that great for encryption purposes.
---Use `bit.tohex()` to turn result into a hex representation. Data string can contain zero bytes.
---@param data binary
---@return integer
function ac.checksumXXH(data) end

---Compresses data. First byte of resulting data is compression type, next four are uncompressed data size, rest is compressed data
---itself. If data is failed to compress, returns `nil`. Data string can contain zero bytes.
---@param data binary
---@param type ac.CompressionType
---@param level integer? @Higher level means better, but slower compression. Maximum value: 12. Default value: 9.
---@return string?
function ac.compress(data, type, level) end

---Decompresses data. First byte of input data is compression type, next four are uncompressed data size. If data is damaged, returns `nil`.
---Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.decompress(data) end

---Encodes data in base64 format. Data string can contain zero bytes.
---@param data binary
---@param trimResult boolean? @If `true`, ending “=” will be trimmed. Default value: `false`.
---@return string?
function ac.encodeBase64(data, trimResult) end

---Decodes data from base64 format (ending “=” are not needed).
---@param data string
---@return string?
function ac.decodeBase64(data) end

---Converts string from UTF-8 to UTF-16 format (two symbols per character). All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes.
---@param data string
---@return string?
function ac.utf8To16(data) end

---Converts string from UTF-16 (two symbols per character) to common Lua UTF-8. All strings Lua operates with regularly are consired UTF-8. UTF-16 strings
---can’t be used in any CSP API unless documentation states that function can take strings containing zeroes. Data string can contain zero bytes.
---@param data binary
---@return string?
function ac.utf16To8(data) end

---Given an FFI struct, returns bytes with its content. Resulting string may contain zeroes.
---@param data binary
---@return string?
function ac.structBytes(data) end

function ac.memoryBarrier() end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfBegin(value) end

---Simple helper to measure time and analyze performance. Call `ac.perfBegin('someKey')` to start counting time and
--- `ac.perfEnd('someKey')` to stop. Measured time will be shown in Lua App Debug app in CSP (moving average across all
--- perfBegin/perfEnd calls). Note: keys on perfBegin() and perfEnd() should match.
---@param value string
function ac.perfEnd(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameBegin(value) end

---Unlike `ac.perfBegin('someKey')/ac.perfEnd('someKey')`, `ac.perfFrameBegin(0)/ac.perfFrameEnd(0)` will accumulate time
--- between calls as frame progresses and then use the whole sum for moving average. This makes it suitable for measuring
--- how much time in a frame repeatedly ran bit of code takes. To keep performance as high as possible (considering that
--- it could be ran in a loop), it uses integer keys instead of strings.
---@param value integer
function ac.perfFrameEnd(value) end

---@return vec3
function ac.getCameraPosition() end

---@return vec3
function ac.getCameraUp() end

---@return vec3
function ac.getCameraSide() end

---@return vec3
function ac.getCameraForward() end

---This vector is pointing backwards! Only kept for compatibility. For proper one, use `ac.getCameraForward()`.
---@deprecated
---@return vec3
function ac.getCameraDirection() end

---Value in degrees.
---@return number
function ac.getCameraFOV() end

---@param r vec3 @Destination.
function ac.getCameraPositionTo(r) end

---@param r vec3 @Destination.
function ac.getCameraUpTo(r) end

---@param r vec3 @Destination.
function ac.getCameraSideTo(r) end

---@param r vec3 @Destination.
function ac.getCameraForwardTo(r) end

---@param r vec3 @Destination.
function ac.getCameraDirectionTo(r) end

---Returns camera position in car coordinates system.
---@return vec3
function ac.getCameraPositionRelativeToCar() end

---Returns compass angle for given directory.
---@param dir vec3
---@return number @Angle from 0 to 360 (0/360 for north, 90 for east, etc.)
function ac.getCompassAngle(dir) end

---Value in degrees.
---@return number
function ac.getSunAngle() end

---Value in degrees.
---@return number
function ac.getSunPitchAngle() end

---Value in degrees.
---@return number
function ac.getSunHeadingAngle() end

---Returns true if camera is focused on interior (interior audio is playing).
---@return boolean
function ac.isInteriorView() end

---@return boolean
function ac.isInReplayMode() end

---@param filename string
---@param outputFilename string
function ac.compressTexture(filename, outputFilename) end

---Returns precalculated sound speed in m/s taking into account humidity, altitude, pressure, etc.
---@return number
function ac.getSoundSpeedMs() end

---Returns air pressure in kPa.
---@param p vec3
---@return number
function ac.getAirPressure(p) end

---Returns air humidity in 0…1 range. Currently doesn’t use position parameter, but it might change later.
---@param p vec3
---@return number
function ac.getAirHumidity(p) end

---Returns string with last error thrown by this script, or `nil` if there wasn’t an error. Use it in case you would want to set some nicer error reporting.
---@return string?
function ac.getLastError() end

---Returns audio volume for given channel, value from 0 to 1. If channel is not recognized, returns `fallbackValue` if specified, unless (since 0.2.4) you specify key in a
---`'your.namespace/Readable name'` format: this will register a new volume level and show it in Audio Volume app for sessions where value was
---accessed or set.
---@param audioChannelKey ac.AudioChannel
---@param carIndex integer? @If set and a Kunos car-related channel (`'dirt'`, `'engine'`, `'opponents'`, `'surfaces'`, `'transmission'`, `'tyres'`, `'wind'`) is used, returns a car-specific multiplier (1 by default). Default value: -1.
---@param fallbackValue number? @Default value: -1.
---@return number @Value from 0 to 1, or -1 if there is no such channel.
function ac.getAudioVolume(audioChannelKey, carIndex, fallbackValue) end

---Returns name of output audio device.
---@return string
function ac.getAudioOutputDevice() end

---Consider using `ac.getCar(carIndex).speedKmh` instead.
---@param carIndex integer @0-based car index.
---@return number
function ac.getCarSpeedKmh(carIndex) end

---Returns 'R', 'N', number of engaged gear or value set by `ac.setGearLabel()` if used (for implementing automatic gearboxes).
---If your code is displaying current gear, this might be a preferable choice.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getCarGearLabel(carIndex) end

---Returns approximate Y coordinate of ground, calculated by using depth from reflection cubemap. Does not have a performance impact (that value
--- will be calculated anyway for CSP to run.
---@return number
function ac.getGroundYApproximation() end

---Returns current delta time associated with UI (so values are non-zero if sim or replay are paused).
---@return number @Seconds.
function ac.getDeltaT() end

---Returns current delta time associated with simulation (so values are zero if sim or replay are paused).
---@return number @Seconds.
function ac.getGameDeltaT() end

---Returns delta time for current script. If script only runs every N frames (like car display scripts by default),
---this value will be greater than regular `dt` from simulation state.
---@return number
function ac.getScriptDeltaT() end

---Returns current time multiplier.
---@return number
function ac.getConditionsTimeScale() end

---Returns name of current PP filter with “.ini”.
---@return string?
function ac.getPpFilter() end

---Value is in m/s.
---@return vec3
function ac.getWindVelocity() end

---Value is in m/s.
---@param r vec3 @Destination.
function ac.getWindVelocityTo(r) end

---@return boolean
function ac.isWeatherFxActive() end

---Distance and turn angle (in degrees) for the upcoming turn. If failed to compute, both would be -1. If car is facing wrong way, turn angle is either
---180° or -180° depending on where steering wheel of a car is.
---@param carIndex integer? @Default value: 0.
---@return vec2
function ac.getTrackUpcomingTurn(carIndex) end

---Get full driver name of a driver of a certain car. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverName(carIndex) end

---Get three character nation code of a driver of a certain car. Nation code is a three-letter uppercase country identifier. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “ITA” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return ac.NationCode?
function ac.getDriverNationCode(carIndex) end

---Get full nationality of a driver of a certain car. Usually, it’s a full country name. If nationality is not set, a value from JSON
---is returned. If it’s missing there, a fallback “Italy” is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverNationality(carIndex) end

---Get name of a team of a driver of a certain car. Team names can be configured in entry list online. If nationality is not set, a value from JSON
---is returned. If it’s missing there, an empty string is returned. If there is no such car, returns `nil`.
---@param carIndex integer @0-based car index.
---@return string?
function ac.getDriverTeam(carIndex) end

---Get number of a driver of a certain car. If number is set in skin JSON, it will be returned, otherwise it’s a unique 1-based number.
---If there is no car with such index, 0 is returned.
---@param carIndex integer @0-based car index.
---@return integer
function ac.getDriverNumber(carIndex) end

---Returns `true` if a certain driver is using custom icon. Use `'carN::special::driver'` as image filename to draw it (when not custom,
---will give you a livery icon or a fallback dark image).
---@param carIndex integer @0-based car index.
---@return boolean
function ac.isCustomIconSet(carIndex) end

---Get session name for a session with given index. Use `ac.getSim()` to check number of sessions and more information about them.
---If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionName(sessionIndex) end

---Is keyboard button being held.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyDown(keyIndex) end

---Is keyboard button just moved from not held to held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
---Still, if you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
---(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyPressed(keyIndex) end

---Is keyboard button just moved from held to not held in the last graphics frame (or, for physics scripts since 0.2.7, physics frame).
---If you’re working on car physics script, consider using `ac.ControlButton()` instead for better customization. If your script is skipping frames
---(such as car display scripts), this might not work as expected, as the frame the button has changed the state in could be skipped.
---@param keyIndex ui.KeyIndex
---@return boolean
function ac.isKeyReleased(keyIndex) end

---Can be called from anywhere. Checks if given point is within main camera frustum (or several, in triple screen mode) or not. For checking if something
---is within current camera instead, try `render.isVisible()`.
---@param pos vec3
---@param radius number
---@param gSpace boolean? @Pass `false` if your coordinates are in world-space rather than with origin shift applied (in most cases, you need to use `false`, this argument is added for backwards compatibility. Default value: `true`.
---@param includeFarPlane boolean? @Pass `false` to ignore far plane. Default value: `true`.
---@return boolean @Checks visibility with frustum culling.
function ac.isVisibleInMainCamera(pos, radius, gSpace, includeFarPlane) end

---Returns steering input from -1 to 1.
---@return number
function ac.getControllerSteerValue() end

---Is gas input pressed (pedal, gamepad axis, keyboard button but not mouse button).
---@return boolean
function ac.isControllerGasPressed() end

---Is brake input pressed (pedal, gamepad axis, keyboard button but not mouse button).
---@return boolean
function ac.isControllerBrakePressed() end

---Is gear up input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearUpPressed() end

---Is gear down input pressed (pedal, gamepad button, keyboard button).
---@return boolean
function ac.isControllerGearDownPressed() end

---Get session spawn set (`'START'`, `'PIT'`, `'HOTLAP_START'`, `'TIME_ATTACK'`, etc.) for a session with given index. Use `ac.getSim()`
---to check number of sessions and more information about them. If there is no such session, returns `nil`.
---@param sessionIndex integer
---@return string?
function ac.getSessionSpawnSet(sessionIndex) end

---Forces driver head to be visible even with cockpit camera.
---@param carIndex integer
---@param force boolean? @Default value: `true`.
function ac.forceVisibleHeadNodes(carIndex, force) end

---Checks if a certain gamepad button is pressed.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadButtonID ac.GamepadButton
---@return boolean
function ac.isGamepadButtonPressed(gamepadIndex, gamepadButtonID) end

---Returns value of a certain gamepad axis.
---@param gamepadIndex integer @0-based index, from 0 to 7 (first four are regular gamepads, second four are Dual Shock controllers).
---@param gamepadAxisID ac.GamepadAxis
---@return number
function ac.getGamepadAxisValue(gamepadIndex, gamepadAxisID) end

---Returns number of DirectInput devices (ignore misleading name).
---@return integer
function ac.getJoystickCount() end

---Returns name of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickName(joystick) end

---Returns instance GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickInstanceGUID(joystick) end

---Returns product GUID of a DirectInput device (ignore misleading name). If there is no such device, returns `nil`.
---@param joystick integer @0-based index.
---@return string?
function ac.getJoystickProductGUID(joystick) end

---Returns index of a DirectInput device by its instance GUID, or `nil` if there is no such device (ignore misleading name).
---@param guid string
---@return integer?
function ac.getJoystickIndexByInstanceGUID(guid) end

---While this function returns accurate number of device axis, consider using 8 instead if you need to iterate over them.
---Actual axis can be somewhere within those 8. For example, if device has a single axis, it could be that you need to access
---axis at index seven to get its value (rest will be zeroes).
---@param joystick integer
---@return integer
function ac.getJoystickAxisCount(joystick) end

---Returns number of buttons of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickButtonsCount(joystick) end

---Returns number of D-pads (aka POVs) of a DirectInput device (ignore misleading name).
---@param joystick integer
---@return integer
function ac.getJoystickDpadsCount(joystick) end

---Checks if a button of a DirectInput device is currently held down (ignore misleading name).
---@param joystick integer
---@param button integer
---@return boolean
function ac.isJoystickButtonPressed(joystick, button) end

---Returns axis value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param axis integer
---@return number
function ac.getJoystickAxisValue(joystick, axis) end

---Use `ac.getJoystickAxisValue()` instead.
---@deprecated
---@param joystick integer
---@param axis integer
---@return number
function ac.isJoystickAxisValue(joystick, axis) end

---Returns D-pad (aka POV) value of a DirectInput device (ignore misleading name).
---@param joystick integer
---@param dpad integer
---@return integer @If D-pad is not moved, -1, or a value from 0 to 36000 storing the angle (0: up, 9000: right).
function ac.getJoystickDpadValue(joystick, dpad) end

---Use `ac.getJoystickDpadValue()` instead.
---@deprecated
---@param joystick integer
---@param dpad integer
---@return integer
function ac.isJoystickDpadValue(joystick, dpad) end

---Checks current stylus/pen/mouse using RealTimeStylus API (compatible with Windows Ink). Should support things like Wacom tables (if drivers are installed
---and Windows Ink compatibility in options is not disabled).
---
---Note: the moment its called, CSP initializes RealTimeStylus API to monitor pen state until game closes. With that, CSP will also use that data
---for mouse (or pen) pointer interaction with UI in general, especially for IMGUI apps.
---[There is a weird issue in Windows 10](https://answers.microsoft.com/en-us/windows/forum/all/windows-pen-tablet-click-and-drag-lag/9e4cac7d-69a0-4651-87e8-7689ce0d1027)
---where it doesn’t register short click-and-drag events properly expecting a touchscreen gesture. Using RealTimeStylus API for UI in general solves that.
---@return number @Pen pressure from 0 to 1 (if mouse is used, pressure is 1).
function ac.getPenPressure() end

---Returns name of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerName() end

---Returns IP address of the current online server, or `nil` if it’s not available.
---@return string?
function ac.getServerIP() end

---Returns HTTP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortHTTP() end

---Returns TCP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortTCP() end

---Returns UDP post of the current online server, or -1 if it’s not available.
---@return integer
function ac.getServerPortUDP() end

---Returns index of a car with a driver with a certain name, or -1 if there is no such car.
---@param driverName string
---@return integer
function ac.getCarByDriverName(driverName) end

---Returns leaderboard car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarLeaderboardPosition(carIndex) end

---Returns real time car position, same as Python function with the same name. Does not work online. For an alternative solution,
---get position calculated by CSP via `ac.getCar(N).racePosition`.
---@param carIndex integer @0-based car index.
---@return integer @Returns -1 if couldn’t calculate the value.
function ac.getCarRealTimeLeaderboardPosition(carIndex) end

---How much of moon area is currently lit up.
---@return number
function ac.getMoonFraction() end

---@return number
function ac.getAltitude() end

---Get direction to a sky feature in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param skyFeature ac.SkyFeature
---@param distance number|refnumber|nil @Default value: `nil`.
---@param time number? @If set, it’ll compute direction for the given time instead of the current time. Default value: `nil`.
---@return vec3
function ac.getSkyFeatureDirection(skyFeature, distance, time) end

---Get direction to a star in the sky in world-space (corrected for track heading). If feature is not available, returns a zero vector.
---@param declRad number
---@param rightAscRad number
---@return vec3
function ac.getSkyStarDirection(declRad, rightAscRad) end

---Call this function if your script caused car shape to change and CSP would refresh interior masking, car heightmap and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarShape(carIndex) end

---Call this function if your script caused car color to change and CSP would refresh color map for bounced light and more.
---@param carIndex integer? @Default value: 0.
function ac.refreshCarColor(carIndex) end

---Updates state of high-res driver model. Use it before moving driver nodes manually for extra animations: if called,
--- next model update possibly overwriting your custom positioning will be skipped. Also, model update will be enforced
--- so you can blend your custom state.
---
--- Since 0.1.80-preview397, does not apply if HR driver model is currently hidden unless second argument is `true` (in which
--- case it’ll activate driver model for a few frames).
---@param carIndex integer? @For car scripts, always applied to associated car instead. Default value: -1.
---@param forceVisible boolean? @Set to `true` to forcefully switch to HR model for a few frames. Default value: `false`.
function ac.updateDriverModel(carIndex, forceVisible) end

---@param ret mat4x4
---@param carIndex integer
---@return boolean
function ac.getDriverHeadTransformTo(ret, carIndex) end

---Block system messages based on a given regular expression.
---@param regex string @Any message with title or description containing this regex will be discarded.
---@return ac.Disposable
function ac.blockSystemMessages(regex) end

---Sets a callback which will be called when car crosses a certain point on a track. Won’t be triggered if car is in pitlane or recently jumped.
---Time is relative to the same point as `ac.SimState.time`. Tracking happens on physics thread and is interpolated based on car position, so it
---should be precise more than within 3 ms steps.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param progress number @Track progress from 0 to 1.
---@param callback fun(carIndex: integer, timeMs: number)
---@return ac.Disposable
function ac.onTrackPointCrossed(carIndex, progress, callback) end

---Sets a callback which will be called when a new session starts (or restarts). Doesn’t get triggered at the start of the race (Lua scripts load when
---the first session is already up and running to ensure the overall state of the sim is complete)!
---@param callback fun(sessionIndex: integer, restarted: boolean)
---@return ac.Disposable
function ac.onSessionStart(callback) end

---Sets a callback which will be called when AC resolution changes. Happens when window size changes, or when making a screenshot.
---Note: some scripts, such as WeatherFX style or post-processing script, reload completely when resolution changes, but if they’d call
---this function at any point, they would no longer reload. Instead CSP assumes they can handle resolution changes on their side.
---@param callback fun(newSize: vec2, makingScreenshot: boolean)
---@return ac.Disposable
function ac.onResolutionChange(callback) end

---Sets a callback which will be called when selected tyres change for some car. For car scripts to track changes in their own car, use `car.index` as first argument.
--- Note: for physics scripts this even might come a few frames late, but it shouldn’t be a major issue since tyres changes only happen when car is stationary anyway.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer, setIndex: integer, shortName: string, longName: string)
---@return ac.Disposable
function ac.onTyresSetChange(carIndex, callback) end

---Sets a callback which will be called when new user connects the server and their car appears (doesn’t do anything outside of online race).
---@param callback fun(connectedCarIndex: integer, connectedSessionID: integer)
---@return ac.Disposable
function ac.onClientConnected(callback) end

---Sets a callback which will be called when a user disconnects (doesn’t do anything outside of online race).
---@param callback fun(disconnectedCarIndex: integer, disconnectedSessionID: integer)
---@return ac.Disposable
function ac.onClientDisconnected(callback) end

---Sets a callback which will be called when control settings change live.
---@param callback fun()
---@return ac.Disposable
function ac.onControlSettingsChanged(callback) end

---Sets a callback which will be called when triple screen configuration changes.
---@param callback fun()
---@return ac.Disposable
function ac.onTripleConfigurationChanged(callback) end

---Returns `true` if a Lua app with given ID is loaded and currently active (not countring background services).
---@param appID string
---@return boolean
function ac.isLuaAppRunning(appID) end

---Returns an estimate of optimal braking amount based on current grip level, or -1 if it can’t be computed for a given car.
---@param carIndex integer
---@return number
function ac.getCarOptimalBrakingAmount(carIndex) end

---Returns an estimate of maximum speed for a given gear in km/h, -1 if it can’t be computed for a given car, or 0 if there is no such gear. Returns negative
---speed for the reverse gear.
---@param carIndex integer
---@param gearIndex integer @Gear index, 1 for first gear (same as `ac.getCar().gear`).
---@return number @Returns speed in km/h.
function ac.getCarMaxSpeedWithGear(carIndex, gearIndex) end

---Changes location of script storage. Scripts without I/O access will have “shared-” appended to their relative path and can’t use “.” or slashes in it
---to ensure configs are contained within the directory. Note: before 0.2.4 calls to this function by scripts without I/O access would have no effect.
---@param relativePath string @Path relative to directory with Lua configs. If empty, call won’t have an effect.*/.
---@param prefix string|nil @Optional prefix. Default value: `nil`.
function ac.storageSetPath(relativePath, prefix) end

---Broadcasts a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
---a unique name for your events to avoid collisions with other scripts and Lua apps.
---
---Callbacks will be called next time the script is updating.
---
---Note: if your scripts need to exchange data frequently, consider using `ac.connect()` instead, as it allows to establish a typed connection
---with much less overhead.
---@param key string
---@param data serializable
---@return integer @Returns number of listeners to the event with given key.
function ac.broadcastSharedEvent(key, data) end

---Subscribes to a shared event. With shared events, different Lua scripts can exchange messages and data. Make sure to come up with
---a unique name for your events to avoid collisions with other scripts and Lua apps.
---
---Callback will be called next time this script is updating.
---@param key string
---@param callback fun(data: string|number|boolean|nil, senderName: string, senderType: string, senderID: integer)
---@param processPostponed boolean? @Set to `true` to process previously broadcasted and yet non-processed events (up to 40). Default value: `false`.
---@return ac.Disposable
function ac.onSharedEvent(key, callback, processPostponed) end

---@param callback fun(senderName: string, senderType: string, senderID: integer)
---@return ac.Disposable
function ac.onLuaScriptDisposal(callback) end

---@param hand integer @0 for left, 1 for right.
---@param busy boolean|`true`|`false` @Busy hand doesn’t have visual marks and doesn’t interact with UI and car elements.
function ac.setVRHandBusy(hand, busy) end

---@param hand integer @0 for left, 1 for right.
---@param frequency number
---@param amplitude number
---@param duration number? @Duration in seconds. Default value: 0.01.
function ac.setVRHandVibration(hand, frequency, amplitude, duration) end

---@param cspModuleID ac.CSPModuleID
---@return boolean
function ac.isModuleActive(cspModuleID) end

---@return number, number
function ac.getPerformanceCPUAndGPUTime() end

---Returns index of a car in front of other car (within 100 m), or -1 if there is no such car. Broken, not sure why is it even here, kept for compatibility.
---@deprecated.
---@param carMainIndex integer
---@param distance number|refnumber|nil @Default value: `nil`.
---@return integer
function ac.getCarIndexInFront(carMainIndex, distance) end

---Calculates time gap between two cars in seconds. In race sessions uses total driven distance and main car speed, in other sessions simply
---compares best lap times. If main car is ahead of comparing-to car (in front of, or has better lap time for non-race sessions), value will
---be negative.
---
---In the future implementation might change for something more precise.
---@param carMainIndex integer @0-based index.
---@param carComparingToIndex integer @0-based index.
---@return number
function ac.getGapBetweenCars(carMainIndex, carComparingToIndex) end

---Returns audio peak level for the system, for left and right channels. Careful: AC audio is also included, but
---it still might be used to fake some audio visualization.
---@param output boolean? @Set to `false` to monitor peak from a microphone. Note: it would only work if there are other processes actually listening to audio. Default value: `true`.
---@return vec2
function ac.mediaCurrentPeak(output) end

---Stores value in session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
---Note: if you need to exchange a lot of data between Lua scripts, consider using ac.connect instead.
---
---Data string can contain zeroes.
---@param key string @Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.
---@param value string|number|nil @Value to store. If not number or `nil`, will be converted into a string.
function ac.store(key, value) end

---Reads value from session shared Lua/Python storage. This is not a long-term storage, more of a way for different scripts to exchange data.
---Note: if you need to exchange data between Lua scripts, use `ac.connect()` instead. And if despite that you need to exchange data between
---car scripts, make sure to add car index to the key.
---@param key string @Unique key. If starting with “.”, value won’t be shown in Lua Debug app and will be considered temporary and unimportant.
---@return string|number|nil
function ac.load(key) end

---Set texture key to load encoded textures.
---@param key string? @Key to decode subsequently loading textures.
function ac.setTextureKey(key) end

---Encode texture. To load texture later, first call `ac.setTextureKey()`.
---@param filename string @Input filename.
---@param outputFilename string @Should be inside of AC folder.
---@param key string?
---@param applyLz4Compression boolean?
---@return boolean @Returns `false` if file operations failed.
function ac.encodeTexture(filename, outputFilename, key, applyLz4Compression) end

---Sets a callback which will be called when album cover changes.
---@param callback fun(hasCover: boolean)
---@return ac.Disposable
function ac.onAlbumCoverUpdate(callback) end

---Switches to the next track in currently active music player (by simulating media key press).
function ac.mediaNextTrack() end

---Switches to the previous track in currently active music player (by simulating media key press).
function ac.mediaPreviousTrack() end

---Pauses or unpauses current track in currently active music player (by simulating media key press).
function ac.mediaPlayPause() end

---Returns player’s car setup state.
---@return 'legal'|'illegal'|'validating', string? @Returns car setup state and optional reason for setup to be illegal (might be set by car physics script).
function ac.getCarSetupState() end

---Prints message to AC console.
---@param message string?
---@param withoutPrefix boolean? @Default value: `false`.
function ac.console(message, withoutPrefix) end

---Returns `false` if tyres with this short name are illegal in this race. Note: if all of car tyres are illegal, all of them will be legal.
---@param name string
---@return boolean
function ac.areTyresLegal(name) end

---Show message using AC system messages UI. Pass empty `title` and `description` to hide currently shown message, if any.
---
--- Types:
--- - Default: regular message shown on top in white text.
--- - 'illegal': message about an illegal violation. Can be used to warn driver about a crucial mistake, such as lap time
---being invalidated, or wear plank wear exceeding allowed limit. Doesn’t apply any penalties on its own.
---@param title string
---@param description string
---@param type nil|'illegal' @Optional message type.
---@param time number? @Time to show message for in seconds. Default value: 5.
function ac.setMessage(title, description, type, time) end

---Listen to messages, including the ones shown by `ac.setMessage()` and `ac.setIllegalMessage()`.
---@param callback fun(title: string, description: string, type: nil|'illegal', time: number)
---@return ac.Disposable
function ac.onMessage(callback) end

---Use `ac.setMessage()` instead.
---@deprecated
---@param title string
---@param description string
function ac.setSystemMessage(title, description) end

---Return the number of unread chat messages, or 0 in an offline race.
---@return integer
function ac.getUnreadChatMessages() end

---Return distances to the nearest left and right cars in meters within 20 meters, or `nil` if there are no cars nearby or blind spot detection is not available for this car.
---Meant to be used for things like blind spot warnings on side mirrors, it’s fast but inaccurate and only computes results for the nearest cars.
---@param carIndex integer @0-based car index.
---@return number?, number?
function ac.getCarBlindSpot(carIndex) end

---Sets given text to the clipboard.
---@param text string
---@return boolean @Returns `false` if failed.
function ac.setClipboardText(text) end

---Sets a callback which will be called when replay activates, deactivates or jumps around when active (could be good, for things, to clear out particles).
---@param callback fun(event: 'start'|'stop'|'jump')
---@return ac.Disposable
function ac.onReplay(callback) end

---Sets a callback which will be called when a car teleports somewhere or its state gets reset.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarJumped(carIndex, callback) end

---Sets a callback which will be called when a car’s color changes.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarColorChanged(carIndex, callback) end

---Sets a callback which will be called when a car completes a lap. Should work for remote cars as well.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer, lapTime: integer, valid: boolean, cuts: integer, lapCount: integer)
---@return ac.Disposable
function ac.onLapCompleted(carIndex, callback) end

---Sets a callback which will be called when a car collides with a wall or another car. Note: collisions in AC are usually lasting a few frames,
---but this callback will only be called once when collision starts (or when index of a car this car collided with has changed). Use
---`ac.getCar().collisionDepth` and similar to analyze the collision in detail. Works in replays as well.
---@param carIndex integer @0-based car index, or -1 for an event to be called for all cars.
---@param callback fun(carIndex: integer)
---@return ac.Disposable
function ac.onCarCollision(carIndex, callback) end

---Sets a callback which will be called when a file changes.
---Not available to scripts without I/O access.
---@param filename path @Full path to a file to monitor.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onFileChanged(filename, callback) end

---Sets a callback which will be called when folder contents change.
---Not available to scripts without I/O access.
---@param folder path @Full path to a directory to monitor.
---@param filter string? @CSP filter (? for any number of any symbols, regex if “`” quotes are used, or a complex query) applied to full file path, or `nil`.
---@param recursive boolean? @If `true`, changes in subfolders are also detected. Default value: `false`.
---@param callback fun(files: string[])
---@return ac.Disposable
function ac.onFolderChanged(folder, filter, recursive, callback) end

---Sets a callback which will be called when config for certain CSP module has changed.
---@param cspModuleID ac.CSPModuleID @ID of a module to monitor.
---@param callback fun() @Callback function.
---@return ac.Disposable
function ac.onCSPConfigChanged(cspModuleID, callback) end

---Sets a callback which will be called when a new screenshot is made.
---@param callback fun()
---@return ac.Disposable
function ac.onScreenshot(callback) end

---Sets a callback which will be called when a command opening a certain section in main menu has been called. More types of pages might be added later.
---@param callback fun(section: 'info'|'setup'|'telemetry'|'time')
---@return ac.Disposable
function ac.onOpenMainMenu(callback) end

---Sets a callback which will be called when list of setups changes.
---@param callback fun()
---@return ac.Disposable
function ac.onSetupsListRefresh(callback) end

---Sets a callback which will be called when setup is loaded or saved. Use `ac.INIConfig.currentSetup()` to load the setup.
---@param callback fun(operation: 'load'|'save', filename: string) @Callback function.
---@return ac.Disposable
function ac.onSetupFile(callback) end

---Works even if collisions are disabled, actually checks collider state live. Invokes ODE OPCODE computation, so don’t use too much.
---@param car0 integer @0-based car index.
---@param car1 integer @0-based car index.
---@return boolean
function ac.areCarsColliding(car0, car1) end

---Check collisions between two shapes. Note: if you want to do something like check a car against a million of powerups on a track, consider doing
---some prefiltering to speed things up. For example, `ac.HashSpace()` can hugely improve performance for such case.
---@param shape1 integer|physics.ColliderType @First entry to check intersection with, either `physics.ColliderType` or a car index.
---@param transform1 mat4x4? @Optional transform for the first entry. If not set, identity for shapes and car transform for cars.
---@param shape2 integer|physics.ColliderType @Second entry to check intersection with.
---@param transform2 mat4x4? @Optional transform for the second entry.
---@return boolean
function ac.areShapesColliding(shape1, transform1, shape2, transform2) end

---Stops functions like `ac.log()` from logging things into CSP log file, in case you need to log a lot. With it, you
--- can use Lua Debug app to see latest log entries.
---@param value boolean? @Default value: `true`.
function ac.setLogSilent(value) end

---Removes `ac.debug()` entries matching filter.
---@param filter string? @Default value: `?`.
function ac.clearDebug(filter) end

---Returns list of logical drives, each drive in “A:“ format.
---Not available to scripts without I/O access.
---@return string[]
function io.scanDrives() end

---Gets file attributes.
---@param filename path
---@return io.FileAttributes
function io.getAttributes(filename) end

---Sets file attributes. Returns `false` if failed.
---@param filename path
---@param attributes io.FileAttributes
---@return boolean
function io.setAttributes(filename, attributes) end

---Gets full filename of the main AC executable (“…/acs.exe” for most cases).
---Not available to scripts without I/O access.
---@return path
function io.getMainExecutable() end

---Gets extra attributes associated with EXE or DLL files.
---@param filename path
---@return {productName: string?, version: string?}
function io.getExecutableAttributes(filename) end

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`.
---@param filename path
---@param fallbackData string|nil @Data to return if file could not be read.
---@return string|nil @Returns `nil` if file couldn’t be read and there is no fallback data.
function io.load(filename, fallbackData) end

---Reads file content into a string, if such file exists, otherwise returns fallback data or `nil`. Asynchronous version.
---@param filename path
---@param callback fun(err: string?, response: string?)
function io.loadAsync(filename, callback) end

---Writes data into a file, returns `true` if operation was successful. Data string can contain zero bytes.
---Not available to scripts without I/O access.
---@param filename path
---@param data binary?
---@param ensure boolean? @If set to `true`, file will be saved with a temporary postfix and then moved to target destination, thus ensuring content is stored as-is, without ending up damaged in case there is a sudden power loss or something like that. Default value: `false`.
---@return boolean @Returns `false` if failed to write a file.
function io.save(filename, data, ensure) end

---Writes data into a file from a different thread, returns `true` via callback if operation was successful. Data string can contain zero bytes.
---Not available to scripts without I/O access.
---@param filename path
---@param data binary?
---@param callback fun(err: string?)
---@param ensure boolean? @If set to `true`, file will be saved with a temporary postfix and then moved to target destination, thus ensuring content is stored as-is, without ending up damaged in case there is a sudden power loss or something like that. Default value: `false`.
function io.saveAsync(filename, data, callback, ensure) end

---Checks if file or directory exists. If you need to know specifically if a file or directory exists, use `io.dirExists(filename)` or `io.fileExists(filename)`.
---@param filename path
---@return boolean
function io.exists(filename) end

---Checks if directory exists. If there is a file in its place, it would return `false`.
---@param filename path
---@return boolean
function io.dirExists(filename) end

---Checks if file exists. If there is a directory in its place, it would return `false`.
---@param filename path
---@return boolean
function io.fileExists(filename) end

---Checks if file is currently being used by another process by trying to open it without allowing any sharing.
---@param filename path
---@return boolean
function io.fileInUse(filename) end

---Calculates file size in bytes. Returns -1 if there was an error.
---@param filename path
---@return integer
function io.fileSize(filename) end

---Returns creation time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.creationTime(filename) end

---Returns last access time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.lastAccessTime(filename) end

---Returns last write time as number of seconds since 1970, or -1 if there was an error.
---@param filename path
---@return integer
function io.lastWriteTime(filename) end

---Creates new directory, returns `true` if directory was created. If parent directories are missing, they’ll be created as well.
---Not available to scripts without I/O access.
---@param filename path
---@return boolean
function io.createDir(filename) end

---Creates new directory for given filename (as in, take parent path and create directory with it). Returns `true` if directory was created.
---Not available to scripts without I/O access.
---@param filename path
---@return boolean
function io.createFileDir(filename) end

---Returns parent path for given filename.
---@param filename string
---@param level integer? @Default value: 1.
---@return string
function io.getParentPath(filename, level) end

---Compares two paths ignoring case and “/” vs “\” mismatches. Skips repeating slashes. For now, doesn’t account for “/./” or “/dummy/../”.
---@param path0 string?
---@param path1 string?
---@return boolean
function io.arePathsEqual(path0, path1) end

---Returns file name path for given filename.
---@param filename string
---@param noExtension boolean? @Default value: `false`.
---@return string
function io.getFileName(filename, noExtension) end

---Checks if file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does not allow slashes).
---@param fileName string
---@return boolean
function io.isFileNameAcceptable(fileName) end

---Checks if full file name is acceptable, returns `true` if there are no prohibited symbols in it (unlike `io.isFileNameAcceptable()`, does allow slashes).
---@param filename string
---@return boolean
function io.isFilePathAcceptable(filename) end

---Moves a file or a directory with all of its contents to a new place, returns `true` if moved successfully. Can be used for moving or renaming things.
---Not available to scripts without I/O access.
---@param existingFilename path
---@param newFilename path
---@param replaceExisting boolean? @Default value: `false`.
---@return boolean
function io.move(existingFilename, newFilename, replaceExisting) end

---Given an absolute or a relative path, find an actual absolute path. If script doesn’t have I/O access to such file, returns `nil`.
---@param filename path
---@return string|nil
function io.findFile(filename) end

---Copies a file to a new place, returns `true` if copied successfully.
---Not available to scripts without I/O access.
---@param existingFilename path
---@param newFilename path
---@param failIfExists boolean? @Set to `false` to silently overwrite existing files. Default value: `true`.
---@param attemptHardlink boolean? @If `true` and source and destination share the same drive, try to use hardlink first. Default value: `false`.
---@return boolean
function io.copyFile(existingFilename, newFilename, failIfExists, attemptHardlink) end

---Replaces one file with another file. The replacement file assumes the name of the replaced file and its identity. Good if you want to implement
---secure saving (save a file with a new name and then use this function to replace main file with this one: great way to update crucial files
---without risking data corruption in a case of power loss and such). Note: `io.save()` and `io.saveAsync()` already use this safe mechanism if you’re
---setting `ensure` to `true`.
---Not available to scripts without I/O access.
---@param destination path
---@param source path
---@return boolean
function io.replaceFile(destination, source) end

---Deletes a file, returns `true` if file was deleted successfully. To delete empty directory, use `io.deleteDir()`. If you’re operating around important
---files, consider using `io.recycle()` instead.
---Not available to scripts without I/O access.
---@param filename path
---@return boolean
function io.deleteFile(filename) end

---Deletes an empty directory, returns `true` if directory was deleted successfully. To delete a file, use `io.deleteFile()`.
---Not available to scripts without I/O access.
---@param filename path
---@return boolean
function io.deleteDir(filename) end

---Moves file to Windows Recycle Bin, returns `true` if file was moved successfully. Note: this operation is much slower than removing a file with `io.deleteFile()`
---or removing an empty directory with `io.deleteDir()`.
---
--- Note: before 0.3.0, doesn’t use recycle bin and just deletes any file or a folder passed to it.
---Not available to scripts without I/O access.
---@param filename path
---@return boolean
function io.recycle(filename) end

---Adds a new entry to a ZIP file. If there is no such ZIP file, new one will be created. If the ZIP file already has an entry with
---the same name, does nothing and returns `false`. Note: for adding multiple or large files use `io.createZipAsync()` instead.
---Not available to scripts without I/O access.
---@param zipFilename path
---@param entryFilename string
---@param data binary?
---@return boolean
function io.saveToZip(zipFilename, entryFilename, data) end

---Loads file from an archive as a string. Archive would remain open for some time to speed up consequent reads. If failed, returns `nil`. Alternatively,
---you can pass ZIP data instead.
---@param zipFilename path
---@param entryFilename string
---@return string
function io.loadFromZip(zipFilename, entryFilename) end

---Extract files from a ZIP file into a given directory. Creates directory if it’s missing.
---Not available to scripts without I/O access.
---@param zipFilename binary?
---@param destination path @Full path to target directory.
---@param filter nil|string|{filter: string?, crucial: string?} @Optional filter for full entry paths. Since 0.2.10, you can pass a table with a `crucial` param for an entry path of a crucial file: it’ll be extracted last with a temporary name, and renamed after everything is finished. You can later check the existence of this file to ensure ZIP has been unpacked entirely without any interruptions. If `crucial` param has been passed, but file wasn’t found, callback will report an error.
---@param callback fun(err: string?)
function io.extractFromZipAsync(zipFilename, destination, filter, callback) end

---Computes SHA-256 checksum of a given file, returns result in a callback.
---@param filename path
---@param callback fun(err: string, checksum: string)
function io.checksumSHA256(filename, callback) end

---Returns list of entry names from a ZIP-file.
---@param zipFilename binary?
---@return string[]
function io.scanZip(zipFilename) end

---Not available to scripts without I/O access.
---@param filename path? @Pass `nil` to instead get the binary data in the callback.
---@param entries table<string, io.ZipEntry> @Keys store entry names (use “/” as separator for creating sub-folders), and values store either binary data or tables in `io.ZipEntry` format.
---@param callback fun(err: string?, response: binary?) @Callback will contain reference to binary data if `filename` is `nil`.
function io.createZipAsync(filename, entries, callback) end

---Returns time in seconds from script start (with high precision).
---@return number @Seconds.
function os.preciseClock() end

---Sets a callback which will be called when CSP itself or a CSP Lua script tries to open an URL. Return `true` if you’re handling URL, so the event would be stopped.
---@param mask string @Regular expression to check URLs against of.
---@param callback fun(url: string): boolean
---@param priority integer? @Smaller values mean script would be the last to get URL (if other scripts wouldn’t intercept it). Default value: 0.
---@return ac.Disposable
function os.onURL(mask, callback, priority) end

---Altered version of regular `os.execute()`: allows to specify timeout and doesn’t show a new window.
--- Note: please consider using `os.runConsoleProcess()` instead: it’s a lot more robust, asynchronous and tweak-able.
---Not available to scripts without I/O access.
---@param cmd string
---@param timeoutMs integer? @Default value: -1.
---@param windowless boolean? @Default value: `true`.
---@return integer
function os.execute(cmd, timeoutMs, windowless) end

---Changes current directory. Any argument `path`, when parsed and found not to be absolute, will be resolved against current directory.
---By default, uses AC root folder. Any change only applies to the current script only. Current path resets when script is reloaded.
---
---Changes behavior of images and assets lookup as well (by default it scans script folder, CSP folder and then root folder looking for a file,
---which might cause some issues and negatively affect performance).
---
--- For scripts without I/O access, only folders script can read from can be used here.
---
--- Note: as of 0.2.6, some API functions might still use AC root folder. This will be fixed in the future, please do not rely on this behavior!
---@param filename path
---@return string
function os.setCurrentFolder(filename) end

---Returns formatted date. Same as `os.date()`, but returned value does not include system timezome.
---@param format string
---@param timestamp integer
---@return string
function os.dateGlobal(format, timestamp) end

---Adds new directory to look for DLL files in. Warning: do not use this thing unless you really need to, and try to avoid adding LuaJIT extensions:
---LuaJIT build might change in the future breaking ABI compatibility.
---Not available to scripts without I/O access.
---@param filename string @If not absolute, considered to be relative to script root folder.
function os.addDLLDirectory(filename) end

---Load DLL. Loaded DLL can’t be unloaded. Loaded DLLs can’t interact with LuaJIT FFI. If you need to exchange data, use shared memory-mapped files.
--- And if you want to run some code in background, ideally pack it in an EXE and use `os.runConsoleProcess()` so it’d be cleaner, it could unload
--- and reload, and wouldn’t take the entire AC with it if crashed. Ideally, don’t use this function at all, but it’s better if you’d use it than
--- if you’d add a Python app to do the same.
---Not available to scripts without I/O access.
---@param filename string @If not absolute, considered to be relative to script root folder.
function os.loadDLL(filename) end

---Show a popup message using good old MessageBox. Please do not use it for debugging, instead consider using `ac.log()` and `ac.debug('key', 'value')`
---with in-game Lua Debug App.
---Note: do not rely on this function, most likely it might be removed in the future as obstructing.
---@param msg string
---@param type integer? @Type of MessageBox according to WinAPI. Default value: 0.
---@return integer
function os.showMessage(msg, type) end

---Shows file in Windows Explorer (opens folder with it and selects the file).
---Not available to scripts without I/O access.
---@param filename path
function os.showInExplorer(filename) end

---Opens file or directory in Windows Explorer. If it’s a file, associated program will be launched instead.
---Not available to scripts without I/O access.
---@param directory path
function os.openInExplorer(directory) end

---Tries to find a program associated with a filename. Returns path to it, or `nil` if nothing was found.
---Not available to scripts without I/O access.
---@param filename path
---@return path
function os.findAssociatedExecutable(filename) end

---Opens text file at given line in a default text editor. Supports VS Code, Notepad++, Sublime Text and Atom (they all use different
---arguments for line number.
---Not available to scripts without I/O access.
---@param filename path
---@param line integer
function os.openTextFile(filename, line) end

---Opens URL in default system browser.
---@param url string
---@param invokeListeners boolean? @Default value: `true`.
function os.openURL(url, invokeListeners) end

---It’s safer to use `ui.toolWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param windowID string
---@param pos number|vec2
---@param size number|vec2
---@param noPadding boolean? @Default value: `false`.
---@param inputs boolean? @Default value: `false`.
function ui.beginToolWindow(windowID, pos, size, noPadding, inputs) end

function ui.endToolWindow() end

---It’s safer to use `ui.transparentWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param windowID string
---@param pos number|vec2
---@param size number|vec2
---@param noPadding boolean? @Default value: `false`.
---@param inputs boolean? @Default value: `false`.
function ui.beginTransparentWindow(windowID, pos, size, noPadding, inputs) end

function ui.bringWindowToFront() end

function ui.bringWindowToBack() end

function ui.endTransparentWindow() end

---Adds hyperlink effect to the previous item, returns `true` if it’s clicked.
---@param hyperlinkColor rgbm? @Default value: `rgbm(0, 0.5, 1, 1)`.
---@return boolean
function ui.itemHyperlink(hyperlinkColor) end

---Adds a regular underline line to previously drawn text, optionally dashed (if any of dash params are below 1, line is solid).
---@param underlineColor rgbm|nil @By default uses previous text color. Default value: `nil`.
---@param dashSize number? @Default value: 0.
---@param gapSize number? @Default value: 0.
function ui.itemUnderline(underlineColor, dashSize, gapSize) end

---@param text string
function ui.text(text) end

---@param text string
---@param hyperlinkColor rgbm? @Default value: `rgbm(0, 0.5, 1, 1)`.
---@return boolean
function ui.textHyperlink(text, hyperlinkColor) end

---@param text string
---@param alignment number|vec2
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@param ellipsis boolean? @Default value: `false`.
function ui.textAligned(text, alignment, size, ellipsis) end

---@param text string
---@param wrapPos number? @Default value: 0.
function ui.textWrapped(text, wrapPos) end

---@param text string
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.textColored(text, color) end

---Display text and label aligned the same way as value and label widgets.
---@param label string
---@param text string
function ui.labelText(label, text) end

---Shortcut for pushing disabled text color, drawing text and popping it back;.
---@param text string
function ui.textDisabled(text) end

---Returns `true` if 24×24 icon with such ID is known.
---@param iconID ui.Icons
---@return boolean
function ui.isKnownIcon24(iconID) end

---Draws an icon, universal function (great for creating customizable components). Icon can be:
---- An 24×24 icon ID set as is;
---- A country code for a small flag with padding to fit a square;
---- An 32×32 icon ID with “32:” prefix;
---- An 64×64 icon ID with “64:” prefix;
---- An 256×256 icon ID with “XL:” prefix;
---- A large rectangular flag with no padding with “XS:” prefix;
---- An emoticon with “em:” prefix;
---- An icon from an atlas: use “at:FILENAME\nX1,Y1,X2,Y2” format, where X… and Y… are UV coordinates (`ui.atlasIconID()` can help with generating those IDs);
---- A regular image: just pass a path as a string (also works with extra canvases, media elements and such).
---@param iconID ui.Icons
---@param size number|vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
---@param iconSize number|vec2|nil @If set, icon will be this size, but item will be larger (use it if you need to fill an area without stretching an icon). Default value: `nil`.
function ui.icon(iconID, size, tintCol, iconSize) end

---Adds an icon to the previously drawn element.
---@param iconID ui.Icons
---@param size number|vec2 @Size of an icon.
---@param alignment number|vec2 @Alignment of an icon relative to the element.
---@param colorOpt rgbm|nil @If not set, uses text color by default. Default value: `nil`.
---@param padding number|vec2|nil @If not set, uses frame padding by default. Default value: `nil`.
function ui.addIcon(iconID, size, alignment, colorOpt, padding) end

---Draws a 24×24 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size number|vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon24(iconID, size, tintCol) end

---Draws a 32×32 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size number|vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon32(iconID, size, tintCol) end

---Draws a 64×64 icon. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size number|vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.icon64(iconID, size, tintCol) end

---Draws a flag. Use universal `ui.icon()` instead.
---@deprecated
---@param iconID ui.Icons
---@param size number|vec2
---@param tintCol rgbm? @Default value: `rgbm.colors.white`.
function ui.flag(iconID, size, tintCol) end

---@return vec2
function ui.getCursor() end

---@param v number|vec2
function ui.setCursor(v) end

---@param v number|vec2
function ui.offsetCursor(v) end

---@return number
function ui.getCursorX() end

---@param v number
function ui.setCursorX(v) end

---@return number
function ui.getCursorY() end

---@param v number
function ui.setCursorY(v) end

---@param v number
function ui.offsetCursorX(v) end

---@param v number
function ui.offsetCursorY(v) end

---@param offsetFromStart number? @Default value: 0.
---@param spacing number? @Default value: -1.
function ui.sameLine(offsetFromStart, spacing) end

function ui.backupCursor() end

function ui.restoreCursor() end

---@return number
function ui.getMaxCursorX() end

---@return number
function ui.getMaxCursorY() end

---Set maximum cursor value used for estimating amount of content. Use very carefully.
---@param v number
function ui.setMaxCursorX(v) end

---Set maximum cursor value used for estimating amount of content. Use very carefully.
---@param v number
function ui.setMaxCursorY(v) end

---@param spacing number? @If non-negative, value is used for space between lines instead of regular item spacing from current style. Default value: -1.
function ui.newLine(spacing) end

---Lock horizontal starting position and capture group bounding box into one “item” (so you can use `ui.itemHovered()` or layout primitives such as `ui.sameLine()` on whole group, etc.)
---@param width number? @Default value: 0.
function ui.beginGroup(width) end

---Unlock horizontal starting position and capture the whole group bounding box into one “item” (so you can use `ui.itemHovered()` or layout primitives such as `ui.sameLine()` on whole group, etc.)
function ui.endGroup() end

---@return number
function ui.availableSpaceX() end

---@return number
function ui.availableSpaceY() end

---@return vec2
function ui.availableSpace() end

---Returns image size, or zeroes if image is missing or not yet ready.
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@return vec2
function ui.imageSize(imageSource) end

---Imports image from its binary data. Any formats supported by system are supported. Also, new DDS formats are supported as well. Result is cached,
---so subsequent calls don’t take a lot of time. Data string can contain zero bytes.
---
---To clear cached image and free memory, pass returned value to `ui.unloadImage()`.
---@param data binary
---@return string?
function ui.decodeImage(data) end

---Simply draws an image on canvas without adding a new item or progressing cursor. Current cursor position is not taken
---into consideration either. To add an image as an element, use `ui.image()`.
---
---When drawing multiple images, consider combining all of them in a single atlas texture, it would improve performance.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(imageSource: ui.ImageSource, p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, mode: ui.ImageFit)
---@overload fun(imageSource: ui.ImageSource, p1: vec2, p2: vec2, mode: ui.ImageFit)
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 number|vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 number|vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 number|vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for bottom right corner. Default value: `vec2( 1, 1 )`.
---@param mode ui.ImageFit? @Stretch mode. Default value: `ui.ImageFit.Stretch`.
function ui.drawImage(imageSource, p1, p2, color, uv1, uv2, mode) end

---Draws an icon without moving cursor, universal function (great for creating customizable components). Icon can be:
---- An 24×24 icon ID set as is;
---- A country code for a small flag with padding to fit a square;
---- An 32×32 icon ID with “32:” prefix;
---- An 64×64 icon ID with “64:” prefix;
---- An 256×256 icon ID with “XL:” prefix;
---- A large rectangular flag with no padding with “XS:” prefix;
---- An emoticon with “em:” prefix;
---- An icon from an atlas: use “at:FILENAME\nX1,Y1,X2,Y2” format, where X… and Y… are UV coordinates (`ui.atlasIconID()` can help with generating those IDs);
---- A regular image: just pass a path as a string (also works with extra canvases, media elements and such).
---@param iconID ui.Icons
---@param p1 number|vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 number|vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawIcon(iconID, p1, p2, color) end

---Draw loading animation spinner. Actual shape might change in the future versions.
---@param p1 number|vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 number|vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the animation. Default value: `rgbm.colors.white`.
function ui.drawLoadingSpinner(p1, p2, color) end

---Draws an image with rounded corners on canvas without adding a new item or progressing cursor. Current cursor position is not taken
---into consideration either. To add an image as an element, use `ui.image()`.
---
---When drawing multiple images, consider combining all of them in a single atlas texture, it would improve performance.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(imageSource: ui.ImageSource, p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, rounding: number, corners: ui.CornerFlags)
---@overload fun(imageSource: ui.ImageSource, p1: vec2, p2: vec2, rounding: number, corners: ui.CornerFlags)
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 number|vec2 @Position of upper left corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 number|vec2 @Position of bottom right corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 number|vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for bottom right corner. Default value: `vec2( 1, 1 )`.
---@param rounding number? @Rounding radius in pixels. Default value: 1.
---@param corners ui.CornerFlags? @Corners to round. Default value: `ui.CornerFlags.All`.
function ui.drawImageRounded(imageSource, p1, p2, color, uv1, uv2, rounding, corners) end

---Draws a custom quad with a texture.
---
---Note: if you’re using asyncronous loading (see `ui.setAsynchronousImagesLoading()`) and want to make sure image is
---ready before drawing, use `ui.isImageReady()`. If image is not yet ready, transparent texture will be used instead.
---@overload fun(imageSource: ui.ImageSource, p1: vec2, p2: vec2, p3: vec2, p4: vec2, uv1: vec2, uv2: vec2, uv3: vec2, uv4: vec2)
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param p1 number|vec2 @Position of first corner relative to current working area (scriptable texture or IMGUI window).
---@param p2 number|vec2 @Position of second corner relative to current working area (scriptable texture or IMGUI window).
---@param p3 number|vec2 @Position of third corner relative to current working area (scriptable texture or IMGUI window).
---@param p4 number|vec2 @Position of fourth corner relative to current working area (scriptable texture or IMGUI window).
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 number|vec2? @Texture coordinates for first corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for second corner. Default value: `vec2( 1, 0 )`.
---@param uv3 number|vec2? @Texture coordinates for third corner. Default value: `vec2( 1, 1 )`.
---@param uv4 number|vec2? @Texture coordinates for fourth corner. Default value: `vec2( 0, 1 )`.
function ui.drawImageQuad(imageSource, p1, p2, p3, p4, color, uv1, uv2, uv3, uv4) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param p4 number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawQuadFilled(p1, p2, p3, p4, color) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param p4 number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawQuad(p1, p2, p3, p4, color) end

---Marks start of texture shading. All geometry drawn between this call and `ui.endTextureShade()` will have texture applied to it.
---
---Note: this feature only works with geometrical shapes, like quads, triangles, circles or things drawn with `ui.path…` functions.
---It can’t be applied to text, for example: text already uses its own texture.
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
function ui.beginTextureShade(imageSource) end

---Finishes texture shading. All geometry drawn between `ui.beginTextureShade()` and this call will have texture applied to it.
--- Note: this feature only works with geometrical shapes, like quads, triangles, circles or things drawn with `ui.path…` functions.
--- It can’t be applied to text, for example: text already uses its own texture.
--- @overload fun(p1: vec2, p2: vec2, clamp: boolean)
---@param p1 number|vec2 @Position within current working area that will get `uv1` texture coordinate.
---@param p2 number|vec2 @Position within current working area that will get `uv2` texture coordinate.
---@param uv1 number|vec2? @Texture coordinate for `p1` position (texture will be interpolated between linearly). Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinate for `p2` position (texture will be interpolated between linearly). Default value: `vec2( 1, 1 )`.
---@param clamp boolean? @If set to `true`, texture will be clamped to boundaries (if there are vertices outside). Otherwise, texture will be repeated. Default value: `true`.
function ui.endTextureShade(p1, p2, uv1, uv2, clamp) end

function ui.beginGradientShade() end

---@param p1 number|vec2
---@param p2 number|vec2
---@param col1 rgbm? @Default value: `rgbm.colors.white`.
---@param col2 rgbm? @Default value: `rgbm.colors.white`.
---@param useAlpha boolean? @Set to `true` to use alpha of gradient colors as a multiplier to existing alpha. Default value: `false`.
function ui.endGradientShade(p1, p2, col1, col2, useAlpha) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param intersectWithExisting boolean? @Default value: `true`.
function ui.pushClipRect(p1, p2, intersectWithExisting) end

---Pretty much fully disables clipping until next `ui.popClipRect()` call.
function ui.pushClipRectFullScreen() end

function ui.popClipRect() end

---@param p1 number|vec2
---@param p2 number|vec2
---@param color rgbm
---@param rounding number? @Default value: 0.
---@param roundingFlags ui.CornerFlags? @Default value: `ui.CornerFlags.All`.
---@param thickness number? @Default value: 1.
function ui.drawRect(p1, p2, color, rounding, roundingFlags, thickness) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param color rgbm
---@param rounding number? @Default value: 0.
---@param roundingFlags ui.CornerFlags? @Default value: `ui.CornerFlags.All`.
function ui.drawRectFilled(p1, p2, color, rounding, roundingFlags) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param colorTopLeft rgbm
---@param colorTopRight rgbm
---@param colorBottomRight rgbm
---@param colorBottomLeft rgbm
function ui.drawRectFilledMultiColor(p1, p2, colorTopLeft, colorTopRight, colorBottomRight, colorBottomLeft) end

---To quickly draw series of lines and arcs, add points with `ui.PathLineTo()` and `ui.pathArcTo()`, and then finish with `ui.pathStroke()`.
---To quickly draw horizontal or vertical lines, consider using  `ui.drawSimpleLine()` instead.
---@param p1 number|vec2
---@param p2 number|vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawLine(p1, p2, color, thickness) end

---Draws line without any antialiasing the fastest way, good for horizontal or vertical lines.
---@param p1 number|vec2
---@param p2 number|vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawSimpleLine(p1, p2, color, thickness) end

---To quickly draw series of lines and arcs, add points with `ui.PathLineTo()` and `ui.pathArcTo()`, and then finish with `ui.pathStroke()`.
---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param p4 number|vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawBezierCurve(p1, p2, p3, p4, color, thickness) end

---@param p1 number|vec2
---@param radius number
---@param color rgbm
---@param numSegments integer? @Default value: 12.
---@param thickness number? @Default value: 1.
function ui.drawCircle(p1, radius, color, numSegments, thickness) end

---@param p1 number|vec2
---@param radius number
---@param color rgbm
---@param numSegments integer? @Default value: 12.
function ui.drawCircleFilled(p1, radius, color, numSegments) end

---@param p1 number|vec2
---@param radius number|vec2
---@param color rgbm
---@param numSegments integer? @Default value: 12.
function ui.drawEllipseFilled(p1, radius, color, numSegments) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param color rgbm
---@param thickness number? @Default value: 1.
function ui.drawTriangle(p1, p2, p3, color, thickness) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.drawTriangleFilled(p1, p2, p3, color) end

---Draws text in given position without advancing cursor or anything like that. Faster option. Returns updated X position.
---@param text string
---@param pos number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@return number
function ui.drawText(text, pos, color) end

---Draws TTF text in given position without advancing cursor or anything like that. Faster option.
---@param text string
---@param fontSize number
---@param pos number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteDrawText(text, fontSize, pos, color) end

---Returns text color of the previous item. Might not work with some special items.
---@param alpha number? @Default value: 1.
---@return rgbm
function ui.itemTextColor(alpha) end

---Draws text in a given rect with clipping and optional alignment without advancing cursor or anything like that. Faster option.
---@param text string
---@param posMin number|vec2
---@param posMax number|vec2
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param alignment number|vec2? @Default value: `vec2(0, 0)`.
---@param ellipsis boolean? @Default value: `false`.
---@return number
function ui.drawTextClipped(text, posMin, posMax, color, alignment, ellipsis) end

---Draws TTF text in a given rect with clipping and optional alignment without advancing cursor or anything like that. Faster option.
---@param text string
---@param fontSize number
---@param posMin number|vec2
---@param posMax number|vec2
---@param horizontalAligment ui.Alignment? @`ui.Alignment.Start` for left, `ui.Alignment.Center` for middle, `ui.Alignment.End` for right. Default value: `ui.Alignment.Center`.
---@param verticalAlignment ui.Alignment? @`ui.Alignment.Start` for top, `ui.Alignment.Center` for middle, `ui.Alignment.End` for bottom. Default value: `ui.Alignment.Center`.
---@param allowWordWrapping boolean? @Default value: `false`.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteDrawTextClipped(text, fontSize, posMin, posMax, horizontalAligment, verticalAlignment, allowWordWrapping, color) end

---Clears current path. Not really needed in common scenarios: to start a new path, simply use any of
---path-adding functions such as `ui.pathLineTo()` or `ui.pathArcTo()`, to finish path and draw a shape use
---either `ui.pathFillConvex()` or `ui.pathStroke()` and it would clear path for the next shape automatically.
function ui.pathClear() end

---Adds a line segment to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param pos number|vec2
function ui.pathLineTo(pos) end

---Adds a line segment to current path, but only if position is different from current path point position.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param pos number|vec2
function ui.pathLineToMergeDuplicate(pos) end

---@param color rgbm
function ui.pathFillConvex(color) end

---@param color rgbm
---@param closed boolean? @Default value: `false`.
---@param thickness number? @Default value: 1.
function ui.pathStroke(color, closed, thickness) end

---Finishes path and draws it without antialiasing. Faster and with pixelated lines.
---@param color rgbm
---@param closed boolean? @Default value: `false`.
---@param thickness number? @Default value: 1.
function ui.pathSimpleStroke(color, closed, thickness) end

---Finishes path with an alternative antialiasing approach, good for 1 pixel wide lines often changing direction (like a graph).
---@param color rgbm
---@param closed boolean? @Default value: `false`.
---@param thickness number? @Default value: 1.
function ui.pathSmoothStroke(color, closed, thickness) end

---Adds an arc defined by its center, radius and starting and finishing angle to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center number|vec2
---@param radius number
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathArcTo(center, radius, angleFrom, angleTo, numSegments) end

---Adds “squished” arc to current path, like an arc of axis-aligned ellipse rather than an arc of a circle.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center number|vec2
---@param radius number|vec2
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathUnevenArcTo(center, radius, angleFrom, angleTo, numSegments) end

---Adds arc with radius at the end different from radius at the beginning.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param center number|vec2
---@param radiusFrom number
---@param radiusTo number
---@param angleFrom number
---@param angleTo number
---@param numSegments integer? @Default value: 10.
function ui.pathVariableArcTo(center, radiusFrom, radiusTo, angleFrom, angleTo, numSegments) end

---Uses precomputed angles for a 12 steps circle.
---@param center number|vec2
---@param radius number
---@param angleMinOf_12 integer
---@param angleMaxOf_12 integer
function ui.pathArcToFast(center, radius, angleMinOf_12, angleMaxOf_12) end

---Adds a bezier curve to current path.
---Don’t forget to finish shape with either `ui.pathFillConvex()` or `ui.pathStroke()`.
---@param p1 number|vec2
---@param p2 number|vec2
---@param p3 number|vec2
---@param numSegments integer? @Default value: 0.
function ui.pathBezierCurveTo(p1, p2, p3, numSegments) end

---@param rectMin number|vec2
---@param rectMax number|vec2
---@param rounding number? @Default value: 0.
---@param roundingCorners ui.CornerFlags? @Default value: `ui.CornerFlags.All`.
function ui.pathRect(rectMin, rectMax, rounding, roundingCorners) end

---Adds a rect to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 number|vec2
---@param p2 number|vec2
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowRectFilled(p1, p2, color, noClip) end

---Adds a circle to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 number|vec2
---@param radius number
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowCircleFilled(p1, radius, color, noClip) end

---Adds an ellipse to a glowing layer used for styling. All shapes in there are going to be blurred, so just drop something around active element to highlight it.
---@param p1 number|vec2
---@param radius number|vec2
---@param color rgbm
---@param noClip boolean? @Default value: `false`.
function ui.glowEllipseFilled(p1, radius, color, noClip) end

---Returns number of draw command in current IMGUI drawing context. Each command is its own draw call.
---@return integer
function ui.getDrawCommandsCount() end

function ui.beginTextureSaturationAdjustment() end

---@param value number
function ui.endTextureSaturationAdjustment(value) end

function ui.beginPremultipliedAlphaTexture() end

function ui.endPremultipliedAlphaTexture() end

function ui.beginOutline() end

---@param color rgbm
---@param scale number? @Default value: 1.
function ui.endOutline(color, scale) end

function ui.beginSharpening() end

---@param sharpening number? @Default value: 1.
function ui.endSharpening(sharpening) end

function ui.beginMIPBias() end

---@param bias number? @Default value: 0.
---@param useBicubic boolean? @Default value: `false`.
function ui.endMIPBias(bias, useBicubic) end

function ui.beginBlurring() end

---@param blurring number|vec2
function ui.endBlurring(blurring) end

function ui.beginSubtraction() end

function ui.endSubtraction() end

function ui.beginPointSampler() end

function ui.endPointSampler() end

function ui.beginTonemapping() end

---@param gamma number
---@param whitePoint number
---@param lcsAware boolean? @Set to `true` to automatically convert colors from AC HDR to LDR (set `whitePoint` to 0 to disable tonemapping step too). Default value: `false`.
function ui.endTonemapping(gamma, whitePoint, lcsAware) end

---Begins rotation. Call this function before drawing elements you need to rotate, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endRotation()`, would turn all new vertices by specified angle.
function ui.beginRotation() end

---Does actual rotation counterclockwise (or clockwise with negative values; also see note). Call this function after calling
---`ui.beginRotation()` and drawing elements you need to rotate. This version would automatically calculate pivot as middle point
---of drawn elements.
---
---Note: angle of rotation is offset by 90, kept this way for compatibility. Just subtract 90 from `deg` for it to act normal.
---@param deg number @Angle in degrees.
---@param offset number|vec2? @Optional offset. Default value: `vec2(0, 0)`.
function ui.endRotation(deg, offset) end

---Does actual rotation counterclockwise (or clockwise with negative values; also see note). Call this function after calling
---`ui.beginRotation()` and drawing elements you need to rotate. This version uses provided pivot to rotate things around.
---
---Note: angle of rotation is offset by 90, kept this way for compatibility. Just subtract 90 from `deg` for it to act normal.
---@param deg number @Angle in degrees.
---@param pivot number|vec2 @Point around which things would rotate, in window space.
---@param offset number|vec2? @Optional offset. Default value: `vec2(0, 0)`.
function ui.endPivotRotation(deg, pivot, offset) end

---Call this function first to apply any further transformations to subsequently drawn windows.
---
---Be careful with it! While it allows to transform windows around, it doesn’t work all that well when clipping
---gets involved, and it gets involved all the time.
---@param active boolean? @Default value: `true`.
function ui.applyTransformationToWindows(active) end

---Begins scaling. Call this function before drawing elements you need to scale, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endScale()`, would scale all new vertices by specified value.
function ui.beginScale() end

---Does actual scaling. Call this function after calling `ui.beginScale()` and drawing elements you need to scale. This
---version would automatically calculate pivot as middle point of drawn elements.
---@param scale number|vec2 @Scale, could be a 2-dimensional vector or a single number.
function ui.endScale(scale) end

---Does actual scaling. Call this function after calling `ui.beginScale()` and drawing elements you need to scale. This
---version uses provided pivot to scale things around.
---@param scale number|vec2 @Scale, could be a 2-dimensional vector or a single number.
---@param pivot number|vec2 @Point around which things would scale, in window space.
function ui.endPivotScale(scale, pivot) end

---Begins transformation. Call this function before drawing elements you need to scale, it would track current position in resulting
---vertex buffer and then, upon calling `ui.endTransformMatrix()`, would transform all new vertices by specified matrix.
function ui.beginTransformMatrix() end

---Does actual transformation. Call this function after calling `ui.beginTransformMatrix()` and drawing elements you need to scale.
---@param mat mat3x3 @Transformation matrix.
function ui.endTransformMatrix(mat) end

---@param count integer? @Default value: 1.
function ui.popStyleVar(count) end

---@param varID ui.StyleColor
---@param styleSet integer? @Leave at -1 to get the current color, or set to 0 to get the main style color. Default value: -1.
---@return rgbm
function ui.styleColor(varID, styleSet) end

---@param varID ui.StyleColor
---@param value rgbm
function ui.pushStyleColor(varID, value) end

---@param count integer? @Default value: 1.
function ui.popStyleColor(count) end

---@param fontType ui.Font
function ui.pushFont(fontType) end

function ui.popFont() end

function ui.setNextTextBold() end

---@param itemWidth number
function ui.pushItemWidth(itemWidth) end

function ui.popItemWidth() end

---@param wrapPos number
function ui.pushTextWrapPosition(wrapPos) end

function ui.popTextWrapPosition() end

---Checks if area is visible (not clipped). Works great if you need to make a list with many elements and don’t want to render elements
---outside of scroll (just make sure to offset cursor instead of drawing them using, of example, `ui.offsetCursorY(itemHeight)`).
---@param size number|vec2
---@return boolean
function ui.areaVisible(size) end

---Checks if area is visible (not clipped). Works great if you need to make a list with many elements and don’t want to render elements
---outside of scroll (just make sure to offset cursor instead of drawing them using, of example, `ui.offsetCursorY(itemHeight)`).
---@param height number
---@return boolean
function ui.areaVisibleY(height) end

---@param p1 number|vec2
---@param p2 number|vec2
---@return boolean
function ui.rectVisible(p1, p2) end

---@param p1 number|vec2
---@param p2 number|vec2
---@param clip boolean? @Default value: `true`.
---@return boolean
function ui.rectHovered(p1, p2, clip) end

---Make last item the default focused item of a window.
function ui.setItemDefaultFocus() end

---Focus keyboard on the next widget. Use positive `offset` to access sub components of a multiple component widget. Use `-1` to access previous widget.
---@param offset integer? @Default value: 0.
function ui.setKeyboardFocusHere(offset) end

---@return number
function ui.getScrollX() end

---@return number
function ui.getScrollY() end

---@return number
function ui.getScrollMaxX() end

---@return number
function ui.getScrollMaxY() end

---@param scrollX number
---@param relative boolean? @Default value: `false`.
---@param smooth boolean? @Default value: `true`.
function ui.setScrollX(scrollX, relative, smooth) end

---@param scrollY number
---@param relative boolean? @Default value: `false`.
---@param smooth boolean? @Default value: `true`.
function ui.setScrollY(scrollY, relative, smooth) end

---Adjust scrolling amount to make last item visible. When using to make a default/current item visible, consider using `ui.setItemDefaultFocus()` instead.
---@param centerXRatio number? @0 for top of last item, 0.5 for vertical center of last item, 1 for bottom of last item. Default value: 0.5.
function ui.setScrollHereX(centerXRatio) end

---Adjust scrolling amount to make last item visible. When using to make a default/current item visible, consider using `ui.setItemDefaultFocus()` instead.
---@param centerYRatio number? @0 for top of last item, 0.5 for vertical center of last item, 1 for bottom of last item. Default value: 0.5.
function ui.setScrollHereY(centerYRatio) end

---Is current window hovered (and typically not blocked by a popup/modal).
---@param flags ui.HoveredFlags? @Default value: `ui.HoveredFlags.None`.
---@return boolean
function ui.windowHovered(flags) end

---Is current window focused (or its root/child, depending on flags).
---@param flags ui.FocusedFlags? @Default value: `ui.FocusedFlags.None`.
---@return boolean
function ui.windowFocused(flags) end

---Is current (root) window being resized by its border.
---@return boolean
function ui.windowResizing() end

---Is current window being scrolled by one of its scroll bars (also applies to thin scrollbars).
---@return boolean
function ui.windowScrolling() end

---Is current window pinned.
---@return boolean
function ui.windowPinned() end

---Returns `true` if mouse currently is either used by one of IMGUI controls (like dragging something) or if it hovers any of windows. If that’s the case and
---your script reacts to clicks on the scene, for example, it’s better to skip that frame.
---@return boolean
function ui.mouseBusy() end

---Did mouse button clicked (went from not down to down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseClicked(mouseButton) end

---Did mouse button double-clicked. A double-click returns `false` in `ui.mouseClicked()`.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseDoubleClicked(mouseButton) end

---Did mouse button released (went from down to not down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseReleased(mouseButton) end

---Is mouse button held.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.mouseDown(mouseButton) end

---Returns mouse cursor position on a screen. To get mouse position within current window, use `ui.mouseLocalPos()`.
---@return vec2 @Mouse cursor position in pixels, or (-1, -1) if mouse is not available.
function ui.mousePos() end

---Returns mouse cursor position relative to current app/window. To get mouse position within screen window, use `ui.mousePos()`.
---@return vec2 @Mouse cursor position in pixels, or (-1, -1) if mouse is not available.
function ui.mouseLocalPos() end

---Get upper-left bounding rectangle of the last item (window space).
---@return vec2
function ui.itemRectMin() end

---Get lower-right bounding rectangle of the last item (window space).
---@return vec2
function ui.itemRectMax() end

---Time since last frame of current UI context.
---@return number
function ui.deltaTime() end

---Get size of last item.
---@return vec2
function ui.itemRectSize() end

---Returns mouse cursor position delta comparing to previous frame.
---@return vec2
function ui.mouseDelta() end

---Returns mouse wheel movement (1 unit scrolls 5 text lines).
---@return number
function ui.mouseWheel() end

---Returns position of current window in screen-space/texture-space (`ui.beginChild()` returns a new window).
---@return vec2
function ui.windowPos() end

---Returns size of current window.
---@return vec2
function ui.windowSize() end

---Size of contents/scrollable client area (calculated from the extents reach of the cursor) from previous frame. Does not include window decoration or window padding.
---@return vec2
function ui.windowContentSize() end

---Size of contents/scrollable client area explicitly request by the user via `ui.setNextWindowContentSize()`.
---@return vec2
function ui.windowContentExplicitSize() end

---Set next window position.
---@param pos number|vec2
---@param pivot number|vec2|nil @Default value: `nil`.
function ui.setNextWindowPosition(pos, pivot) end

---Set next window position.
---@param size number|vec2
function ui.setNextWindowSize(size) end

---Set next window position.
---@param sizeMin number|vec2|nil @Default value: `nil`.
---@param sizeMax number|vec2|nil @Default value: `nil`.
function ui.setNextWindowSizeConstraints(sizeMin, sizeMax) end

---Set next window content size (scrollable client area, which enforce the range of scrollbars). Not including window decorations (title bar, menu bar, etc.) nor WindowPadding. Set an axis to 0 to leave it automatic. Call before `ui.beginChild()`.
---@param size number|vec2
function ui.setNextWindowContentSize(size) end

---Is key being held.
---@param keyIndex ui.KeyIndex
---@return boolean
function ui.keyboardButtonDown(keyIndex) end

---Was key pressed (went from `not down` to `down`). If `with_repeat` is true, uses configured repeat delay and rate.
---@param keyIndex ui.KeyIndex
---@param withRepeat boolean? @Default value: `true`.
---@return boolean
function ui.keyboardButtonPressed(keyIndex, withRepeat) end

---Was key released (went from `down` to `not down`).
---@param keyIndex ui.KeyIndex
---@return boolean
function ui.keyboardButtonReleased(keyIndex) end

---Simulate key being pressed (affects current IMGUI context only).
---@param keyIndex ui.KeyIndex
---@param down boolean? @Default value: `true`.
function ui.setKeyboardButtonDown(keyIndex, down) end

---Add input character for currently active text input.
---@param keyIndex ui.KeyIndex
function ui.addInputCharacter(keyIndex) end

---Clear input character for currently active text input.
function ui.clearInputCharacters() end

---Provides access to few buttons with certain UI roles.
---@param keyCode ui.Key
---@return boolean
function ui.keyPressed(keyCode) end

---Map a button with certain UI role to regular key index.
---@param keyCode ui.Key
---@return ui.KeyIndex
function ui.getKeyIndex(keyCode) end

---Returns true if Ctrl is pressed, but Shift, Alt and Super/Win are depressed.
---@return boolean
function ui.hotkeyCtrl() end

---Returns true if Alt is pressed, but Ctrl, Shift and Super/Win are depressed.
---@return boolean
function ui.hotkeyAlt() end

---Returns true if Shift is pressed, but Ctrl, Alt and Super/Win are depressed.
---@return boolean
function ui.hotkeyShift() end

---Adds modifiers to how IMGUI renders textures (including icons, any UI element, all texts, so use carefully and don’t forget
---to reset values to default with `ui.resetShadingOffset()` or by passing default arguments or no arguments here). Modifiers
---act like simple multiply-and-add adjustment, first value in pair acts like multiplier, second acts like addition (or subtraction)
---value. First pair affects RGB channels, second is for alpha. There are also special combinations:
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = 0: use texture RGB for color (multiplied by shape color) and green texture channel for alpha;
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = 1: use shape color for color and red texture channel for alpha;
---- `brightness` = 0, `offset` = 0, `alphaMult` = 0, `alphaOffset` = -1: use shape color for color and inverse of red texture channel for alpha.
---@param brightness number? @Default value: 1.
---@param offset number? @Default value: 0.
---@param alphaMult number? @Default value: 1.
---@param alphaOffset number? @Default value: 0.
function ui.setShadingOffset(brightness, offset, alphaMult, alphaOffset) end

---Resets texture sampling modifiers.
function ui.resetShadingOffset() end

---Draw text using AC font (which should previously set with `ui.pushACFont()`.
---@param text string
---@param letter number|vec2
---@param marginOffset number? @Default value: 0.
---@param color rgbm? @Default value: `rgbm.colors.white`.
---@param lineSpace number? @Default value: 0.
---@param monospace boolean? @Default value: `true`.
function ui.acText(text, letter, marginOffset, color, lineSpace, monospace) end

---Calculate size of text using AC font (which should previously set with `ui.pushACFont()`.
---@param text string
---@param letter number|vec2
---@param marginOffset number? @Default value: 0.
---@param lineSpace number? @Default value: 0.
---@param monospace boolean? @Default value: `true`.
---@return vec2
function ui.calculateACTextSize(text, letter, marginOffset, lineSpace, monospace) end

---Pushes new AC font on stack. After you finished using it, don’t forget to use `ui.popACFont()`. Fonts will be search for
---in “content/fonts”, as well as in script’s folder.
---@param name string
function ui.pushACFont(name) end

---Pops previously pushed font from stack. Note: font will not be unloaded or anything like that, feel free to use it as much as you need.
function ui.popACFont() end

---Adds new TTF font to the stack to be used for drawing DWrite text later. Fonts are taken from “content/fonts” and “extension/fonts”, but scripts
---can also use their own TTF files. To do so, use `'Font Name:path/to/file.ttf'` or `'Font Name:path/to/directory'`, path can be absolute, relative
---to script folder or AC root folder. Font name can also use styling attributes, such as `Weight=Thin`, `Style=Italic` or `Stretch=Condensed`, listed
---at the end after a “;” like so:
---```
---ui.pushDWriteFont('My Font:myfont.ttf;Weight=Bold;Style=Oblique;Stretch=Expanded')
---```
---To make things simpler, you can also use `ui.DWriteFont` helper, it provides nice methods to set attributes.
---
---If you need to use a standard system font, set “@System” as font path: it would use faster working system fonts collection.
---
---Update: since CSP 0.1.80 it is now possible to use a relative path to a TTF file directly. In this case, first font will be used. Note however that
---if you want to use extended options and such, you’ll still need to use “<font name>:<file name>;<options>” format.
---@param name string|ui.DWriteFont? @Default value: 'Segoe UI'.
function ui.pushDWriteFont(name) end

---Removes latest TTF font from the stack.
function ui.popDWriteFont() end

---Calculate size of text using current IMGUI font.
---@param text string
---@param wrapWidth number? @Set to positive value of pixels to enable text wrapping. Default value: -1.
---@return vec2
function ui.measureText(text, wrapWidth) end

---Calculate size of text using TTF font. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param wrapWidth number? @Set to positive value of pixels to enable text wrapping. Default value: -1.
---@return vec2
function ui.measureDWriteText(text, fontSize, wrapWidth) end

---Draws some text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteText(text, fontSize, color) end

---Draws some hyperlink using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param hyperlinkColor rgbm? @Default value: `rgbm(0, 0.5, 1, 1)`.
---@return boolean
function ui.dwriteTextHyperlink(text, fontSize, hyperlinkColor) end

---Draws wrapped text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteTextWrapped(text, fontSize, color) end

---Draws some aligned text using TTF font with DirectWrite library. Make sure to set a font first using `ui.pushDWriteFont()`.
---@param text string
---@param fontSize number? @Default value: 14.
---@param horizontalAligment ui.Alignment? @`ui.Alignment.Start` for left, `ui.Alignment.Center` for middle, `ui.Alignment.End` for right. Default value: `ui.Alignment.Center`.
---@param verticalAlignment ui.Alignment? @`ui.Alignment.Start` for top, `ui.Alignment.Center` for middle, `ui.Alignment.End` for bottom. Default value: `ui.Alignment.Center`.
---@param size number|vec2? @Set to 0 to use remaining space, set to negative value to use it as margin (positive) from remaining space. Default value: `vec2(0, 0)`.
---@param allowWordWrapping boolean? @Default value: `false`.
---@param color rgbm? @Default value: `rgbm.colors.white`.
function ui.dwriteTextAligned(text, fontSize, horizontalAligment, verticalAlignment, size, allowWordWrapping, color) end

function ui.popID() end

---@return integer
function ui.getLastID() end

---@return integer
function ui.getActiveID() end

---@return integer
function ui.getFocusID() end

---@return integer
function ui.getHoveredID() end

function ui.clearActiveID() end

---@param id integer
function ui.activateItem(id) end

---Returns a number associated with current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param defaultValue number? @Default value: 0.
---@return number
function ui.loadStoredNumber(id, defaultValue) end

---Returns a boolean value associated with current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param defaultValue boolean? @Default value: `false`.
---@return boolean
function ui.loadStoredBool(id, defaultValue) end

---Stores a number in current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param value number? @Default value: 0.
function ui.storeNumber(id, value) end

---Stores a boolean value in current context (taking into account `ui.pushID()` calls). Use it to store rarely updating
---UI data, such as, for example, opened tab.
---@param id integer? @Default value: 0.
---@param value boolean? @Default value: `false`.
function ui.storeBool(id, value) end

function ui.nextColumn() end

---@param columnIndex integer
---@param width number
function ui.setColumnWidth(columnIndex, width) end

---@param columnIndex integer
---@return number
function ui.getColumnWidth(columnIndex) end

---Can be used to draw something spanning entire table.
function ui.pushColumnsBackground() end

function ui.popColumnsBackground() end

---Draws a column label with optional ordering arrow and advances to the next column.
---@param title string
---@param orderDirection integer @1 for arrow pointing down, -1 for arrow pointing up, 0 for no arrow.
---@param alignRight boolean? @Default value: `false`.
---@return boolean @Returns `true` if header was clicked.
function ui.columnSortingHeader(title, orderDirection, alignRight) end

---Copyable text.
---@param label string
function ui.copyable(label) end

function ui.pushDisabled() end

function ui.popDisabled() end

---Simple button.
--- @overload fun(label: string, flags: ui.ButtonFlags)
---@param label string
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@param flags ui.ButtonFlags? @Default value: `ui.ButtonFlags.None`.
---@return boolean
function ui.button(label, size, flags) end

---Button with Modern UI style to use in modal dialogs.
---@param label string
---@param size number|vec2
---@param flags ui.ButtonFlags? @Default value: `ui.ButtonFlags.None`.
---@param icon string|nil @Default value: `nil`.
---@param iconSize number? @Default value: 16.
---@param iconBg string|nil @Default value: `nil`.
---@return boolean
function ui.modernButton(label, size, flags, icon, iconSize, iconBg) end

---Very experimental. Better to avoid using, or at least to call first.
---@param accentColor rgbm
---@param brightTheme boolean? @Default value: `false`.
---@param roundedCorners boolean? @Default value: `false`.
---@param bgAlpha number? @Default value: 0.72.
function ui.configureStyle(accentColor, brightTheme, roundedCorners, bgAlpha) end

---Button without frame padding to easily embed within text.
---@param label string
---@return boolean
function ui.smallButton(label) end

---Button behavior without the visuals, frequently useful to build custom behaviors using the public API (along with `ui.itemActive()`, `ui.itemHovered()`, etc.)
---@param label string
---@param size number|vec2
---@param flags ui.ButtonFlags? @Default value: `ui.ButtonFlags.None`.
---@return boolean
function ui.invisibleButton(label, size, flags) end

---Add a dummy item of given size. unlike `ui.invisibleButton()`, dummy won’t take the mouse click or be navigable into.
---@param size number|vec2
function ui.dummy(size) end

---Returns `true` during scrolling.
---@param appearOnHover boolean? @Default value: `false`.
---@return boolean
function ui.thinScrollbarBegin(appearOnHover) end

function ui.thinScrollbarEnd() end

---Square button with an arrow shape.
---@param strID string
---@param dir ui.Direction
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@param flags ui.ButtonFlags? @Default value: `ui.ButtonFlags.None`.
---@return boolean
function ui.arrowButton(strID, dir, size, flags) end

---Draw a small circle and keep the cursor on the same line.
function ui.bullet() end

---Separator, generally horizontal. Inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
function ui.separator() end

---Checkbox. Pass `refbool` for current value, or just pass a regular `boolean` and switch state yourself if
---function would return `true`.
---```
---if ui.checkbox('My checkbox', myFlag) then
---  myFlag = not myFlag
---end
---```
---@param label string
---@param checked boolean|refbool|nil
---@return boolean @Returns `true` if checkbox was clicked.
function ui.checkbox(label, checked) end

---@param label string
---@param checked boolean|refbool|nil
---@return boolean
function ui.radioButton(label, checked) end

---@param fraction number
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@param overlay string|nil @Default value: `nil`.
function ui.progressBar(fraction, size, overlay) end

---Mark window resize handle to show some content is hidden due to window size.
---@param active boolean? @Default value: `true`.
function ui.setExtraContentMark(active) end

---Let IMGUI know about some extra content you’re drawing in the title bar to avoid potential conflicts. Pass `math.nan` (or `math.huge`) as first parameter to disable.
---@param marginLeft number? @Default value: 80.
---@param marginRight number? @Default value: 44.
function ui.setTitleBarContentHint(marginLeft, marginRight) end

---Add notification counter (small red circle with a bit of a glow and an optional digit in it).
---@param counter integer? @By default doesn’t show any number. If above 9, “…” will be shown. Default value: -1.
---@param pos number|vec2|nil @If not set, notification counter will be added to the previous element. Default value: `nil`.
---@param noclip boolean? @Set to `true` if your counter ends up clipped. Default value: `false`.
function ui.notificationCounter(counter, pos, noclip) end

---@param width number
function ui.setNextItemWidth(width) end

---@param iconID ui.Icons
---@param color rgbm|nil @If not set, text color will be used. Default value: `nil`.
---@param relativePadding number? @Relative padding from 0 to 1. Default value: 0.
function ui.setNextItemIcon(iconID, color, relativePadding) end

---It’s safer to use `ui.combo()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param previewValue string
---@param flags ui.ComboFlags? @Default value: `ui.ComboFlags.None`.
---@return boolean
function ui.beginCombo(label, previewValue, flags) end

---@param label string
---@param selected boolean|refbool|nil
---@param flags ui.SelectableFlags? @Default value: `ui.SelectableFlags.None`.
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@return boolean
function ui.selectable(label, selected, flags, size) end

function ui.endCombo() end

---It’s safer to use `ui.childWindow()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
--- Note: you have to call `ui.endChild()` even if `ui.beginChild()` returns `false` (don’t waste time drawing content in that case though).
---@param id string
---@param size number|vec2? @Default value: `vec2(0, 0)`.
---@param border boolean? @Default value: `false`.
---@param flags ui.WindowFlags? @Default value: `ui.WindowFlags.NoBackground`.
---@return boolean
function ui.beginChild(id, size, border, flags) end

function ui.endChild() end

---For use in `ui.onDriverContextMenu()`.
---@param label string
---@param iconID ui.Icons|nil @Default value: `nil`.
---@param selected boolean? @Default value: `false`.
---@param flags ui.SelectableFlags? @Default value: `ui.SelectableFlags.None`.
---@param childItem boolean? @Increases padding. Default value: `false`.
---@return boolean
function ui.modernMenuItem(label, iconID, selected, flags, childItem) end

---It’s safer to use `ui.tabBar()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param id string
---@param flags ui.TabBarFlags? @Default value: `ui.TabBarFlags.None`.
---@return boolean
function ui.beginTabBar(id, flags) end

function ui.endTabBar() end

---It’s safer to use `ui.tabBarItem()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param flags ui.TabItemFlags? @Default value: `ui.TabItemFlags.None`.
---@param opened boolean|refbool|nil|nil @Default value: `nil`.
---@return boolean
function ui.beginTabItem(label, flags, opened) end

function ui.endTabItem() end

---It’s safer to use `ui.treeNode()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param label string
---@param flags ui.TreeNodeFlags? @Default value: `ui.TreeNodeFlags.Framed`.
---@return boolean
function ui.beginTreeNode(label, flags) end

function ui.endTreeNode() end

---It’s safer to use `ui.itemPopup()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason.
---@param id string
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Right`.
---@return boolean
function ui.beginPopupContextItem(id, mouseButton) end

---@param label string
---@param selected boolean? @Default value: `false`.
---@param flags ui.SelectableFlags? @Default value: `ui.SelectableFlags.None`.
---@param shortcut string|nil @Default value: `nil`.
---@return boolean
function ui.menuItem(label, selected, flags, shortcut) end

---@param id string
---@param selected boolean? @Default value: `false`.
---@param enabled boolean? @Default value: `true`.
---@param shortcut string|nil @Default value: `nil`.
---@return boolean
function ui.beginMenu(id, selected, enabled, shortcut) end

function ui.endMenu() end

---Base IMGUI popup model for something more custom.
---@param id string
function ui.openPopup(id) end

---Close currently drawn popup.
function ui.closePopup() end

---@param id string
---@param flags ui.WindowFlags? @Default value: `ui.WindowFlags.None`.
---@param padding number|vec2|nil @Default value: `nil`.
---@param opened boolean|refbool|nil|nil @Default value: `nil`.
---@return boolean
function ui.beginPopup(id, flags, padding, opened) end

function ui.endPopup() end

---It’s safer to use `ui.tooltip()`: a wrapper that would ensure UI wouldn’t break even if Lua script would crash midway for any reason. If you
---just need to render some text in a tooltip, use `ui.setTooltip()` instead.
---@param padding number|vec2? @Default value: `vec2(20, 8)`.
function ui.beginTooltip(padding) end

function ui.endTooltip() end

---@param text string
function ui.header(text) end

---@param text string
function ui.bulletText(text) end

---@param tooltip string
function ui.setTooltip(tooltip) end

---Is the last item hovered and usable, aka not blocked by a popup, etc.
---@param flags ui.HoveredFlags? @Default value: `ui.HoveredFlags.None`.
---@return boolean
function ui.itemHovered(flags) end

---Is the last item clicked (e.g. button/node just clicked on), same as `ui.mouseClicked(mouseButton) and ui.itemHovered()`
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@param buttonBehaviour boolean? @If `true`, triggers on release, but only if click position was also within item. Default value: `false`.
---@return boolean
function ui.itemClicked(mouseButton, buttonBehaviour) end

---Is the last item active (e.g. button being held, text field being edited). This will continuously return true while holding mouse button on an item. Items that don’t interact will always return false)
---@return boolean
function ui.itemActive() end

---Is the last item focused for keyboard/gamepad navigation.
---@return boolean
function ui.itemFocused() end

---Is the last item visible (items may be out of sight because of clipping/scrolling).
---@return boolean
function ui.itemVisible() end

---Did the last item modify its underlying value this frame, or was pressed. This is generally the same as the return value of many widgets.
---@return boolean
function ui.itemEdited() end

---Was the last item just made active (item was previously inactive).
---@return boolean
function ui.itemActivated() end

---Was the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that requires continuous editing.
---@return boolean
function ui.itemDeactivated() end

---Was the last item just made inactive and made a value change when it was active (e.g. slider moved). Useful for Undo/Redo patterns with widgets that requires continuous editing. Note: you may get false positives (some widgets such as combo/selectable will return true even when clicking an already selected item).
---@return boolean
function ui.itemDeactivatedAfterEdit() end

---Is any item hovered.
---@return boolean
function ui.anyItemHovered() end

---Is any item active.
---@return boolean
function ui.anyItemActive() end

---Is any item focused.
---@return boolean
function ui.anyItemFocused() end

---Get upper-left bounding rectangle of the last item (screen space).
---@deprecated
---@return vec2
function ui.getItemRectMin() end

---Get lower-right bounding rectangle of the last item (screen space).
---@deprecated
---@return vec2
function ui.getItemRectMax() end

---Get size of last item.
---@deprecated
---@return vec2
function ui.getItemRectSize() end

---Allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
function ui.setItemAllowOverlap() end

---Was the last item selection (`ui.selectable()`, `ui.treeNode()`, etc.) toggled
---@return boolean
function ui.itemToggledSelection() end

---Unlike `ui.drawImage()`, this one adds an image as an item to current cursor position and moves the cursor. Also allows
---to interact with an image with functions like `ui.itemHovered()`. You can do the same with `ui.drawImage()`, just use
---`ui.getCursor()` for `p1`, `ui.getCursor() + size` for `p2` and `ui.dummy()` for interaction.
---@overload fun(imageSource: ui.ImageSource, size: vec2, color: rgbm, mode: ui.ImageFit)
---@overload fun(imageSource: ui.ImageSource, size: vec2, mode: ui.ImageFit)
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param size number|vec2 @Size of resulting image in pixels.
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param borderColor rgbm|nil @Optional 1-pixel wide border around image. Default value: `nil`.
---@param uv1 number|vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for bottom right corner. Default value: `vec2( 1, 1 )`.
---@param mode ui.ImageFit? @Stretch mode. Default value: `ui.ImageFit.Stretch`.
function ui.image(imageSource, size, color, borderColor, uv1, uv2, mode) end

---Adds a button with an image on it. If image is missing or loading (if it’s remote or asyncronous loading is enabled),
---button would still appear, but without an image.
---
---Note: if image source doesn’t have “##” in it, `color` and `bgColor` are swapped. For compatibility reason things are left as is, please
---use `ui.iconButton()` instead.
---@deprecated
---@overload fun(imageSource: ui.ImageSource, size: vec2, bgColor: rgbm, framePadding: number, mode: ui.ImageFit)
---@overload fun(imageSource: ui.ImageSource, size: vec2, framePadding: number, mode: ui.ImageFit)
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted. Use `##…` postfix for unique ID if you have multiple buttons with the same filename (or, even better, use `ui.pushID()/ui.popID()`.
---@param size number|vec2 @Size of resulting image in pixels.
---@param bgColor rgbm|nil @Optional background color for the image (transparent if not set). Default value: `nil`.
---@param color rgbm? @Tint of the image, with white it would be drawn as it is. Default value: `rgbm.colors.white`.
---@param uv1 number|vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for bottom right corner. Default value: `vec2( 1, 1 )`.
---@param framePadding number? @If -1, uses frame padding from style. If 0, there is no padding. If above zero, it’s used as actual padding value. Default value: -1.
---@param mode ui.ImageFit? @Stretch mode. Default value: `ui.ImageFit.Stretch`.
---@return boolean
function ui.imageButton(imageSource, size, bgColor, color, uv1, uv2, framePadding, mode) end

---Adds a button with an image on it. If image is missing or loading (if it’s remote or asyncronous loading is enabled),
---button would still appear, but without an image.
---@overload fun(iconID: ui.ImageSource, size: vec2, color: rgbm, framePadding: number?, keepAspectRatio: boolean?, flags: ui.ButtonFlags?)
---@overload fun(iconID: ui.ImageSource, size: vec2, framePadding: number?, keepAspectRatio: boolean?, flags: ui.ButtonFlags?)
---@param iconID ui.Icons @Icon or path to the image, absolute or relative to script folder or AC root. URLs are also accepted. Use `##…` postfix for unique ID if you have multiple buttons with the same filename (or, even better, use `ui.pushID()/ui.popID()`.
---@param size number|vec2|nil @Size of resulting image in pixels. If not set, default button size will be used. Default value: `nil`.
---@param color rgbm|nil @Tint of the image, with white it would be drawn as it is (text color if not set). Default value: `nil`.
---@param bgColor rgbm|nil @Optional background color for the image (transparent if not set). Default value: `nil`.
---@param framePadding number? @Padding (does not affect button size). If negative, default frame padding from current style is used. Use 0 with defined background color (like `rgbm.colors.transparent`) and `keepAspectRatio` set to `false` to hide the frame and only show the image. Default value: -1.
---@param uv1 number|vec2? @Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.
---@param uv2 number|vec2? @Texture coordinates for bottom right corner. Default value: `vec2( 1, 1 )`.
---@param keepAspectRatio boolean? @Set to `true` to stretch image to fit given size, making sure it would not get distorted. Default value: `true`.
---@param flags ui.ButtonFlags? @Default value: `ui.ButtonFlags.None`.
---@return boolean
function ui.iconButton(iconID, size, color, bgColor, framePadding, uv1, uv2, keepAspectRatio, flags) end

---Returns `true`, if an image is ready to be drawn. If image was not used before, starts its loading.
---
---Note: By default images from local files are loaded syncronously, use `ui.setAsynchronousImagesLoading(true)` function to change this behaviour.
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@return boolean
function ui.isImageReady(imageSource) end

---Activates synchronous loading for local images. By default local images are loaded syncronously, but by calling this function
---and passing `true` to it, they would start to load asyncronously from there, reducing possible stutters. Any remote images are loaded
---asyncronously no matter what.
---
---Note: for now, any image ever loaded would remain in RAM and video memory. Try not to load way too many things.
---@param value boolean? @Default value: `true`.
function ui.setAsynchronousImagesLoading(value) end

---Forces CSP to ignore all those HTTP headers and reuse cached versions of remote images.
---@param value boolean? @Default value: `true`.
function ui.setForcedImagesCaching(value) end

---Width of item given pushed settings and current cursor position. NOT necessarily the width of last item unlike most 'Item' functions.
---@return number
function ui.calcItemWidth() end

---Allow focusing using Tab/Shift+Tab, enabled by default but you can disable it for certain widgets.
---@param allowKeyboardFocus boolean|`true`|`false`
function ui.pushAllowKeyboardFocus(allowKeyboardFocus) end

---Removes last `ui.pushAllowKeyboardFocus()` modification.
function ui.popAllowKeyboardFocus() end

---In repeat mode, button functions return repeated true in a typematic manner.
---Note: you can call `ui.itemActive()` after any button to tell if the button is held in the current frame.
---@param repeatValue boolean|`true`|`false`
function ui.pushButtonRepeat(repeatValue) end

---Removes last `ui.pushButtonRepeat()` modification
function ui.popButtonRepeat() end

---Move content position toward the right.
---@param indentW number? @If 0, indent spacing from style will be used. Default value: 0.0.
function ui.indent(indentW) end

---Move content position back to the left.
---@param indentW number? @If 0, indent spacing from style will be used. Default value: 0.0.
function ui.unindent(indentW) end

---Initial cursor position in window coordinates.
---@return vec2
function ui.cursorStartPos() end

---Cursor position in absolute screen coordinates (within AC window or its UI in VR, but also affected by UI scale).
---@return vec2
function ui.cursorScreenPos() end

---Cursor position in absolute screen coordinates (within AC window or its UI in VR, but also affected by UI scale).
---@param pos number|vec2
function ui.setCursorScreenPos(pos) end

---Vertically align upcoming text baseline to frame padding so that it will align properly to regularly framed items (call if you have text on a line before a framed item).
function ui.alignTextToFramePadding() end

---Pretty much just font size.
---@return number
function ui.textLineHeight() end

---Returns font size and vertical item spacing (distance in pixels between 2 consecutive lines of text).
---@return number
function ui.textLineHeightWithSpacing() end

---Returns font size and frame padding.
---@return number
function ui.frameHeight() end

---Returns font size, frame padding and vertical item spacing (distance in pixels between 2 consecutive lines of framed widgets).
---@return number
function ui.frameHeightWithSpacing() end

---Get current font size (height in pixels) of current font with current scale applied.
---@return number
function ui.fontSize() end

---Get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API.
---@return vec2
function ui.fontWhitePixelUV() end

---Pushes new alpha value taking into account current style alpha, good for fading elements in case any parent elements could also fade.
---To revert change, use `ui.popStyleVar()`.
---@param alpha number
function ui.pushStyleVarAlpha(alpha) end

---Experimental.
---@param vertical boolean? @Default value: `false`.
---@param alignment number? @Default value: 0.5.
function ui.pushAlignment(vertical, alignment) end

---Experimental.
function ui.popAlignment() end

---Adjust scrolling amount to make given position visible. Generally `ui.cursorStartPos() + offset` to compute a valid position.
---@param localX number
---@param centerXRatio number? @Default value: 0.5.
function ui.setScrollFromPosX(localX, centerXRatio) end

---Adjust scrolling amount to make given position visible. Generally `ui.cursorStartPos() + offset` to compute a valid position.
---@param localY number
---@param centerYRatio number? @Default value: 0.5.
function ui.setScrollFromPosY(localY, centerYRatio) end

---Get current window title.
---@return string?
function ui.windowTitle() end

---Stop frosted effect of semi-transparent IMGUI surfaces for a single frame.
---@param currentWindow boolean? @Set to `true` to make it affect this root window only (if you’re within HUD callback, it’ll affect the entire callback). Any window without frosty effect is drawn first, before anything with frosty effect. Option is added in 0.3.0. Default value: `false`.
function ui.forceSimplifiedComposition(currentWindow) end

---Allow AC to see mouse events for a frame, even if IMGUI is handling them.
function ui.passthroughIMGUI() end

---Get current window width (shortcut for `ui.windowSize().x`)
---@return number
function ui.windowWidth() end

---Get current window height (shortcut for `ui.windowSize().y`)
---@return number
function ui.windowHeight() end

---Get width of title of the current window. Use it if you want to draw something next to the title, as the width might change from version to version of CSP. Added in 0.3.0-preview170.
---@return number
function ui.windowTitleWidth() end

---If current window just been opened.
---@return boolean
function ui.isWindowAppearing() end

---Is current window collapsed.
---@return boolean
function ui.isWindowCollapsed() end

---Is current window focused (or its root/child, depending on flags).
---@deprecated Use `ui.windowFocused()` instead.
---@param flags ui.FocusedFlags? @Default value: `ui.FocusedFlags.None`.
---@return boolean
function ui.isWindowFocused(flags) end

---Uses provided repeat rate/delay. Return a count, most often 0 or 1, but might be > 1 if RepeatRate is small enough that DeltaTime > RepeatRate
---@param keyIndex ui.KeyIndex
---@param repeatDelay number
---@param rate number
---@return integer
function ui.keyPressedAmount(keyIndex, repeatDelay, rate) end

---Is any mouse button held.
---@return boolean
function ui.isAnyMouseDown() end

---Did mouse button released (went from down to not down).
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@return boolean
function ui.isMouseReleased(mouseButton) end

---Is mouse dragging. If `lockThreshold` < -1, uses io.MouseDraggingThreshold
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@param lockThreshold number? @Default value: -1.0.
---@return boolean
function ui.isMouseDragging(mouseButton, lockThreshold) end

---Retrieve backup of mouse position at the time of opening popup we have `ui.beginPopup()` into
---@return vec2
function ui.mousePosOnOpeningCurrentPopup() end

---Return the delta from the initial clicking position while the mouse button is pressed or was just released. This is locked and
---return 0 until the mouse moves past a distance threshold at least once.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
---@param lockThreshold number? @If below zero, default mouse dragging threshold will be used. Default value: -1.0.
---@return vec2
function ui.mouseDragDelta(mouseButton, lockThreshold) end

---Resets mouse drag delta.
---@param mouseButton ui.MouseButton? @Default value: `ui.MouseButton.Left`.
function ui.resetMouseDragDelta(mouseButton) end

---Get cursor type. Cursor type resets in with each new frame
---@return ui.MouseCursor
function ui.mouseCursor() end

---Set cursor type.
---@param type ui.MouseCursor
function ui.setMouseCursor(type) end

---Stops rest of Assetto Corsa from responding to mouse events, also sets `getUI().wantCaptureMouse` flag. Note:
--- if you writing a script reacting to general mouse events, consider checking that flag to make sure IMGUI doesn’t have mouse captured currently.
---@param wantCaptureMouseValue boolean? @Default value: `true`.
function ui.captureMouse(wantCaptureMouseValue) end

---Get text that is currently in clipboard.
---@return string
function ui.getClipboardText() end

---Set new text to clipboard.
---Added by mistake, use `ac.setClipboardText()`.
---@deprecated
---@param text string
function ui.setClipboardText(text) end

---Get global IMGUI time. Incremented by `dt` every frame.
---@return number
function ui.time() end

---Get global IMGUI frame count. Incremented by 1 every frame.
---@return integer
function ui.frameCount() end

---Sets a callback which will be called when main UI IMGUI render is complete (currenly works for window calls of Lua apps).
---@param callback fun()
---@return ac.Disposable
function ui.onUIFinale(callback) end

---Sets a callback for drawing chat UI which will be called first. Anything drawn here will likely be covered by other UI elements. Return `true`
---to stop the rest of UI to be drawn in this frame. Use `mode` passed in your callback to determine the state of the game: chances are you’d need to draw your
---HUD only with `'game'` mode.
---
---New values for `mode` might in theory be added later (or maybe not, hard to tell at this point).
---
---Not available to car and track scripts.
---@param callback fun(mode: 'menu'|'game', readOnlyMode: boolean): boolean?
---@param settingsCallback fun(): boolean?? @Default value: `nil`.
---@return ac.Disposable
function ui.onChat(callback, settingsCallback) end

---Sets a callback for drawing UI which will be called first. Anything drawn here will likely be covered by other UI elements. Return `true`
---to stop the rest of UI to be drawn in this frame (including AC UI). Return `'debug'` to also show Lua Debug app, in case you’d need it
---for development. Use `mode` passed in your callback to determine the state of the game: chances are you’d need to draw your
---HUD only with `'game'` mode.
---
---New values for `mode` might in theory be added later (or maybe not, hard to tell at this point).
---
---Not available to car and track scripts.
---
---Since 0.2.8, return `'finalize'` to allow `ui.popup()` and `ui.onUIFinale()`.
---@param callback fun(mode: 'menu'|'pause'|'results'|'replay'|'game'): 'debug'|'debug-nonexclusive'|'apps'|'apps-nonexclusive'|boolean?
---@param noPadding boolean? @Default value: `false`.
---@return ac.Disposable
function ui.onExclusiveHUD(callback, noPadding) end

---Open modal popup message with OK and Cancel buttons, return user choice via callback. Since 0.3.0, you can pass `'-'` as `cancelText` to have a dialog
---with a single button only.
---@overload fun(title: string, msg: string, callback: function, autoclose: boolean)
---@param title string
---@param msg string
---@param okText string|nil @Optional label for OK button. Default value: `nil`.
---@param cancelText string|nil @Optional label for cancel button. Default value: `nil`.
---@param okIconID ui.Icons|nil @Optional icon for OK button. Default value: `nil`.
---@param cancelIconID ui.Icons|nil @Optional icon for cancel button. Default value: `nil`.
---@param callback fun(okPressed: boolean)? @Default value: `nil`.
---@param autoclose boolean? @Automatically close if clicked outside of dialog, or if Escape button is pressed. Default value: `false`.
function ui.modalPopup(title, msg, okText, cancelText, okIconID, cancelIconID, callback, autoclose) end

---Open modal dialog with custom UI. Return `true` from callback when it’s time to close the dialog.
---
--- To match original dialogs use `ui.newLine()` after the message and vertical offset of four pixels before drawing the buttons. For buttons use
--- `ui.modernButton()` with the height of 40 pixels and the gap of 8 pixels.
---@param title string
---@param callback fun(): boolean
---@param autoclose boolean? @Automatically close if clicked outside of dialog, or if Escape button is pressed. Default value: `false`.
---@param closeCallback fun()? @Default value: `nil`.
function ui.modalDialog(title, callback, autoclose, closeCallback) end

---Open modal popup message with text input, OK and Cancel buttons, return user choice via callback.
---@overload fun(title: string, msg: string, defaultValue: string, callback: function, autoclose: boolean)
---@param title string
---@param msg string
---@param defaultValue string?
---@param okText string? @Optional label for OK button.
---@param cancelText string? @Optional label for cancel button.
---@param okIconID ui.Icons @Optional icon for OK button.
---@param cancelIconID ui.Icons @Optional icon for cancel button.
---@param callback fun(value: string|nil)
---@param autoclose boolean? @Automatically close if clicked outside of dialog, or if Escape button is pressed. Default value: `false`.
function ui.modalPrompt(title, msg, defaultValue, okText, cancelText, okIconID, cancelIconID, callback, autoclose) end

---Projects world point onto a screen (taking into account UV scale unless second argument is set to `false`).
---@param pos vec3
---@param considerUiScale boolean? @Default value: `true`.
---@return vec2 @Returns vector with `inf` for values if point is outside of screen.
function ui.projectPoint(pos, considerUiScale) end

---If possible, unloads image from memory and VRAM. Doesn’t work with all types of images.
---@param imageSource ui.ImageSource
---@return boolean @Returns `true` if file was unloaded successfully.
function ui.unloadImage(imageSource) end

---Draws 14×14 pixels driver icon (rounded livery or a custom icon if icon is overriden).
---@param carIndex integer @0-based car index.
---@param pos number|vec2
---@param useCustomIcon boolean? @Default value: `true`.
function ui.drawDriverIcon(carIndex, pos, useCustomIcon) end

---Add tooltip with details about a certain driver.
---@param carIndex integer @0-based car index.
function ui.setDriverTooltip(carIndex) end

---Shows context menu for a certain driver. Use `ui.openPopup(id)` to trigger it first.
---@param id string
---@param carIndex integer @0-based car index.
---@return boolean @Returns `false` once popup closes.
function ui.setDriverPopup(id, carIndex) end

---Adds mention of a driver in chat input.
---@param carIndex integer
---@param autofocus boolean? @Default value: `true`.
function ui.mentionDriverInChat(carIndex, autofocus) end

---Returns state of an image (might act strangely with special textures, like the ones loaded from DLLs; new return values might be added later).
---@param imageSource string @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@return 'ready'|'loading'|'missing'
function ui.imageState(imageSource) end

---Shows a hidden app window or few while current script is alive (temporarily removing “HIDDEN” window flag).
---@param appID string
---@param windowFilter string? @Default value: '?'.
---@param visible boolean? @Default value: `true`.
function ac.setAppWindowVisible(appID, windowFilter, visible) end

---Opens a main window of a Lua app (or, if opened, brings it to focus).
---@param appID string
function ac.setAppOpen(appID) end

---@return string
function loading.carID() end

---@return string
function loading.carSkinID() end

---@return string
function loading.trackID() end

---@return string
function loading.trackLayoutID() end

---Returns estimate of loading progress from 0 to 1.
---@return number
function loading.progress() end

---Returns `true` if loading has stopped and AC will shut down soon.
---@return boolean
function loading.stopped() end

---Returns AC version string in a format `Assetto Corsa <VERSION> & Custom Shaders Patch <VERSION>`.
---@return string
function loading.version() end

---@return string
function loading.carName() end

---@return string
function loading.trackName() end

---Main status message.
---@return string
function loading.status() end

---Details status message.
---@return string
function loading.details() end

---@return string[]
function loading.carHints() end

---@return string[]
function loading.trackHints() end

---@return string[]
function loading.serverHints() end

---Returns `nil` or two strings for a warning (title and details). Please consider showing it if it’s non-nil, those warnings
---might be important.
---@return string, string @Title and description.
function loading.warning() end

---@class ScriptData
---@field update fun(dt: number) @Called each frame. Param `dt` is time since the last call of `.update()` in seconds.
---@single-instance
script = {}

---Get values about the state of loading here.
loading = {}

--[[ common/debug.lua ]]

---Displays value in Lua Debug app, great for tracking state of your values live.
---@param key string
---@param value any?
---@overload fun(key: string, value: number, min: number?, max: number?, collect: integer?, collectMode: ac.DebugCollectMode?) @Variant with fixed range for a graph in Lua Debug app. Set `collect` to a value above 1 if you need Lua Debug App to combine a few values so that graph would move slower. Parameter `collectMode` can specify the way in which values will be combined.
function ac.debug(key, value) end

--[[ common/debug.lua ]]

---Prints a message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.log(...) end

---Prints a warning message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.warn(...) end

---Prints an error message to a CSP log and to Lua App Debug log. To speed things up and only use Lua Debug app, call `ac.setLogSilent()`.
function ac.error(...) end

---For compatibility, acts similar to `ac.log()`.
function print(...) end

--[[ common/common_base.lua ]]

---Disposable thing is something set which you can then un-set. Just call `ac.Disposable` returned
---from a function to cancel out whatever happened there. For example, unsubscribe from an event.
---@alias ac.Disposable fun()

---Calls a function in a safe way, catching errors. If any errors were to occur, `catch` would be
---called with an error message as an argument. In either case (with and without error), if provided,
---`finally` will be called.
---
---Does not raise errors unless errors were thrown by `catch` or `finally`. Before CSP 0.2.5, if `catch`
---throws an error, `finally` wouldn’t be called (fixed in 0.2.5).
---@generic T
---@param fn fun(): T?
---@param catch fun(err: string)|nil @If not set, error won’t propagate anyway.
---@param finally fun()|nil
---@return T|nil
function try(fn, catch, finally) end

---Calls a function and then calls `dispose` function. Note: `dispose` function will be called even if
---there would be an error in `fn` function. But error would not be contained and will propagate.
---
---Any error thrown by `fn()` will be raised and not captured, but `dispose()` will be called either way.
---@generic T
---@param fn fun(): T?
---@param dispose fun()? @CSPs before 0.2.5 require non-nil argument.
---@return T|nil
function using(fn, dispose) end

---Resolves relative path to a Lua module (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `require()` function.
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
---@nodiscard
function package.relative(path) end

---Resolves relative path to a file (relative to Lua file you’re running this function from)
---so it would be ready to be passed to `io` functions (returns full path).
---
---Note: performance might be a problem if you are calling it too much, consider caching the result.
---@param path string
---@return string
---@nodiscard
function io.relative(path) end

---Given an FFI struct and a string of data, fills struct with that data. Works only if size of struct matches size of data. Data string can contain zeroes.
---@generic T
---@param destination T @FFI struct (type should be “cdata”).
---@param data binary @String with binary data.
---@return T
function ac.fillStructWithBytes(destination, data) end

---Fills a string of an FFI struct with data up to a certain size. Make sure to not overfill the data.
---@param src string @String to copy.
---@param dst string @A `const char[N]` field of a struct.
---@param size integer @Size of `const char[N]` field (N).
function ac.stringToFFIStruct(src, dst, size) end

--[[ common/common.lua ]]

---Adds a callback which might be called when script is unloading. Use it for some state reversion, but
---don’t rely on it too much. For example, if Assetto Corsa would crash or just close rapidly, it would not
---be called. It should be called when scripts reload though.
---@generic T
---@param callback fun(item: T)
---@param item T? @Optional parameter. If provided, will be passed to callback on release, but stored with a weak reference, so it could still be GCed before that (in that case, callback won’t be called at all).
---@return fun() @Call to disable callback.
function ac.onRelease(callback, item) end

---For easy import of scripts from subdirectories. Provide it a name of a directory relative
---to main script folder and it would add that directory to paths it searches for.
---@param dir string
function package.add(dir) end

---Sets a callback which will be called when server welcome message and extended config arrive.
---@param callback fun(message: string, config: ac.INIConfig) @Callback function.
---@return ac.Disposable
function ac.onOnlineWelcome(callback) end

--[[ common/const.lua ]]

---Does nothing, but with preprocessing optimizations inlines value as constant.
---@generic T
---@param value T
---@return T
function const(value) end

--[[ common/ac_matrices.lua ]]

---Creates a new neutral matrix.
---@return mat3x3
function mat3x3.identity() end

---@param row1 vec3? 
---@param row2 vec3? 
---@param row3 vec3? 
---@return mat3x3
function mat3x3(row1, row2, row3) end

---@class mat3x3
---@field row1 vec3
---@field row2 vec3
---@field row3 vec3
local mat3x3 = nil

---@param value mat3x3
---@return mat3x3
function mat3x3:set(value) end

---@return mat3x3
function mat3x3:clone() end

---Creates a new neutral matrix.
---@return mat4x4
function mat4x4.identity() end

---Creates a translation matrix.
---@param offset vec3
---@return mat4x4
function mat4x4.translation(offset) end

---Creates a rotation matrix.
---@param angle number @Angle in radians.
---@param axis vec3
---@return mat4x4
function mat4x4.rotation(angle, axis) end

---Creates a rotation matrix from Euler angles in radians.
---@param head number
---@param pitch number
---@param roll number
---@return mat4x4
function mat4x4.euler(head, pitch, roll) end

---Creates a scaling matrix.
---@param scale vec3
---@return mat4x4
function mat4x4.scaling(scale) end

---Creates a look-at matrix from position and directional vectors. Ensures all vectors are properly normalized.
---@param position vec3
---@param look vec3
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
---@return mat4x4
function mat4x4.look(position, look, up) end

---Creates a perspective matrix.
---@param fovY number @Vertical view angle in radians.
---@param aspect number @Aspect ratio.
---@param zNear number @Near clipping plane.
---@param zFar number @Far clipping plane.
---@return mat4x4
function mat4x4.perspective(fovY, aspect, zNear, zFar) end

---Creates an orthogonal matrix. Might act unexpected with Z values, shifting by range should help.
---@param extentMin vec3
---@param extentMax vec3
---@return mat4x4
function mat4x4.ortho(extentMin, extentMax) end

---@param row1 vec4? 
---@param row2 vec4? 
---@param row3 vec4? 
---@param row4 vec4? 
---@return mat4x4
function mat4x4(row1, row2, row3, row4) end

---@class mat4x4
---@field row1 vec4
---@field row2 vec4
---@field row3 vec4
---@field row4 vec4
---@field position vec3
---@field look vec3
---@field side vec3
---@field up vec3
local mat4x4 = nil

---@param value mat4x4
---@return mat4x4
function mat4x4:set(value) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformVectorTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformVector(vec) end

---@param destination vec4
---@param vec vec4
---@return vec4
function mat4x4:transformTo(destination, vec) end

---@param vec vec4
---@return vec4
function mat4x4:transform(vec) end

---@param destination vec3
---@param vec vec3
---@return vec3
function mat4x4:transformPointTo(destination, vec) end

---@param vec vec3
---@return vec3
function mat4x4:transformPoint(vec) end

---@return mat4x4
function mat4x4:clone() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:inverse() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:inverseSelf() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:normalize() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:normalizeSelf() end

---Creates a new matrix.
---@return mat4x4
function mat4x4:transpose() end

---Modifies current matrix.
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:transposeSelf() end

---Note: unlike vector’s `:mul()`, this one creates a new matrix!
---@param other mat4x4
---@return mat4x4
function mat4x4:mul(other) end

---Modifies current matrix.
---@param other mat4x4
---@return mat4x4 @Returns self for easy chaining.
function mat4x4:mulSelf(other) end

---Writes result into a separate matrix.
---@param destination mat4x4
---@param other mat4x4
---@return mat4x4 @Returns destination matrix.
function mat4x4:mulTo(destination, other) end

--[[ common/math.lua ]]

---Takes value with even 0…1 distribution and remaps it to recreate a distribution
---similar to Gaussian’s one (with k≈0.52, a default value). Lower to make bell more
---compact, use a value above 1 to get some sort of inverse distibution.
---@param x number @Value to adjust.
---@param k number @Bell curvature parameter.
---@return number
---@nodiscard
function math.gaussianAdjustment(x, k) end

---Builds a list of points arranged in a square with poisson distribution.
---@param size integer @Number of points.
---@param tileMode boolean? @If set to `true`, resulting points would be tilable without breaking poisson distribution.
---@return vec2[]
---@nodiscard
function math.poissonSamplerSquare(size, tileMode) end

---Builds a list of points arranged in a circle with poisson distribution.
---@param size integer @Number of points.
---@return vec2[]
---@nodiscard
function math.poissonSamplerCircle(size) end

---Generates a random number in [0, INT32_MAX) range. Can be a good argument for `math.randomseed()`.
---@return integer
---@nodiscard
function math.randomKey() end

---Generates random number based on a seed.
---@param seed integer|boolean|string @Seed.
---@return number @Random number from 0 to 1.
---@nodiscard
function math.seededRandom(seed) end

---Rounds number, leaves certain number of decimals.
---@param number number
---@param decimals number? @Default value: 0 (rounding to a whole number).
---@return integer
---@nodiscard
function math.round(number, decimals) end

---Clamps a number value between `min` and `max`.
---@param value number
---@param min number
---@param max number
---@return number
---@nodiscard
function math.clampN(value, min, max) end

---Clamps a number value between 0 and 1.
---@param value number
---@return number
---@nodiscard
function math.saturateN(value) end

---Clamps a copy of a vector between `min` and `max`. To avoid making copies, use `vec:clamp(min, max)`.
---@generic T
---@param value T
---@param min any
---@param max any
---@return T
---@nodiscard
function math.clampV(value, min, max) end

---Clamps a copy of a vector between 0 and 1. To avoid making copies, use `vec:saturate()`.
---@generic T
---@param value T
---@return T
---@nodiscard
function math.saturateV(value) end

---Clamps value between `min` and `max`, returning `min` if `x` is below `min` or `max` if `x` is above `max`. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@param min T|number
---@param max T|number
---@return T
---@nodiscard
function math.clamp(x, min, max) end

---Clamps value between 0 and 1, returning 0 if `x` is below 0 or 1 if `x` is above 1. Universal version, so might be slower.
---Also, if given a vector or a color, would make a copy of it.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.saturate(x) end

---Returns a sing of a value, or 0 if value is 0.
---@param x number
---@return integer
---@nodiscard
function math.sign(x) end

---Linear interpolation between `x` and `y` using `mix` (x * (1 - mix) + y * mix).
---@generic T
---@param x T
---@param y T
---@param mix number
---@return T
---@nodiscard
function math.lerp(x, y, mix) end

---Returns 0 if value is less than v0, returns 1 if it’s more than v1, linear interpolation in-between.
---@param value number
---@param min number
---@param max number
---@return number
---@nodiscard
function math.lerpInvSat(value, min, max) end

---Returns `newA` if `value` equals to `oldA`, `newB` if `value` is `oldB`, applies linear interpolation for other input values. Doesn’t apply clamping.
---@param value number
---@param oldA number
---@param oldB number
---@param newA number
---@param newB number
---@return number
---@nodiscard
function math.remap(value, oldA, oldB, newA, newB) end

---Smoothstep operation. More about it in [wiki](https://en.wikipedia.org/wiki/Smoothstep).
---@param x number
---@return number
---@nodiscard
function math.smoothstep(x) end

---Like a smoothstep operation, but even smoother.
---@param x number
---@return number
---@nodiscard
function math.smootherstep(x) end

---Creates a copy of a vector and normalizes it. Consider using a method `vec:normalize()` instead when you can change the original vector to save on performanceMeter.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.normalize(x) end

---Creates a copy of a vector and runs a cross product on it. Consider avoiding making a copy with `vec:cross(otherVec)`.
---@param x vec3
---@return vec3
---@nodiscard
function math.cross(x, y) end

---Calculates dot product of two vectors.
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.dot(x, y) end

---Calculates angle between vectors in radians.
---@param x vec2|vec3|vec4
---@return number @Radians.
---@nodiscard
function math.angle(x, y) end

---Calculates distance between vectors.
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.distance(x, y) end

---Calculates squared distance between vectors (slightly faster without taking a square root).
---@param x vec2|vec3|vec4
---@return number
---@nodiscard
function math.distanceSquared(x, y) end

---Creates a copy of a vector and projects it onto a different vector. Consider avoiding making a copy with `vec:project(otherVec)`.
---@generic T
---@param x T
---@return T
---@nodiscard
function math.project(x, y) end

---@nodiscard
function math.radians(x) end

---@nodiscard
function math.degress(x) end

---Checks if value is not-a-number.
---@param x number
---@return boolean
---@nodiscard
function math.isnan(x) end

---Checks if value is positive or negative infinity.
---@param x number
---@return boolean
---@nodiscard
function math.isinf(x) end

---Checks if value is finite (not infinite or nan).
---@param x number
---@return boolean
---@nodiscard
function math.isfinite(x) end

---@type number
math.nan = math.sqrt(-1)

---@type number
math.tau = math.pi * 2

---@deprecated Use math.isnan instead.
function math.isNaN(x) end

---@deprecated Use math.nan instead.
math.NaN = 0/0

---@param lag number
---@param dt number
---@return number
---@nodiscard
function math.lagMult(lag, dt) end

---Perlin noise for given input. Returns value within -1…1 range, or outside of it if `octaves` is above 1. If you’re using octaves, make sure `input`
---won’t overflow when being multiplied by two multiple times.
---
---Consider using `math.simplex` instead, it might be a better alternative.
---@param input number|vec2|vec3
---@param octaves integer? @Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.
---@param persistence number? @Persistance for octave noise. Used only if `octaves` is above 1. Default value: 0.5.
---@return number
---@nodiscard
function math.perlin(input, octaves, persistence) end

---Simplex noise for given input. Returns value within -1…1 range (unlike `math.perlin`, always). If you’re using octaves, make sure `input`
---won’t overflow when being multiplied by two multiple times.
---@param input number|vec2|vec3
---@param octaves integer? @Pass number greater than 1 to generate octave noise instead (sum `octaves` noise functions together increasing input and multiplying amplitude by `persistence` each step). Default value: 1.
---@param lacunarity number? @Frequency increase for subsequent octaves. Used only if `octaves` is above 1. Default value: 2.
---@param persistence number? @Persistance for octave noise. Used only if `octaves` is above 1. Usually set to `1 / lacunarity`. Default value: 0.5.
---@return number
---@nodiscard
function math.simplex(input, octaves, lacunarity, persistence) end

---Roughly convert HDR value to LDR using conversion hints provided by current WeatherFX style. Doesn’t apply nothing like tonemapping or exposure
---correction, simply adjusts for a case where WeatherFX style uses small brightness multiplier or linear color space.
---
---Note: shaders have the same function called `convertHDR()`.
---@generic T: number|rgb|rgbm
---@param input T @Value to convert.
---@param toLDR boolean? @Pass `true` to do the reverse and convert LDR to HDR. Default value: `false`.
---@return T
---@nodiscard
function math.convertHDR(input, toLDR) end

---@generic T : number|vec2|vec3|vec4
---@param value T
---@param target T
---@param lag number
---@param dt number
---@return T
---@nodiscard
function math.applyLag(value, target, lag, dt) end

--[[ common/string.lua ]]

---Function won’t work: while CSP tries its best to guarantee API compatibility, ABI compatibility is not a priority at all,
---and the underlying LuaJIT implementation frequently changes and might even be replaced with something else in the future.
---@return nil
function string.dump() return nil end

---Splits string into an array using separator.
---@param self string @String to split.
---@param separator string? @Separator. If empty, string will be split into individual characters. Default value: ` `.
---@param limit integer? @Limit for pieces of string. Once reached, remaining string is put as a list piece.
---@param trimResult boolean? @Set to `true` to trim found strings. Default value: `false`.
---@param skipEmpty boolean? @Set to `false` to keep empty strings. Default value: `true` (for compatibility reasons).
---@param splitByAnyChar boolean? @Set to `true` to split not by a string `separator`, but by any characters in `separator`.
---@return string[]
function string.split(self, separator, limit, trimResult, skipEmpty, splitByAnyChar) end

---Splits string into a bunch of numbers (not in an array). Any symbol that isn’t a valid part of number is considered to be a delimiter. Does not create an array
---to keep things faster. To make it into an array, simply wrap the call in `{}`.
---@param self string @String to split.
---@param limit integer? @Limit for amount of numbers. Once reached, remaining part is ignored.
---@return ... @Numbers
function string.numbers(self, limit) end

---Pack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return string
function string.pack(self, ...) end

---Measure size of packed things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return integer
function string.packsize(self) end

---Unpack things. For format, see <https://www.lua.org/manual/5.3/manual.html#6.4.2>.
---Use `a` for half-precision floating point value (two bytes).
---@param self string @Format string.
---@return ...
function string.unpack(self) end

---Checks if string starts with an URL or not. Uses flexible parsing scheme so even URLs not starting with
---a scheme could be found.
---@param self string @Target string.
---@param offset integer? @Starting search index, 1-based.
---@return integer? @Returns length of URL, or `nil` if string is not an URL.
function string.urlCheck(self, offset) end

---Finds next URL in a string. Uses flexible parsing scheme so even URLs not starting with
---a scheme could be found.
---@param self string @Target string.
---@param offset integer? @Starting search index, 1-based.
---@return integer? @First returned value is 1-based index of URL start.
---@return integer? @Second returned value is 1-based index of URL end (both arguments can be passed to `string.sub()` to cut out the URL).
function string.urlNext(self, offset) end

---Works like string.find with plain mode, but ignores case.
---@param self string @String to find `needle` in.
---@param needle string @String to find.
---@param index integer? @Starting search index. Default value: `1`.
---@return integer? @1-based index of a first match, or `nil` if nothing has been found.
function string.findIgnoreCase(self, needle, index) end

---Searches and replaces all the substrings.
---@param self string @String to find `replacee` and replace with `replacer` in.
---@param replacee string @String to find.
---@param replacer string? @String to replace. Default value: `''` (empty string, fixed in 0.3.0).
---@param limit integer? @Maximum number of found strings to replace. Default value: `math.huge`.
---@param ignoreCase boolean? @Option for case-incensitive search. Default value: `false`.
---@return string, integer @Second value returned is for the number of replacements.
function string.replace(self, replacee, replacer, limit, ignoreCase) end

---Returns UTF8 string for a corresponding code point.
---@param codePoint integer
---@return string
function string.codePointToUTF8(codePoint) end

---Returns unicode codepoint and length in bytes from a point in a string. Throws an error with invalid UTF-8.
---@param self string @String to get a codepoint from
---@param start integer @Index (starts with 1, if below counts from the end).
---@return integer? @Symbol codepoint (or `nil` if there is no symbol with given index).
---@return integer @Symbol length (or `nil` if there is no symbol with given index).
function string.codePointAt(self, start) end

---Looks for a next emoji in the string. If next emoji is complex, all the symbols will be processed and returned as a single byte sequence. Uses 15th version
---with data from Emoji Keyboard/Display Test Data for UTS #51.
---Not working properly for CSP versions below v0.2.3-preview50.
---@param self string @String to search emojis in.
---@param start integer @Index (starts with 1, if below counts from the end).
---@return integer? @Returns 1-based starting index of an emojis, or `nil` if no emojis have been found.
---@return integer? @Returns 1-based starting index plus the length of the emoji, or `nil` if no emojis have been found.
function string.nextEmoji(self, start) end

---Encodes URL argument.
---@param self string
---@param plusForSpaces boolean? @Use `'+'` for space symbol (works for URLs, but if a regular URL encoding is needed, might be getting in a way). Default value: `true`.
---@return string
function string.urlEncode(self, plusForSpaces) end

---Checks if the beginning of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the beginning of.
---@param another string @String to match.
---@param offset integer? @Optional offset for the matching beginning. Default value: `0`.
---@return boolean
function string.startsWith(self, another, offset) end

---Checks if the end of a string matches another string. If string to match is longer than the first one, always returns `false`.
---@param self string @String to check the end of.
---@param another string @String to match.
---@param offset integer? @Optional offset from the end for the matching end. Default value: `0`.
---@return boolean
function string.endsWith(self, another, offset) end

---Compares string alphanumerically.
---@param self string @First string.
---@param another string @Second string.
---@return integer @Returns positive number if first string is larger than second one, or 0 if strings are equal.
function string.alphanumCompare(self, another) end

---Compares string as versions (splits by dots and uses alphanumerical comparator for each piece).
---@param self string @First version.
---@param another string @Second version.
---@return integer @Returns positive number if first version is newer than second one, or 0 if versions are equal.
function string.versionCompare(self, another) end

---Trims string at beginning and end.
---@param self string @String to trim.
---@param characters string? @Characters to remove. Default value: `'\n\r\t '`.
---@param direction integer? @Direction to trim, 0 for trimming both ends, -1 for trimming beginning only, 1 for trimming the end. Default value: `0`.
---@return string
function string.trim(self, characters, direction) end

---Repeats string a given number of times (`repeat` is a reserved keyword, so here we are).
---@param self string @String to trim.
---@param count integer @Number of times to repeat the string.
---@return string
function string.multiply(self, count) end

---Pads string with symbols from `pad` until it reaches the desired length.
---@param self string @String to trim.
---@param targetLength integer @Desired string length. If shorter than current length, string will be trimmed from the end.
---@param pad string? @String to pad with. If empty, no padding will be performed. If has more than one symbol, will be repeated to fill the space. Default value: ` ` (space).
---@param direction integer? @Direction to pad to, 1 for padding at the end, -1 for padding at the start, 0 for padding from both ends centering string. Default value: `1`.
---@return string
function string.pad(self, targetLength, pad, direction) end

---Similar to `string.find()`: looks for the first match of `pattern` and returns indices, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return integer? @1-based index of where the match occured, or `nil` if no match has been found.
---@return integer? @1-based index of the ending of found pattern, or `nil` if no match has been found.
---@return ... @Captured elements, if there are any capture groups in the pattern.
---@nodiscard
function string.regfind(self, pattern, init, ignoreCase) end

---Similar to `string.match()`: looks for the first match of `pattern` and returns matches, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @Captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.regmatch(self, pattern, init, ignoreCase) end

---Similar to `string.gmatch()`: iterates over matches of `pattern`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return fun():string, ... @Iterator with captured elements if there are any capture groups in the pattern, or the whole captured string otherwise.
---@nodiscard
function string.reggmatch(self, pattern, ignoreCase) end

---Similar to `string.gsub()`: replaces all entries of `pattern` with `repl`, but uses regular expressions.
---
---Note: regular expressions currently are in ECMAScript format, so backtracking is not supported. Also, in most cases they are slower than regular Lua patterns.
---@param self string @String to search in.
---@param pattern string @Regular expression.
---@param repl    string|table|function @Replacement value. Used in the same way as with `string.gsub()`, could be a table or a function. If you want to insert groups, use `$1` (regular expressions style) instead of `%1` (Lua patterns style).
---@param limit integer? @Limit maximum number of replacements. Default value: `math.huge`.
---@param ignoreCase boolean? @Set to `true` to make search case-insensitive. Default value: `false`.
---@return string @String with found entries replaced.
---@nodiscard
function string.reggsub(self, pattern, repl, limit, ignoreCase) end

---Compares a string against CSP-style filter (using “?” for “any characters”).
---@param self string @String to check.
---@param filter string @Filter to check. Surround with `{…}` to use complex queries, for example, `'{ ABC? & ! ?DEF }'`.
---@param init integer? @1-based offset to start searching from. Default value: `1`.
---@return boolean
function string.cspmatch(self, filter, init) end

--[[ common/table.lua ]]

---Merges tables into one big table. Tables can be arrays or dictionaries, if it’s a dictionary same keys from subsequent tables will overwrite previously set keys.
---@generic T
---@param table T
---@vararg table
---@return T
---@nodiscard
function table.chain(table, ...) end

--[[ common/table.lua ]]

---Checks if table is an array or not. Arrays are tables that only have consecutive numeric keys. If this function returns `true`, it doesn’t mean
---underlying LuaJIT structure is exactly a dense array, but it does mean that it could be. For example, `{[2]=2, [1]=1}` is not a dense array from
---LuaJIT POV, but semantically it is, and so `table.isArray()` would return `true`.
---@param t table|any[]
---@return boolean
---@nodiscard
function table.isArray(t) end

---Creates a new table with preallocated space for given amount of elements.
---@param arrayElements integer @How many elements the table will have as a sequence.
---@param mapElements integer @How many other elements the table will have.
---@return table
---@nodiscard
function table.new(arrayElements, mapElements) end

---Cleares table without deallocating space using a fast LuaJIT call. Can work
---with both array and non-array tables.
---@param t table
function table.clear(t) end

---Returns the total number of elements in a given Lua table (i.e. from both the array and hash parts combined).
---@param t table
---@return integer
---@nodiscard
function table.nkeys(t) end

---Clones table using a fast LuaJIT call. Doesn’t clone any vectors or colors inside, but it is fast.
---@generic T
---@param t T
---@param deep nil|boolean|'full' @Set to `true` for deep cloning. Default value: `false`. Since 0.2.10, set to `'full'` to clone vectors or colors as well.
---@return T
---@nodiscard
function table.clone(t, deep) end

---Removes first item by value, returns true if any item was removed. Can work
---with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
function table.removeItem(t, item) end

---Returns an element from table with a given key. If there is no such element, calls callback
---and uses its return value to add a new element and return that. Can work
---with both array and non-array tables.
---@generic T
---@generic TCallbackData
---@param t table<any, T>
---@param key any
---@param callback fun(callbackData: TCallbackData): T
---@param callbackData TCallbackData?
---@return T
function table.getOrCreate(t, key, callback, callbackData) end

---Returns true if table contains an item. Can work with both array and non-array tables.
---@generic T
---@param t table<any, T>
---@param item T
---@return boolean
---@nodiscard
function table.contains(t, item) end

---Returns a random item from a table. Optional callback works like a filter. Can work
---with both array and non-array tables. Alternatively, optional callback can provide a number
---for a weight of an item.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param filteringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): boolean
---@param filteringCallbackData TCallbackData?
---@param randomDevice nil|fun(): number @Optional callback for generating random numbers. Needs to return a value between 0 and 1. If not set, default `math.random` is used.
---@return T
---@nodiscard
function table.random(t, filteringCallback, filteringCallbackData, randomDevice) end

---Returns a key of a given element, or `nil` if there is no such element in a table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@param t {[TKey]: T}
---@param item T
---@return TKey|nil
---@nodiscard
function table.indexOf(t, item) end

---Returns true if tables contents are the same.
---@generic TKey
---@param t1 table?
---@param t2 table?
---@param deep boolean? @Default value: `true`.
---@return boolean
---@nodiscard
function table.same(t1, t2, deep) end

---Joins elements of a table to a string, works with both arrays and non-array tables. Optinal
---toStringCallback parameter can be used for a custom item serialization. All parameters but
---`t` (for actual table) are optional and can be skipped.
---
---Note: it wouldn’t work as fast as `table.concat`, but it would call a `tostring()` (or custom
---serializer callback) for each element.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param itemsJoin string? @Default value: ','.
---@param keyValueJoin string? @Default value: '='.
---@param toStringCallback nil|fun(item: T, key: TKey, callbackData: TCallbackData): string
---@param toStringCallbackData TCallbackData?
---@overload fun(t: table, itemsJoin: string, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@overload fun(t: table, toStringCallback: fun(item: any, key: any, callbackData: any), toStringCallbackData: any)
---@return TKey|nil
---@nodiscard
function table.join(t, itemsJoin, keyValueJoin, toStringCallback, toStringCallbackData) end

---Slices array, basically acts like slicing thing in Python.
---@generic T
---@param t T[]
---@param from integer @Starting index.
---@param to integer? @Ending index.
---@param step integer? @Step.
---@return T[]
---@nodiscard
function table.slice(t, from, to, step) end

---Flips table from back to front, requires an array.
---@generic T
---@param t T[]
---@return T[]
---@nodiscard
function table.reverse(t) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TReturnKey
---@generic TReturnValue
---@param t {[TKey]: T}
---@param callback (fun(item: T, index: TKey, callbackData: TCallbackData): TReturnValue, TReturnKey?)|nil @Mapping callback.
---@param callbackData TCallbackData?
---@return {[TReturnKey]: TReturnValue}
---@nodiscard
function table.map(t, callback, callbackData) end

---Calls callback function for each of table elements, creates a new table containing all the resulting values.
---Can work with both array and non-array tables. For non-array tables, new table is going to be an array unless
---callback function would return a key as a second return value.
---
---If callback returns two values, second would be used as a key to create a table-like table (not an array-like one).
---
---Note: if callback returns `nil`, value will be skipped, so this function can act as a filtering one too.
---@generic T
---@generic TKey
---@generic TCallbackData
---@generic TData
---@param t {[TKey]: T}
---@param startingValue TData
---@param callback fun(data: TData, item: T, index: TKey, callbackData: TCallbackData): TData @Reduction callback.
---@param callbackData TCallbackData?
---@return TData
---@nodiscard
function table.reduce(t, startingValue, callback, callbackData) end

---Creates a new table from all elements for which filtering callback returns true. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): any @Filtering callback.
---@param callbackData TCallbackData?
---@return {[TKey]: T}
---@nodiscard
function table.filter(t, callback, callbackData) end

---Returns true if callback returns non-false value for every element of the table. Can work with both
---array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
---@nodiscard
function table.every(t, callback, callbackData) end

---Returns true if callback returns non-false value for at least a single element of the table. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return boolean
---@nodiscard
function table.some(t, callback, callbackData) end

---Counts number of elements for which callback returns non-false value. Can work
---with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback nil|fun(item: T, index: TKey, callbackData: TCallbackData): boolean @If not set, all elements will be counted.
---@param callbackData TCallbackData?
---@return integer
---@nodiscard
function table.count(t, callback, callbackData) end

---Calls callback for each element, returns sum of returned values. Can work
---with both array and non-array tables. If callback is missing, sums actual values in table.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return integer
---@nodiscard
function table.sum(t, callback, callbackData) end

---Returns first element and its key for which callback returns a non-false value. Can work
---with both array and non-array tables. If nothing is found, returns `nil`.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): boolean
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.findFirst(t, callback, callbackData) end

---Returns first element and its key for which a certain property matches the value. If nothing is
---found, returns `nil`.
---@generic T
---@generic TKey
---@param t {[TKey]: T}
---@param key string
---@param value any
---@return T, TKey
---@nodiscard
function table.findByProperty(t, key, value) end

---Returns an element and its key for which callback would return the highest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number?
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.maxEntry(t, callback, callbackData) end

---Returns an element and its key for which callback would return the lowest numerical value. Can work
---with both array and non-array tables. If callback is missing, actual table elements will be compared.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, index: TKey, callbackData: TCallbackData): number?
---@param callbackData TCallbackData?
---@return T, TKey
---@nodiscard
function table.minEntry(t, callback, callbackData) end

---Runs callback for each item in a table. Can work with both array and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback fun(item: T, key: TKey, callbackData: TCallbackData)
---@param callbackData TCallbackData?
---@return table
---@nodiscard
function table.forEach(t, callback, callbackData) end

---Creates a new table with unique elements from original table only. Optionally, a callback
---can be used to provide a key which uniqueness will be checked. Can work with both array
---and non-array tables.
---@generic T
---@generic TKey
---@generic TCallbackData
---@param t {[TKey]: T}
---@param callback nil|fun(item: T, key: TKey, callbackData: TCallbackData): any|nil
---@param callbackData TCallbackData?
---@return {[TKey]: T}
---@nodiscard
function table.distinct(t, callback, callbackData) end

---Finds first element for which `testCallback` returns true, returns index of an element before it.
---Elements should be ordered in such a way that there would be no more elements returning false to the right
---of an element returning true.
---
---If `testCallback` returns true for all elements, would return 0. If `testCallback` returns false for all,
---returns index of the latest element.
---@generic T
---@generic TCallbackData
---@param t T[]
---@param testCallback fun(item: T, index: integer, callbackData: TCallbackData): boolean
---@param testCallbackData nil|TCallbackData
---@return integer
---@nodiscard
function table.findLeftOfIndex(t, testCallback, testCallbackData) end

---Similar to JavaScript’s `Object.assign()`, works with tables and arrays, returns first argument (modified).
---@generic T
---@param target T
---@param ... table
---@return T
function table.assign(target, ...) end

---Flattens table similar to JavaScript function with the same name. Requires an array.
---@param t any[]
---@param maxLevel integer? @Default value: 1.
---@return any[]
---@nodiscard
function table.flatten(t, maxLevel) end

---Creates a new table running in steps from `startingIndex` to `endingIndex`, including `endingIndex`.
---If callback returns two values, second value is used as a key.
---@generic T
---@generic TCallbackData
---@param endingIndex integer?
---@param startingIndex integer
---@param step integer?
---@param callback fun(index: integer, callbackData: TCallbackData): T, integer|string?
---@param callbackData TCallbackData?
---@return T[]
---@overload fun(endingIndex: integer, callback: (fun(index: integer, callbackData: any): any, integer|string?), callbackData: any)
---@overload fun(endingIndex: integer, startingIndex: integer, callback: (fun(index: integer, callbackData: any): any, integer|string?), callbackData: any)
---@nodiscard
function table.range(endingIndex, startingIndex, step, callback, callbackData) end

---Creates a new table from iterator. Supports iterators returning one or two values (if two values are returned, first is considered the key,
---if not, values are simply added to a list).
---@generic T
---@param iterator fun(...): T
---@return T[]
---@nodiscard
function table.build(iterator, k, v) end

--[[ common/internal.lua ]]

---Runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun()
---@param delay number? @Delay time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setTimeout(callback, delay, uniqueKey) end

---Repeteadly runs callback after certain time. Returns cancellation ID.
---Note: all callbacks will be ran before `update()` call,
---and they would only ran when script runs. So if your script is executed each frame and AC runs at 60 FPS, smallest interval
---would be 0.016 s, and anything lower that you’d set would still act like 0.016 s. Also, intervals would only be called once
---per frame.
---@param callback fun(): function? @Return `clearInterval` (actual function) to clear interval.
---@param period number? @Period time in seconds. Default value: 0.
---@param uniqueKey any? @Unique key: if set, timer wouldn’t be added unless there is no more active timers with such ID.
---@return integer
function setInterval(callback, period, uniqueKey) end

---Stops timeout. If called with an ID from `setInterval`, works as well.
---@param cancellationID integer @Value earlier retuned by `setTimeout()`. If a non-numerical value is passed (like a `nil`), call is ignored and returns `false`.
---@return boolean @True if timeout with such ID has been found and stopped.
function clearTimeout(cancellationID) end

---Stops interval. Return this value from a callback to cancel out an interval.
---If called with an ID from `setTimeout`, works as well.
---@param cancellationID integer @Value earlier retuned by `setInterval()`. If a non-numerical value is passed (like a `nil`), call is ignored and returns `false`.
---@return boolean @True if interval with such ID has been found and stopped.
function clearInterval(cancellationID) end

--[[ common/io.lua ]]

---Structure containing various file or directory attributes, including various flags and dates. All values are precomputed and ready to be used (there is
---no overhead in accessing them once you get the structure).
---@class io.FileAttributes
---@field fileSize integer @File size in bytes.
---@field creationTime integer @File creation time in seconds from 1970.
---@field lastAccessTime integer @File last access time in seconds from 1970.
---@field lastWriteTime integer @File last write time in seconds from 1970.
---@field exists boolean @True if file exists.
---@field isDirectory boolean @True if file is a directory.
---@field isHidden boolean @The file or directory is hidden. It is not included in an ordinary directory listing.
---@field isReadOnly boolean @A file that is read-only. Applications can read the file, but cannot write to it or delete it.
---@field isEncrypted boolean @A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.
---@field isCompressed boolean @A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.
---@field isReparsePoint boolean @A file or directory that has an associated reparse point, or a file that is a symbolic link.
---@field isArchive boolean @A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal. Added in CSP 0.3.0.
---@field isSystem boolean @A file or directory that the operating system uses a part of, or uses exclusively. Added in CSP 0.3.0.
---@field isTemporary boolean @A file that is being used for temporary storage. File systems avoid writing data back to mass storage if sufficient cache memory is available, because typically, an application deletes a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing the data. Otherwise, the data is written after the handle is closed. Added in CSP 0.3.0.
local _fileAttributes = {}

--[[ common/io.lua ]]

---@alias io.ZipEntry {filename: string}|{data: binary}|binary

---Scan directory and call callback function for each of files, passing file name (not full name, but only name of the file) and attributes. If callback function would return
---a non-nil value, iteration will stop and value returned by callback would return from this function. This could be used to
---find a certain file without going through all files in the directory. Optionally, a mask can be used to pre-filter received files
---entries.
---
---If callback function is not provided, it’ll return list of files instead (file names only).
---
---System entries “.” and “..” will not be included in the list of files. Accessing attributes does not add extra cost.
---@generic TCallbackData
---@generic TReturn
---@param directory string @Directory to look for files in. Note: directory is relative to current directory, not to script directory. For AC in general it’s an AC root directory, but do not rely on it, instead use `ac.getFolder(ac.FolderID.Root)`.
---@param mask string? @Mask in a form of usual “*.*”. Default value: '*'.
---@param callback fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: TCallbackData): TReturn? @Callback which will be ran for every file in directory fitting mask until it would return a non-nil value.
---@param callbackData TCallbackData? @Callback data that will be passed to callback as third argument, to avoid creating a capture.
---@return TReturn? @First non-nil value returned by callback.
---@overload fun(directory: string, callback: (fun(fileName: string, fileAttributes: io.FileAttributes, callbackData: any): any), callbackData: any): any
---@overload fun(directory: string, mask: string|nil): string[] @This overload just returns the list
function io.scanDir(directory, mask, callback, callbackData) end

--[[ common/os.lua ]]

---@class os.ConsoleProcessResult
---@field exitCode integer @If process finished successfully, 0. If failed to get the exit code, -1.
---@field stdout string @Contents of stdout stream of ran process.
---@field stderr string @Contents of stderr stream of ran process. Would be set only if `separateStderr` parameter was set to true.

--[[ common/os.lua ]]

---Module with additional functions to help deal with operating system.
os = {}

---Parse date and return a unix timestamp. Uses `std::get_time()` for actual parsing:
---<https://en.cppreference.com/w/cpp/io/manip/get_time>.
---@param date string @String containing date.
---@param format string? @Format string. Default value: `'%Y-%m-%dT%H:%M:%S'`.
---@return integer? @Returns `nil` if failed to parse.
function os.parseDate(date, format) end

---Opens regular Windows file opening dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: nil|string, folder: string, fileName: string, fileTypes: nil|{ name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.FileMustExist)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Open button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.openFileDialog(params, callback) end

---Opens regular Windows file saving dialog, calls callback with either an error or a path to a file selected by user
---(or nil if selection was cancelled). All parameters in `params` table are optional (the whole table too).
---@param params {title: string, defaultFolder: nil|string, defaultExtension: string, folder: string, fileName: string, saveAsItem: string, fileTypes: nil|{ name: string, mask: string }[], addAllFilesFileType: boolean, fileTypeIndex: integer, fileNameLabel: string, okButtonLabel: string, places: string[], flags: os.DialogFlags}|nil|`{defaultFolder = ac.getFolder(ac.FolderID.Root), fileTypes = {{name = 'Images', mask = '*.png;*.jpg;*.jpeg;*.bmp'}}, addAllFilesFileType = true, flags = bit.bor(os.DialogFlags.PathMustExist, os.DialogFlags.OverwritePrompt, os.DialogFlags.NoReadonlyReturn)}` "Table with properties:\n- `title` (`string`): Dialog title.\n- `defaultFolder` (`nil|string`): Default folder if there is not a recently used folder value available.\n- `defaultExtension` (`string`): Sets the default extension to be added to file names, with a dot in front.\n- `folder` (`string`): Selected folder (unlike `defaultFolder`, overrides recently used folder).\n- `fileName` (`string`): File name that appears in the File name edit box when that dialog box is opened.\n- `saveAsItem` (`string`): Ann item to be used as the initial entry in a Save As dialog.\n- `fileTypes` (`nil|{ name: string, mask: string }[]`): File types (names and masks).\n- `addAllFilesFileType` (`boolean`): If providing file types, set this to true to automatically add “All Files (*.*)” type at the bottom\n- `fileTypeIndex` (`integer`): File type selected by default (1-based).\n- `fileNameLabel` (`string`): Text of the label next to the file name edit box.\n- `okButtonLabel` (`string`): Text of the Save button.\n- `places` (`string[]`): Additional places to show in the list of locations on the left.\n- `flags` (`os.DialogFlags`): Dialog flags (use `bit.bor()` to combine flags together to avoid errors with adding same flag twice)"
---@param callback fun(err: string, filename: string)
function os.saveFileDialog(params, callback) end

---Run a console process in background with given arguments, return exit code and output in callback. Launched process will be tied
---to AC process to shut down with AC (works only on Windows 8 and newer).
---@param params {filename: string, arguments: string[], rawArguments: boolean, workingDirectory: string, timeout: integer, environment: table, inheritEnvironment: boolean, stdin: string, separateStderr: boolean, terminateWithScript: boolean|'disposable', assignJob: boolean, dataCallback: fun(err: boolean, data: string)}|`{ filename = '', arguments = {} }` "Table with properties:\n- `filename` (`string`): Application filename.\n- `arguments` (`string[]`): Arguments (quotes will be added automatically unless `rawArguments` is set to true).\n- `rawArguments` (`boolean`): Set to `true` to disable any arguments processing and pass them as they are, simply joining them with a space symbol.\n- `workingDirectory` (`string`): Working directory.\n- `timeout` (`integer`): Timeout in milliseconds. If above zero, process will be killed after given time has passed.\n- `environment` (`table`): If set to a table, values from that table will be used as environment variables instead of inheriting ones from AC process.\n- `inheritEnvironment` (`boolean`): Set to `true` to inherit AC environment variables before adding custom ones.\n- `stdin` (`string`): Optional data to pass to a process in stdin pipe.\n- `separateStderr` (`boolean`): Store stderr data in a separate string.\n- `terminateWithScript` (`boolean|'disposable'`): Terminate process if this Lua script were to terminate (for example, during reload). Since 0.2.10, pass `'disposable'` instead to get `ac.Disposable` back, allowing to terminate the process manually.\n- `assignJob` (`boolean`): Set to `false` to stop CSP from tying the process to AC process (doing so ensures child process would shut down with AC closing).\n- `dataCallback` (`fun(err: boolean, data: string)`): If set to a function, data written in stdout and stderr will be passed to the function instead as it arrives."
---@param callback nil|fun(err: string, data: os.ConsoleProcessResult)
function os.runConsoleProcess(params, callback) end

--[[ common/ac_enums.lua ]]

---@alias physics.ColliderType {type: string}

---Different collider types.
physics.Collider = {}

---Box collider.
---@param size vec3
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param up vec3? @Default value: `vec3(0, 1, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Box(size, offset, look, up, debug) end

---Sphere collider.
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Sphere(radius, offset, debug) end

---Capsule collider (like cylinder, but instead of flat caps it has hemispheres and works a bit faster).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Capsule(length, radius, offset, look, debug) end

---Cylinder collider (slower than capsule, consider using capsule where appropriate).
---@param length number
---@param radius number
---@param offset vec3? @Default value: `vec3(0, 0, 0)`.
---@param look vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Cylinder(length, radius, offset, look, debug) end

---Ray collider. Added in 0.3.0-preview121.
---@param length number
---@param origin vec3? @Default value: `vec3(0, 0, 0)`.
---@param dir vec3? @Default value: `vec3(0, 0, 1)`.
---@param debug boolean? @Set to `true` to see an outline. Default value: `false`.
---@return physics.ColliderType
function physics.Collider.Ray(length, origin, dir, debug) end

--[[ common/ac_extras_ini.lua ]]

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@param format ac.INIFormat 
---@param sections table 
---@return ac.INIConfig
function ac.INIConfig(format, sections) end

---A wrapper for data parsed from an INI files, supports different INI formats. Parsing is done on
---CSP side, rest is on CSP side. Use `:get()` and `:set()` methods to operate values.
---@class ac.INIConfig
---@field sections table<string, table<string, string[]>> @Sections storing actual data.
---@field format ac.INIFormat? @Format used when creating a config. Default value: `ac.INIFormat.Default`.
---@field filename string? @Optional filename for configs loaded from a file.
local _ac_INIConfig = nil

---Get value from parsed INI file. Note: getting vector values creates them anew, so if you’re going to use a value often, consider
---caching it locally.
---@generic T
---@param section string @Section name.
---@param key string @Value key.
---@param defaultValue T @Defines type of value to return, is returned if value is missing. If not set, list of strings is returned.
---@param offset integer? @Optional 1-based offset for data parsed in CSP format (in case value contains several items). Default value: 1.
---@return T
function _ac_INIConfig:get(section, key, defaultValue, offset) end

---Attempts to load a 1D-to-1D LUT from an INI file, supports both inline “(|X=Y|…|)” LUTs and separate files next to configs (only
---for configs loaded by filename or from car data)
---@return ac.DataLUT11? @Returns `nil` if there is no such key or no such file.
function _ac_INIConfig:tryGetLut(section, key) end

---Attempts to load a 2D-to-1D LUT from an INI file, supports both inline “(|X,Y=Z|…|)” LUTs and separate files next to configs (only
---for configs loaded by filename or from car data)
---@return ac.DataLUT21? @Returns `nil` if there is no such key or no such file.
function _ac_INIConfig:tryGet2DLut(section, key) end

---Iterates over sections of INI file with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, section in iniConfig:iterate('LIGHT') do
---  print('Color: '..iniConfig:get(section, 'COLOR', 'red'))
---end
---```
---@param prefix string @Prefix for section names.
---@param noPostfixForFirst boolean? @Only for default INI format. If set to `true`, first section would not have “_0” postfix.
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterate(prefix, noPostfixForFirst) end

---Iterates over values of INI section with a certain prefix. Order matches order of CSP parsing such data.
---
---Example:
---```
---for index, key in iniConfig:iterateValues('LIGHT_0', 'POSITION', true) do
---  print('Position: '..tostring(iniConfig:get('LIGHT_0', key, vec3())))
---end
---```
---@param prefix string @Prefix for section names.
---@param digitsOnly boolean? @If set to `true`, would only collect keys consisting of a prefix and a number (useful for configs with extra properties).
---@return fun(): integer?, string? @If you need a list instead of an iterator, use `table.build()`.
function _ac_INIConfig:iterateValues(section, prefix, digitsOnly) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param section string @Section name.
---@param defaults T @Table with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapSection(section, defaults) end

---Takes table with default values and returns a table with values filled from config.
---@generic T
---@param defaults T @Table with section names and sub-tables with keys and default values. Keys are the same as INI keys.
---@return T
function _ac_INIConfig:mapConfig(defaults) end

---Set an INI value. Pass `nil` as value to remove it.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:set(section, key, value) end

---Set an INI value and save file immediately using special old Windows function to edit a single INI value. Compatible only with default
---INI format. Doesn’t provide major peformance improvements, but might be useful if you prefer to keep original formatting as much as possible
---when editing a single value only.
---@param section string
---@param key string
---@param value string|string[]|number|boolean|nil|vec2|vec3|vec4|rgb|rgbm
---@return boolean @Returns `true` if new value is different and config was saved.
function _ac_INIConfig:setAndSave(section, key, value) end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_ini.lua ]]

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a boolean or, if it’s missing, `nil`.
ac.INIConfig.OptionalBoolean = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a number or, if it’s missing, `nil`.
ac.INIConfig.OptionalNumber = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a string or, if it’s missing, `nil`.
ac.INIConfig.OptionalString = {}

---Pass this as a `defaultValue` to `:get()` (or use it as a value in `:mapSection()`) to get either a list of original values or, if it’s missing, `nil`.
ac.INIConfig.OptionalList = {}

---Parse INI config from a string.
---@param data string @Serialized INI data.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@param includeFolders ('@cars'|'@tracks'|string)[]? @Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). Use special values `'@cars'` and `'@tracks'` for car or track configs.
---@return ac.INIConfig
function ac.INIConfig.parse(data, format, includeFolders) end

---Load INI file, optionally with includes.
---@param filename string @INI config filename.
---@param format ac.INIFormat? @Format to parse. Default value: `ac.INIFormat.Default`.
---@param includeFolders ('@cars'|'@tracks'|string)[]? @Optional folders to include files from (only for `ac.INIFormat.ExtendedIncludes` format). If not set, parent folder for config filename is used. Use special values `'@cars'` and `'@tracks'` for car or track configs.
---@return ac.INIConfig
function ac.INIConfig.load(filename, format, includeFolders) end

---Load car data INI file. Supports “data.acd” files as well. Returned files might be tweaked by
---things like custom physics virtual tyres. To get original file, use `ac.INIConfig.load()`.
---
---Returned file can’t be saved.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.carData(carIndex, fileName) end

---Load track data INI file. Can be used by track scripts which might not always  have access to those files directly.
---
---Returned file can’t be saved.
---@param fileName string @Car data file name, such as `'tyres.ini'`.
---@return ac.INIConfig
function ac.INIConfig.trackData(fileName) end

---Returns CSP config for a car. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.
---
---Returned file can’t be saved.
---@param carIndex number @0-based car index.
---@return ac.INIConfig
function ac.INIConfig.carConfig(carIndex) end

---Returns CSP config for a track. Might be slow: some of those configs are huge. Make sure to cache the resulting value if you need to reuse it.
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.trackConfig() end

---Returns config with extra online options, the ones that can be set with Content Manager.
---
---Returned file can’t be saved.
---@return ac.INIConfig|nil @If not an online session, returns `nil`.
function ac.INIConfig.onlineExtras() end

---Returns race config (`cfg/race.ini`). Password and online GUID won’t be included.
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.raceConfig() end

---Returns video config (`cfg/video.ini`).
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.videoConfig() end

---Returns controls config (`cfg/controls.ini`).
---
---Returned file can’t be saved.
---@return ac.INIConfig
function ac.INIConfig.controlsConfig() end

---Returns current setup INI file (either previously loaded or saved). Any changes in actual setup in pits won’t be reflected in the returned
---data unless file was saved.
---
---Returned file can be saved. Use `ac.onSetupFile()` to listen to data changes and either read extra data from setup file, or change the contents after file has been saved.
---@return ac.INIConfig
function ac.INIConfig.currentSetup() end

---Load config of a CSP module by its name.
---@param cspModuleID ac.CSPModuleID @Name of a CSP module.
---@return ac.INIConfig
function ac.INIConfig.cspModule(cspModuleID) end

---Load config of the current Lua script (“settings.ini” in script directory and settings overriden by user, meant to be customizable with Content Manager).
---@return ac.INIConfig
function ac.INIConfig.scriptSettings() end

---Serializes data in INI format using format specified on INIConfig creation. You can also use `tostring()` function.
---@return string
function _ac_INIConfig:serialize() end

---Saves contents to a file in INI form.
---@param filename string? @Filename. If filename is not set, saves file with the same name as it was loaded. Updates `filename` field.
---@return ac.INIConfig @Returns itself for chaining several methods together.
function _ac_INIConfig:save(filename) end

--[[ common/ac_extras_datalut.lua ]]

---Creates a new empty 1D-to-1D LUT. Use `ac.DataLUT11:add(input, output)` to fill it with data.
---@return ac.DataLUT11
function ac.DataLUT11() end

---Parse 1D-to-1D LUT from a string in “(|Input1=Output1|Input2=Output2|…|)” format.
---@param data string @Serialized LUT data.
---@return ac.DataLUT11
function ac.DataLUT11.parse(data) end

---Load 1D-to-1D LUT file.
---@param filename string @LUT filename.
---@return ac.DataLUT11
function ac.DataLUT11.load(filename) end

---Load car data 1D-to-1D LUT file. Supports “data.acd” files as well.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'power.lut'`.
---@return ac.DataLUT11
function ac.DataLUT11.carData(carIndex, fileName) end

---Creates a new empty 2D-to-1D LUT. Use `ac.DataLUT21:add(input, output)` to fill it with data.
---@return ac.DataLUT21
function ac.DataLUT21() end

---Parse 2D-to-1D LUT from a string in “(|X1,Y1=Output1|X2,Y2=Output2|…|)” format.
---@param data string @Serialized LUT data.
---@return ac.DataLUT21
function ac.DataLUT21.parse(data) end

---Load 2D-to-1D LUT file.
---@param filename string @LUT filename.
---@return ac.DataLUT21
function ac.DataLUT21.load(filename) end

---Load car data 2D-to-1D LUT file. Supports “data.acd” files as well.
---@param carIndex number @0-based car index.
---@param fileName string @Car data file name, such as `'speed_throttle.2dlut'`.
---@return ac.DataLUT21
function ac.DataLUT21.carData(carIndex, fileName) end

--[[ common/ac_extras_datalut.lua ]]

---Simple 1D-to-1D lookup table wrapper, helps to deal with all those “.lut“ files in car data.
---@class ac.DataLUT11
---@field useCubicInterpolation boolean @Set to `true` to use cubic interpolation. Default value: `false` (linear interpolation).
---@field extrapolate boolean @Set to `true` to extrapolate if requested value is outside of the data available.
local _ac_DataLUT11 = nil

---Add a new value to LUT.
---@param input number
---@param output number
---@return ac.DataLUT11 @Returns self for easy chaining.
function _ac_DataLUT11:add(input, output) end

---Returns data boundaries.
---@return vec2 @Minimum input and output.
---@return vec2 @Maximum input and output.
function _ac_DataLUT11:bounds() end

---Computes a LUT value using either linear or cubic interpolation (set field `ac.DataLUT11.useCubicInterpolation` to
---`true` to use cubic interpolation).
---@param input number
---@return number
function _ac_DataLUT11:get(input) end

---Returns input value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointInput(index) end

---Returns output value of a certain point of a LUT, or `math.nan` if there is no such point.
---@param index number @0-based index.
---@return number
function _ac_DataLUT11:getPointOutput(index) end

---Convert LUT into a string, either in a short (inlined, for an INI config) or long (for a separate file) format.
---@param longFormat boolean? @Set to `true` to use long format. Default value: `false`.
---@return string
function _ac_DataLUT11:serialize(longFormat) end

---Simple 2D-to-1D lookup table wrapper, helps to deal with all those “.2dlut“ files in car data. Tables can miss some values,
---such areas will be further interpolated.
---@class ac.DataLUT21
---@field useBicubicInterpolation boolean @Set to `true` to use bicubic interpolation. Default value: `false` (bilinear interpolation).
local _ac_DataLUT21 = nil

---Returns data boundaries.
---@return vec3 @Minimum input (X, Y) and output (Z).
---@return vec3 @Maximum input (X, Y) and output (Z).
function _ac_DataLUT21:bounds() end

---Add a new value to a 2D LUT.
---@param input vec2
---@param output number
---@return ac.DataLUT21 @Returns self for easy chaining.
function _ac_DataLUT21:add(input, output) end

---Computes a LUT value using either bilinear or bicubic interpolation (set field `ac.DataLUT21.useBicubicInterpolation` to
---`true` to use bicubic interpolation).
---@param input vec2
---@return number
function _ac_DataLUT21:get(input) end

---Convert LUT into a string in a short (inlined, for an INI config) format.
---@return string
function _ac_DataLUT21:serialize() end

--[[ common/ac_extras_connect.lua ]]

---Creates a new shared structure to quickly exchange data between different Lua scripts within a session. Example:
---```
---local sharedData = ac.connect{
---  ac.StructItem.key('myChannel'),        -- optional, to avoid collisions
---  someString = ac.StructItem.string(24), -- 24 is for capacity
---  someInt = ac.StructItem.int(),
---  someDouble = ac.StructItem.double(),
---  someVec = ac.StructItem.vec3()
---}
---```
---
---Note: to connect two scripts, both of them chould use `ac.connect()` and pass exactly the same layouts. Also, consider using more
---specific names to avoid possible unwanted collisions. For example, instead of using `value = ac.StructItem.int()` which might be
---used somewhere else, use `weatherBrightnessValue = ac.StructItem.int()`. Or, simply add `ac.StructItem.key('myUniqueKey')`.
---
---For safety reasons, car scripts can only connect to other car scripts, and track scripts can only connect to other track scripts.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@param keepLive boolean? @Set to true to keep structure even if any references were removed or script was unloaded.
---@param namespace nil|ac.SharedNamespace @Optional namespace stopping scripts of certain types to access data of scripts with different types. For more details check `ac.SharedNamespace` documentation.
---@return T
function ac.connect(layout, keepLive, namespace) end

---Create a new struct from a given layout. Could be used in calls like `ac.structBytes()` and `ac.fillStructWithBytes()`. Each call defines and creates a new struct, so don’t
---call them each frame, I believe LuaJIT doesn’t do garbage collection on struct definitions.
---@generic T
---@param layout T
---@param compact boolean?
---@return T
---@return integer @Structure size.
---@return string @Structure name.
function ac.StructItem.combine(layout, compact) end

--[[ common/ac_struct_item.lua ]]

---Helper to define structures in a safe and secure manner. Create a new table and use values returned
---by these methods as values and pass it to `ac.connect()` or `ac.registerOnlineMessageType()`.
---
---Few notes:
---- Don’t worry about order, elements will be reordered automatically (also, if using associative table
---  in Lua, order would not be strictly defined anyway);
---- If you want to make sure to avoid possible collisions (those functions use format of layout for identifying
---  structures and establishing connections), use `ac.StructItem.key('myOwnUniqueThing')`;
---- If you want to save space (for example, with online messages), there are virtual types `.norm…` and `.unorm…`
---  which would give you floating point values from -1 to 1 (or for 0 to 1 for .unorm… variants), but use 8-bit
---  and 16-bit values for storing, they could help. Also make sure to limit capacity of your strings as much as
---  possible;
---- When accessing string, its checksum will be calculated and compared with checksum of previously accessed value,
---  thus avoiding creating new entities when unnecessary. While it helps with GC, it could incur some overhead
---  on accessing values, so if you need to access string numerous times (let’s say, in a loop), consider copying
---  a reference to it locally.
ac.StructItem = {}

---Adds a key to a structure to ensure its uniqueness. Consider using something like “yourUsername.yourContentID” or something
---like that for a key, so that your data would not interfere with data from Lua scripts written by other developers. Note:
---if you’re exchanging data between physics and graphics thread in your car, you might have to append `car.index` to there as
---well so that different cars would have either own data things.
---@return nil
function ac.StructItem.key(key) end

---Enables explicit ordering for your structures.
---By default, CSP will reorder fields in your structures for optimal data packing. Because all scripts written in Lua share the same algorithm,
---it’s all fine and good, but if you want for your script to exchange data with other programs, explicit order would work much better.
---@param alignment integer? @Optional override for alignment of child structures.
---@param packing integer? @Optional overrider for packing of fields.
---@return nil
function ac.StructItem.explicit(alignment, packing) end

---@return number
function ac.StructItem.half() end

---@return number
function ac.StructItem.float() end

---@return number
function ac.StructItem.double() end

---@return number
function ac.StructItem.norm8() end

---@return number
function ac.StructItem.unorm8() end

---@return number
function ac.StructItem.norm16() end

---@return number
function ac.StructItem.unorm16() end

---@return integer
function ac.StructItem.int16() end

---@return integer
function ac.StructItem.uint16() end

---@return integer
function ac.StructItem.int32() end

---@return integer
function ac.StructItem.uint32() end

---@return integer
function ac.StructItem.int64() end

---@return integer
function ac.StructItem.uint64() end

---@return boolean
function ac.StructItem.boolean() end

---Same as `ac.StructItem.int8()`.
---@return integer
function ac.StructItem.char() end

---Same as `ac.StructItem.uint8()`.
---@return integer
function ac.StructItem.byte() end

---@return integer
function ac.StructItem.int8() end

---@return integer
function ac.StructItem.uint8() end

---@return vec2
function ac.StructItem.vec2() end

---@return vec3
function ac.StructItem.vec3() end

---@return vec4
function ac.StructItem.vec4() end

---@return rgb
function ac.StructItem.rgb() end

---@return rgbm
function ac.StructItem.rgbm() end

---@return hsv
function ac.StructItem.hsv() end

---@return quat
function ac.StructItem.quat() end

---@generic T
---@param elementType T
---@param size integer
---@return T[]
function ac.StructItem.array(elementType, size) end

---@generic T
---@param fields T
---@return T
function ac.StructItem.struct(fields) end

---@param capacity integer? @Maximum string capacity. Default value: 32.
---@return string
function ac.StructItem.string(capacity) end

---@return mat3x3
function ac.StructItem.mat3x3() end

---@return mat4x4
function ac.StructItem.mat4x4() end

---Matrix packed to 6, 9 or 12 bytes (depending on settings).
---
---Note: to update value you need to use assignment operator (`.field = newValue`), altering matrix of this property with methods like
---`:mulSelf()` only changes unpacked value on your side, but not the actual structure value.
---@param compactPosition boolean? @If `true`, position is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.
---@param compactRotation boolean? @If `true`, rotation is packed into 3 bytes, otherwise it will take 6 bytes. Default value: `false`.
---@param rangeFrom number|vec3? @Minimal expected position. Pass it together with `rangeTo` to encode position data more efficiently.
---@param rangeTo number|vec3? @Maximum expected position. Pass it together with `rangeFrom` to encode position data more efficiently.
---@return mat4x4
function ac.StructItem.transform(compactPosition, compactRotation, rangeFrom, rangeTo) end

---Simply create a new FFI structure with a given layout. Doesn’t connect to anything.
---@generic T
---@param layout T @A table containing fields of structure and their types. Use `ac.StructItem` methods to select types. Alternatively, you can pass a string for the body of the structure here, but be careful with it.
---@return T
function ac.StructItem.build(layout) end

--[[ common/ac_extras_hashspace.lua ]]

---@param cellSize number @Should be about twice as large as your largest entity.
---@return ac.HashSpace
function ac.HashSpace(cellSize) end

--[[ common/ac_extras_numlut.lua ]]

---@param data string @String with LUT data, in a format similar to AC LUT formats. Please note: rows must be ordered for efficient binary search.
---@param hsvColumns integer[] @1-based indices of columns storing HSV data. Such columns, of course, will be interpolated differently (for example, mixing hues 350 and 20 would produce 10).
---@return ac.Lut
function ac.Lut(data, hsvColumns) end

---@type ac.Lut
ac.LutCpp = ac.Lut

---Creates new ac.LuaJit instance. Deprecated and broken, use `ac.Lut` instead.
---@deprecated
---@param data any
---@param hsvRows integer[] @ 1-based indices of columns (not rows) storing HSV values in them.
---@return table
function ac.LutJit:new(o, data, hsvRows) end

--[[ common/ac_extras_connectmmf.lua ]]

---Opens shared memory file for reading. Do not attempt to modify any of its contents: doing so pretty much always would result in Assetto Corsa
---just straight up crashing.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@param persist boolean? @Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.
---@return T
---@overload fun(filename: string, layout: string, persist: boolean?): any
function ac.readMemoryMappedFile(filename, layout, persist) end

---Opens shared memory file for writing. Note: if the file would exist at the moment of opening (for example, created before by a different
---Lua script, or by a separate process), it would retain its current state, but if it’s a new file, it’ll be initialized with all zeroes.
---@generic T
---@param filename string @Shared memory file filename (without “Local\” bit).
---@param layout T @String for the body of the structure.
---@param persist boolean? @Keep file alive even after the script stopped or the variable was cleared by garbage collector. Default value: `false`.
---@return T
---@overload fun(filename: string, layout: string, persist: boolean?): any
function ac.writeMemoryMappedFile(filename, layout, persist) end

---Forcefully closes memory mapped file opened either for reading or writing without waiting for GC to pick it up.
function ac.disposeMemoryMappedFile(reference) end

--[[ common/ac_general_utils.lua ]]

---Estimates lap time and sector times for main car using AC function originally used by Time Attack mode. Could be
---helpful in creating custom time attack modes. Uses “ideal_line.ai” from “track folder/data”, so might not work
---well with mods. If that file is missing, returns nil.
---@return {lapTimeMs: integer, sectorTimesMs: integer[]}|nil @Returns table with times in milliseconds, or `nil` if  “ideal_lane.ai” is missing.
function ac.evaluateLapTime() end

--[[ common/ac_storage.lua ]]

---@class ac.StoredValue
local _ac_StoredValue = {}

---@return string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:get() end

---@param value string|number|boolean|vec2|vec3|vec4|rgb|rgbm
function _ac_StoredValue:set(value) end

---@type table<string, string>
ac.storage = {}

---Storage function. Easiest way to use is to pass it a table with default values — it would give you a table back
---which would load values on reads and save values on writes. Values have to be either strings, numbers, booleans,
---vectors or colors. Example:
---```
---local storedValues = ac.storage{
---  someKey = 15,
---  someStringValue = 20
---}
---storedValues.someKey = 20
---```
---Alternatively, you can use it as a function which would take a key and a default value and return you an
---`ac.StoredValue` wrapper with methods `:get()` and `:set(newValue)`:
---```
---local stored = ac.storage('someKey', 15)
---stored:get()
---stored:set(20)
---```
---Or, just access it directly in `localStorage` style of JavaScript. Similar to JavaScript, this way you can only store
---strings:
---```
---ac.storage.key = 'value'
---ac.debug('loaded', ac.storage.key)
---```
---Data will be saved in “Documents\Assetto Corsa\cfg\extension\state\lua”, in corresponding subfolder. Actual writing
---will happen a few seconds after new value was pushed, and only if value was changed, so feel free to use this function
---to write things often.
---@generic T
---@param layout T
---@param keyPrefix string|nil @Optional parameter for adding a prefix to keys.
---@return T
---@overload fun(key: string, value: string|number|boolean|vec2|vec3|vec4|rgb|rgbm): ac.StoredValue
function ac.storage(layout, keyPrefix) end

--[[ common/ac_storage.lua ]]

---Checks if storage table created by `ac.storage(table)` has a certain key or not.
---@param storage any
---@param key string
---@return boolean
function ac.storageHasKey(storage, key) end

---Returns `true` if any storage value has changed since the previous call.
---@return boolean
function ac.storageChanged() end

--[[ common/ac_configs.lua ]]

---@class ac.ConfigProvider
local _ac_ConfigProvider = {}

---@param section string
---@param key string
---@param defaultValue boolean|nil
---@return boolean
function _ac_ConfigProvider.bool(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue number
---@return number
function _ac_ConfigProvider.number(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue string|nil
---@return string
function _ac_ConfigProvider.string(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgb|nil
---@return rgb
function _ac_ConfigProvider.rgb(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue rgbm|nil
---@return rgbm
function _ac_ConfigProvider.rgbm(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec2|nil
---@return vec2
function _ac_ConfigProvider.vec2(section, key, defaultValue) end
---@param section string
---@param key string
---@param defaultValue vec3|nil
---@return vec3
function _ac_ConfigProvider.vec3(section, key, defaultValue) end

---@param section string
---@param key string
---@param defaultValue vec4|nil
---@return vec4
function _ac_ConfigProvider.vec4(section, key, defaultValue) end

---Reads a value from the config of currently loaded track. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called without arguments, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(): ac.ConfigProvider
function ac.getTrackConfig(section, key, defaultValue) end

---Reads a value from the config of a car. To use it, you need to specify `defaultValue` value, it would be used to determine
---the type of the value you need (and would be returned if value in config is missing).
---
---Alternatively, if called with car index only, returns ac.ConfigProvider which then can be used to access
---values in a typed manner. For it, `defaultValue` is optional.
---@generic T
---@param carIndex integer @0-based car index.
---@param section string @Section name in config (the one in square brackets).
---@param key string @Config key (value before “=” sign).
---@param defaultValue T @Value that’s returned as a result if value is missing. Also determines the type needed.
---@return T
---@overload fun(carIndex: integer): ac.ConfigProvider
function ac.getCarConfig(carIndex, section, key, defaultValue) end

--[[ common/ac_reftypes.lua ]]

---Stores a boolean value and can be used as a reference to it.
---@param value boolean "Stored value."
---@return refbool
function refbool(value) end

---Stores a boolean value and can be used as a reference to it.
---@class refbool
---@field value boolean @Stored value.
local refbool = nil

---@return boolean
function refbool.isrefbool(x) end

---For easier use with UI controls.
---@param newValue boolean|`true`|`false`
---@return refbool
function refbool:set(newValue) end

---Stores a numerical value and can be used as a reference to it.
---@param value number "Stored value."
---@return refnumber
function refnumber(value) end

---Stores a numerical value and can be used as a reference to it.
---@class refnumber
---@field value number @Stored value.
local refnumber = nil

---@return boolean
function refnumber.isrefnumber(x) end

---For easier use with UI controls.
---@param newValue number
---@return refnumber
function refnumber:set(newValue) end

--[[ common/ac_web.lua ]]

---@class WebResponse
---@field status integer
---@field headers table<string, string>
---@field body string
---@field certificate string? @Set `[':https-certificate'] = true` header to get hex-encoded SHA-256 fingerprint of the HTTPS certificate (or fail if HTTPS is not used). Disables caching. Alternatively, set `[':https-certificate'] = 'SHA256_GOES_HERE'` to add a simple direct fingerprint test without disabling cache. Fingerprints match those reported by Firefox as SHA-256 fingerprint. You can also specify this header (with a value) for `web.loadRemote…` functions.
local _webResponse = {}

---Two possible ways to present payload: either as a string with data, or a table with a key `'filename'`.
---Second way can be used as a shortcut for `io.loadAsync()` (it loads data asyncronously).
---Data string can contain zeroes.
---@alias WebPayload string|{filename: string}

--[[ common/ac_web.lua ]]

---Web module.
web = {}

---Configures timeouts in milliseconds for the following web requests. If you’re sure in your server, consider lowering timeouts so that
---in a case of a missing internet connection it wouldn’t take forever to determine the issue. Parameters will be passed to `WinHttpSetTimeouts()`
---function (https://learn.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpsettimeouts).
---@param resolve integer? @Time in milliseconds for DNS resolve, 0 to disable timeout. Default value: 4000 ms.
---@param connect integer? @Time in milliseconds for establishing connection. Default value: 10000 ms.
---@param send integer? @Time in milliseconds for sending data. Default value: 30000 ms.
---@param receive integer? @Time in milliseconds for receiving data. Default value: 30000 ms.
function web.timeouts(resolve, connect, send, receive) end

---Sends a GET HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method). Another special key added in 0.2.10 is `[':https-certificate'], see `WebResponse` docs for more info.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.get(url, headers, callback) end

---Sends a POST HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload? @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(url: string, callback: fun(err: string, response: WebResponse))
function web.post(url, headers, data, callback) end

---Sends a custom HTTP or HTTPS request. Note: you can only have two requests running at once, mostly to make sure
---a faulty script wouldn’t spam a remote server or overload internet connection (that’s how I lost access
---to one of my API tokens for some time, accidentally sending a request each frame).
---@param method "'GET'"|"'POST'"|"'PUT'"|"'HEAD'"|"'DELETE'"|"'PATCH'"|"'OPTIONS'" @HTTP method.
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers. Use special `[':headers-only'] = true` header if you only need to load headers (for servers without proper support of HEAD method).
---@param data WebPayload? @Optional data.
---@param callback fun(err: string, response: WebResponse)
---@overload fun(method: string, url: string, data: string, callback: fun(err: string, response: WebResponse))
---@overload fun(method: string, url: string, callback: fun(err: string, response: WebResponse))
function web.request(method, url, headers, data, callback) end

---@alias web.SocketParams {onError: nil|fun(err: string), onClose: nil|fun(reason: string?), encoding: nil|'binary'|'utf8'|'json'|'lson', reconnect: boolean?} ---Use property `reconnect` to automatically try and restore connection a few seconds after it got lost. With it, `onError` might be called multiple times, but `onClose` is only called once connection is closed by calling `web.Socket.close()`.
---@alias web.Socket {close: fun()}|fun(data: binary)

---Open a WebSocket connection.
---@param url string @URL.
---@param headers table<string, string|number|boolean>? @Optional headers.
---@param callback nil|fun(data: binary)
---@param params web.SocketParams?
---@return web.Socket
---@overload fun(url: string, callback: fun(data: binary), params: web.SocketParams): web.Socket
function web.socket(url, headers, callback, params) end

--[[ common/stringify.lua ]]

---Serialize Lua value (table, number, string, etc.) in a Lua table format (similar to how `JSON.stringify` in JavaScript
---generates a thing with JavaScript syntax). Format seems to be called Luaon. Most of Lua entities are supported, including array-like tables, table
---tables and mixed ones. CSP API things, such as vectors or colors, are also supported. For things like threads,
---functions or unknown cdata types instead a placeholder object will be created.
---
---Circular references also result in creating similar objects, for example: `t = {1, 2, 3, t}` would result in
---`{ 1, 2, 3, { type = 'circular reference' } }`.
---
---If any table in given data would have a `__stringify()` function, it would be called as a method (so first argument
---would be the table with `__stringify` itself). If that function would return a string, that string will be used
---instead of regular table serialization. The idea is for classes to define a method like this and output a line of code
---which could be used to create a new instance like this on deserialization. Note: for such like to use a custom function
---like a class constructor, you would either need to register that function with a certain name or provide a table referring
---to it on deserialization. That’s because although deserialization uses `load()` function to parse and run data as Lua code,
---it wouldn’t allow code to access existing functions by default.
---@param obj table|number|string|boolean|nil @Object to serialize.
---@param compact boolean? @If true, resulting string would not have spaces and line breaks, slightly faster and a lot more compact.
---@param depthLimit integer? @Limits how deep serialization would go. Default value: 20.
---@return string @String with input data presented in Lua syntax.
function stringify(obj, compact, depthLimit) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Would raise an error if failed to parse or if any of initializers would raise an error.
---@param serialized string @Serialized data.
---@param namespace table|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@return table|number|string|boolean|nil
function stringify.parse(serialized, namespace) end

---Parse a string with Lua table syntax into a Lua object (table, number, string, vector, etc.), can support custom objects as well.
---Only functions from `namespace` can be used (as well as vectors and functions registered earlier with `stringify.register()`),
---so if you’re using custom classes, make sure to either register them earlier or pass them in `namespace` table. Alternatively,
---you can just pass `_G` as `namespace`, but it might be pretty unsecure, so maybe don’t do it.
---
---Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.
---@generic T
---@param serialized string? @Serialized data.
---@param namespace table|nil @Namespace table. Serialized data would be evaluated as Lua code and would have access to it.
---@param fallback T|nil @Value to return if parsing failed.
---@return T
function stringify.tryParse(serialized, namespace, fallback) end

---Registers a new initializer function with a given name.
---@param name string @Name of an initializer (how serialized data would refer to it).
---@param fn function @Initializer function (returning value for serialized data to use).
---@overload fun(class: ClassDefinition)
function stringify.register(name, fn) end

---Serialization substep. Works similar to `stringify()` itself, but instead of returning string simply adds new terms to
---`out` table. Use it in custom `__stringify` methods for serializing child items if you need the best performance.
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
function stringify.substep(out, ptr, obj, lineBreak, depthLimit) end

---Different serializer, produces binary data instead of human-readable. Faster and with even more compact output, but not human-readable.
---@param obj table|number|string|boolean|nil @Object to serialize.
---@return string @String with input data presented in binary format, so it won’t be readable and will contain zero bytes.
function stringify.binary(obj) end

---Parses binary data prepared with `stringify.binary()`.
---@param serialized string @Serialized data.
---@return table|number|string|boolean|nil
function stringify.binary.parse(serialized) end

---Tries to parse binary data prepared with `stringify.binary()`.
---
---Returns fallback value if failed to parse, or if `serialized` is empty or not set, or if any of initializers would raise an error.
---@generic T
---@param serialized string? @Serialized data.
---@param fallback T|nil @Value to return if parsing failed.
---@return T
function stringify.binary.tryParse(serialized, fallback) end

---A small helper to add as a parent class for EmmyLua to work better.
---@class ClassStringifiable : ClassBase
local _classStringifiable = {}

---Serialize instance of class. Can either return a `string`, or construct it into `out` table and return a new position in it. String itself should be a like of
---Lua code which would reconstruct the object on deserialization. Don’t forget to either register referred function with `stringify.register()` or provide
---a reference to it in `namespace` table with `stringify.parse()`.
---
---Note: to serialize sub-objects, such as constructor arguments, you can use `stringify()` or `stringify.substep()` if you’re using an approach with
---manually constructing `out` table. Alternatively for basic types you can use `string.format()`: “%q” would give you a string in Lua format, so you can use it
---like so:
---```
---function MyClass:__serialize()
---  return string.format('MyClass(%q, %s)', self.stringName, self.numericalCounter)
---end
---```
---@param out string[] @Output table with words to concatenate later (without any joining string).
---@param ptr integer @Position within `out` table to write next word into. At the very start, when table is empty, it would be 1.
---@param obj any @Item to serialize.
---@param lineBreak string|nil @Line break with some spaces for aligning child items, or `nil` if compact stringify mode is used. One tab is two spaces.
---@param depthLimit integer @Limits how many steps down serialization can go. If 0 or below, no tables would be serialized.
---@return integer @Updated `ptr` value (if one item was added to `out`, should increase by 1).
---@overload fun(): string @Simpler version which should work well in 98% of times. Use a more detailed one only if you have a ton of objects and need to improve performance.
function _classStringifiable:__stringify(out, ptr, obj, lineBreak, depthLimit) end

--[[ common/json.lua ]]

---Very basic JSON processing library. Based on json.lua by rxi, but a bit simplified and streamlined.
---In case you need to store and load data within Lua scripts, consider using `stringify()` and 
---`stringify.parse()` instead: it’s faster and more reliable.
JSON = {}

---Serializes a Lua entity (like a table) into a compact JSON.
---@param data table|number|string|boolean|nil
---@return string
function JSON.stringify(data) end

---Parses a compact JSON into a Lua entity. Note: if JSON is damaged, parser won’t throw an error, but
---results might be somewhat unpredictable. It’s an intended behaviour: in 99% of cases JSON parser
---used to exchange data with, for example, API endpoints, will receive correct data, but some of those
---AC JSON files are pretty screwed and often include things like missing commas, comments, etc.
---@param data string?
---@return any
function JSON.parse(data) end

--[[ common/ac_primitive_vec2.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec2(x, y)` directly, but the way LuaJIT works,
---that call only works with two numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec2): vec2
---@overload fun(tableOfTwo: number[]): vec2
---@overload fun(value: number): vec2
---@overload fun(value: string): vec2
---@param x? number
---@param y? number
---@return vec2
function vec2.new(x, y) end

---Checks if value is vec2 or not.
---@param p any
---@return boolean
function vec2.isvec2(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec2
function vec2.tmp() end

---Intersects two line segments, one going from `p1` to `p2` and another going from `p3` to `p4`. Returns intersection point or `nil` if there is no intersection.
---@return vec2?
function vec2.intersect(p1, p2, p3, p4) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@return vec2
function vec2(x, y) end

---Two-dimensional vector. All operators are overloaded. Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec2()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec2()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec2
---@field x number
---@field y number
---@operator add(number|vec2): vec2
---@operator sub(number|vec2): vec2
---@operator mul(number|vec2): vec2
---@operator div(number|vec2): vec2
---@operator pow(number|vec2): vec2
---@operator len: number
---@operator unm: vec2
local vec2 = nil

---Makes a copy of a vector.
---@return vec2
function vec2:clone() end

---Unpacks vec2 into two numbers.
---@return number, number
function vec2:unpack() end

---Turns vec2 into a table with two values.
---@return number[]
function vec2:table() end

---Returns reference to vec2 class.
function vec2:type() end

---@param x vec2|number
---@param y number?
---@return vec2 @Returns itself.
function vec2:set(x, y) end

---@param vec vec2
---@param scale number
---@return vec2 @Returns itself.
function vec2:setScaled(vec, scale) end

---@param value1 vec2
---@param value2 vec2
---@param mix number
---@return vec2 @Returns itself.
function vec2:setLerp(value1, value2, mix) end

---Copies its values to a different vector.
---@param out vec2
---@return vec2 @Returns itself.
function vec2:copyTo(out) end

---@param valueToAdd vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:add(valueToAdd, out) end

---@param valueToAdd vec2
---@param scale number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:div(valueToDivideBy, out) end

---@param exponent vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:pow(exponent, out) end

---@param multiplier number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:scale(multiplier, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:min(otherValue, out) end

---@param otherValue vec2|number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:max(otherValue, out) end

---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:saturate(out) end

---@param min vec2
---@param max vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:clamp(min, max, out) end

---@return number
function vec2:length() end

---@return number
function vec2:lengthSquared() end

---@param otherVector vec2
---@return number
function vec2:distance(otherVector) end

---@param otherVector vec2
---@return number
function vec2:distanceSquared(otherVector) end

---@param otherVector vec2
---@param distanceThreshold number
---@return boolean
function vec2:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec2
---@return number @Radians.
function vec2:angle(otherVector) end

---@param otherVector vec2
---@return number
function vec2:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec2
---@param mix number
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec2
---@param out vec2|nil @Optional destination argument.
---@return vec2 @Returns itself or out value.
function vec2:project(otherVector, out) end

--[[ common/ac_primitive_vec3.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec3(x, y, z)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec3): vec3
---@overload fun(tableOfThree: number[]): vec3
---@overload fun(value: number): vec3
---@overload fun(value: string): vec3
---@param x number?
---@param y number?
---@param z number?
---@return vec3
function vec3.new(x, y, z) end

---Checks if value is vec3 or not.
---@param p any
---@return boolean
function vec3.isvec3(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec3
function vec3.tmp() end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@return vec3
function vec3(x, y, z) end

---Three-dimensional vector. All operators are overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec3()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec3()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec3
---@field x number
---@field y number
---@field z number
---@operator add(number|vec3): vec3
---@operator sub(number|vec3): vec3
---@operator mul(number|vec3): vec3
---@operator div(number|vec3): vec3
---@operator pow(number|vec3): vec3
---@operator len: number
---@operator unm: vec3
local vec3 = nil

---Makes a copy of a vector.
---@return vec3
function vec3:clone() end

---Unpacks vec3 into three numbers.
---@return number, number, number
function vec3:unpack() end

---Turns vec3 into a table with three values.
---@return number[]
function vec3:table() end

---Returns reference to vec3 class.
function vec3:type() end

---@param x vec3|number
---@param y number?
---@param z number?
---@return vec3 @Returns itself.
function vec3:set(x, y, z) end

---@param vec vec3
---@param scale number
---@return vec3 @Returns itself.
function vec3:setScaled(vec, scale) end

---@param value1 vec3
---@param value2 vec3
---@param mix number
---@return vec3 @Returns itself.
function vec3:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec3
---@param value2 vec3
---@return vec3 @Returns itself.
function vec3:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec3
---@return vec3 @Returns itself.
function vec3:copyTo(out) end

---@param valueToAdd vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:add(valueToAdd, out) end

---@param valueToAdd vec3
---@param scale number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:div(valueToDivideBy, out) end

---@param exponent vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:pow(exponent, out) end

---@param multiplier number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:scale(multiplier, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:min(otherValue, out) end

---@param otherValue vec3|number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:max(otherValue, out) end

---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:saturate(out) end

---@param min vec3
---@param max vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:clamp(min, max, out) end

---@return number
function vec3:length() end

---@return number
function vec3:lengthSquared() end

---@param otherVector vec3
---@return number
function vec3:distance(otherVector) end

---@param otherVector vec3
---@return number
function vec3:distanceSquared(otherVector) end

---@param otherVector vec3
---@param distanceThreshold number
---@return boolean
function vec3:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec3
---@return number @Radians.
function vec3:angle(otherVector) end

---@param otherVector vec3
---@return number
function vec3:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:normalize(out) end

---Rewrites own values with values of cross product of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:cross(otherVector, out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec3
---@param mix number
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec3
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:project(otherVector, out) end

---Rewrites own values with values of itself rotated with quaternion (unless different `out` is provided).
---@param quaternion quat
---@param out vec3|nil @Optional destination argument.
---@return vec3 @Returns itself or out value.
function vec3:rotate(quaternion, out) end

---Returns distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLine(a, b) end

---Returns squared distance from point to a line. For performance reasons doesn’t do any checks, so be careful with incoming arguments.
---@return number
function vec3:distanceToLineSquared(a, b) end

--[[ common/ac_primitive_vec4.d.lua ]]

---Creates new vector. It’s usually faster to create a new item with `vec4(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: vec4): vec4
---@overload fun(tableOfFour: number[]): vec4
---@overload fun(value: number): vec4
---@overload fun(value: string): vec4
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return vec4
function vec4.new(x, y, z, w) end

---Checks if value is vec4 or not.
---@param p any
---@return boolean
function vec4.isvec4(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return vec4
function vec4.tmp() end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return vec4
function vec4(x, y, z, w) end

---Four-dimensional vector. All operators are also overloaded.
---Note: creating a lot of new vectors can create extra work for garbage collector reducing overall effectiveness.
---Where possible, instead of using mathematical operators consider using methods altering state of already existing vectors. So, instead of:
---```
---someVec = vec4()
---…
---someVec = math.normalize(vec1 + vec2) * 10
---```
---Consider rewriting it like:
---```
---someVec = vec4()
---…
---someVec:set(vec1):add(vec2):normalize():scale(10)
---```
---@class vec4
---@field x number
---@field y number
---@field z number
---@field w number
---@operator add(number|vec4): vec4
---@operator sub(number|vec4): vec4
---@operator mul(number|vec4): vec4
---@operator div(number|vec4): vec4
---@operator pow(number|vec4): vec4
---@operator len: number
---@operator unm: vec4
local vec4 = nil

---Makes a copy of a vector.
---@return vec4
function vec4:clone() end

---Unpacks vec4 into four numbers.
---@return number, number, number, number
function vec4:unpack() end

---Turns vec4 into a table with four values.
---@return number[]
function vec4:table() end

---Returns reference to vec4 class.
function vec4:type() end

---@param x vec4|number
---@param y number?
---@param z number?
---@param w number?
---@return vec4 @Returns itself.
function vec4:set(x, y, z, w) end

---@param vec vec4
---@param scale number
---@return vec4 @Returns itself.
function vec4:setScaled(vec, scale) end

---@param value1 vec4
---@param value2 vec4
---@param mix number
---@return vec4 @Returns itself.
function vec4:setLerp(value1, value2, mix) end

---Sets itself to a normalized result of cross product of value1 and value2.
---@param value1 vec4
---@param value2 vec4
---@return vec4 @Returns itself.
function vec4:setCrossNormalized(value1, value2) end

---Copies its values to a different vector.
---@param out vec4
---@return vec4 @Returns itself.
function vec4:copyTo(out) end

---@param valueToAdd vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:add(valueToAdd, out) end

---@param valueToAdd vec4
---@param scale number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:sub(valueToSubtract, out) end

---@param valueToMultiplyBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:div(valueToDivideBy, out) end

---@param exponent vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:pow(exponent, out) end

---@param multiplier number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:scale(multiplier, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:min(otherValue, out) end

---@param otherValue vec4|number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:max(otherValue, out) end

---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:saturate(out) end

---@param min vec4
---@param max vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:clamp(min, max, out) end

---@return number
function vec4:length() end

---@return number
function vec4:lengthSquared() end

---@param otherVector vec4
---@return number
function vec4:distance(otherVector) end

---@param otherVector vec4
---@return number
function vec4:distanceSquared(otherVector) end

---@param otherVector vec4
---@param distanceThreshold number
---@return boolean
function vec4:closerToThan(otherVector, distanceThreshold) end

---@param otherVector vec4
---@return number @Radians.
function vec4:angle(otherVector) end

---@param otherVector vec4
---@return number
function vec4:dot(otherVector) end

---Normalizes itself (unless different `out` is provided).
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:normalize(out) end

---Rewrites own values with values of lerp of itself and other vector (unless different `out` is provided).
---@param otherVector vec4
---@param mix number
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:lerp(otherVector, mix, out) end

---Rewrites own values with values of projection of itself onto another vector (unless different `out` is provided).
---@param otherVector vec4
---@param out vec4|nil @Optional destination argument.
---@return vec4 @Returns itself or out value.
function vec4:project(otherVector, out) end

--[[ common/ac_primitive_rgb.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgb(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with three numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgb): rgb
---@overload fun(color: rgbm): rgb
---@overload fun(color: hsv): rgb
---@overload fun(color: vec4): rgb
---@overload fun(color: vec3): rgb
---@overload fun(tableOfThree: number[]): rgb
---@overload fun(color: number): rgb
---@overload fun(value: string): rgb
---@param r number?
---@param g number?
---@param b number?
---@return rgb
function rgb.new(r, g, b, m) end

---Checks if value is rgb or not.
---@param p any
---@return boolean
function rgb.isrgb(p) end

---Temporary color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgb
function rgb.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255
---@param g number @From 0 to 255
---@param b number @From 0 to 255
---@return rgb
function rgb.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgb.colors = { transparent = rgb(0, 0, 0), black = rgb(0, 0, 0), silver = rgb(0.75, 0.75, 0.75), gray = rgb(0.5, 0.5, 0.5), white = rgb(1, 1, 1), maroon = rgb(0.5, 0, 0), red = rgb(1, 0, 0), purple = rgb(0.5, 0, 0.5), fuchsia = rgb(1, 0, 1), green = rgb(0, 0.5, 0), lime = rgb(0, 1, 0), olive = rgb(0.5, 0.5, 0), yellow = rgb(1, 1, 0), orange = rgb(1, 0.5, 0), navy = rgb(0, 0, 0.5), blue = rgb(0, 0, 1), teal = rgb(0, 0.5, 0.5), cyan = rgb(0, 0.5, 1), aqua = rgb(0, 1, 1) }

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@return rgb
function rgb(r, g, b) end

---Three-channel color. All operators are overloaded. White is usually `rgb=1,1,1`.
---@class rgb
---@field r number
---@field g number
---@field b number
---@operator add(number|rgb): rgb
---@operator sub(number|rgb): rgb
---@operator mul(number|rgb): rgb
---@operator div(number|rgb): rgb
---@operator pow(number|rgb): rgb
---@operator len: number
---@operator unm: rgb
local rgb = nil

---Makes a copy of a vector.
---@return rgb
function rgb:clone() end

---Unpacks rgb into three numbers.
---@return rgb, number
function rgb:unpack() end

---Turns rgb into a table with three numbers.
---@return number[]
function rgb:table() end

---Returns reference to rgb class.
function rgb:type() end

---@param r rgb|number
---@param g number?
---@param b number?
---@return rgb @Returns itself.
function rgb:set(r, g, b) end

---@param x rgb
---@param mult number
---@return rgb @Returns itself.
function rgb:setScaled(x, mult) end

---@param value1 rgb
---@param value2 rgb
---@param mix number
---@return rgb @Returns itself.
function rgb:setLerp(value1, value2, mix) end

---@param valueToAdd rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:add(valueToAdd, out) end

---@param valueToAdd rgb
---@param scale number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:div(valueToDivideBy, out) end

---@param exponent rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:pow(exponent, out) end

---@param multiplier number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:scale(multiplier, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:min(otherValue, out) end

---@param otherValue rgb|number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:max(otherValue, out) end

---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:saturate(out) end

---@param min rgb
---@param max rgb
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:clamp(min, max, out) end

---Adjusts saturation using a very simple formula.
---@param saturation number
---@param out rgb|nil @Optional destination argument.
---@return rgb @Returns itself or out value.
function rgb:adjustSaturation(saturation, out) end

---Makes sure brightest value does not exceed 1.
---@return rgb @Returns itself.
function rgb:normalize() end

---Returns brightest value (aka V in HSV).
---@return number
function rgb:value() end

---Returns hue.
---@return number
function rgb:hue() end

---Returns saturation.
---@return number
function rgb:saturation() end

---Returns luminance value.
---@return number
function rgb:luminance() end

---Returns rgbm.
---@param mult number? @Default value: 1.
---@return rgbm
function rgb:rgbm(mult) end

---Returns HSV color of rgb*mult.
---@param out hsv? @If set, assigns result to given `hsv` instead of creating a new one. Added in 0.2.10.
---@return hsv
function rgb:hsv(out) end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgb:vec3() end

---Returns string with hex representation and leading “#”.
---@return string
function rgb:hex() end

--[[ common/ac_primitive_hsv.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `hsv(h, s, v)`.
---@param h number?
---@param s number?
---@param v number?
---@return hsv
function hsv.new(h, s, v) end

---Checks if value is hsv or not.
---@param p any
---@return boolean
function hsv.ishsv(p) end

---Temporary HSV color. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return hsv
function hsv.tmp() end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@param h number? 
---@param s number? 
---@param v number? 
---@return hsv
function hsv(h, s, v) end

---HSV color (hue, saturation, value). Equality operator is overloaded.
---@class hsv
---@field h number
---@field s number
---@field v number
local hsv = nil

---Makes a copy of a vector.
---@return hsv
function hsv:clone() end

---Unpacks hsv into three numbers.
---@return rgb, number
function hsv:unpack() end

---Turns hsv into a table with three numbers.
---@return number[]
function hsv:table() end

---Returns reference to hsv class.
function hsv:type() end

---@param h number
---@param s number
---@param v number
---@return hsv @Returns itself.
function hsv:set(h, s, v) end

---Returns RGB color.
---@param out rgb? @If set, assigns result to given `rgb` instead of creating a new one. Added in 0.2.10.
---@return rgb
function hsv:rgb(out) end

--[[ common/ac_primitive_rgbm.d.lua ]]

---Creates new instance. It’s usually faster to create a new item with `rgbm(r, g, b, mult)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(color: rgbm): rgbm
---@overload fun(color: rgb): rgbm
---@overload fun(color: hsv): rgbm
---@overload fun(color: vec4): rgbm
---@overload fun(color: vec3): rgbm
---@overload fun(tableOfFour: number[]): rgbm
---@overload fun(hexColor: string): rgbm
---@overload fun(colorAlpha: number): rgbm
---@overload fun(color: number, alpha: number): rgbm
---@overload fun(color: rgb, alpha: number): rgbm
---@param r number?
---@param g number?
---@param b number?
---@param m number? @Default value: 1.
---@return rgbm
function rgbm.new(r, g, b, m) end

---Checks if value is rgbm or not.
---@param p any
---@return boolean
function rgbm.isrgbm(p) end

---Temporary vector. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return rgbm
function rgbm.tmp() end

---Creates color from 0…255 values
---@param r number @From 0 to 255.
---@param g number @From 0 to 255.
---@param b number @From 0 to 255.
---@param a number? @From 0 to 1. Default value: 1.
---@return rgbm
function rgbm.from0255(r, g, b, a) end

---Predefined colors. Do not change them unless you want to have some extra fun debugging.
rgbm.colors = { transparent = rgbm(0, 0, 0, 0), black = rgbm(0, 0, 0, 1), silver = rgbm(0.75, 0.75, 0.75, 1), gray = rgbm(0.5, 0.5, 0.5, 1), white = rgbm(1, 1, 1, 1), maroon = rgbm(0.5, 0, 0, 1), red = rgbm(1, 0, 0, 1), purple = rgbm(0.5, 0, 0.5, 1), fuchsia = rgbm(1, 0, 1, 1), green = rgbm(0, 0.5, 0, 1), lime = rgbm(0, 1, 0, 1), olive = rgbm(0.5, 0.5, 0, 1), yellow = rgbm(1, 1, 0, 1), orange = rgbm(1, 0.5, 0, 1), navy = rgbm(0, 0, 0.5, 1), blue = rgbm(0, 0, 1, 1), teal = rgbm(0, 0.5, 0.5, 1), cyan = rgbm(0, 0.5, 1, 1), aqua = rgbm(0, 1, 1, 1) }

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@param r number? 
---@param g number? 
---@param b number? 
---@param mult number? 
---@return rgbm
function rgbm(r, g, b, mult) end

---Four-channel color. Fourth value, `mult`, can be used for alpha, for brightness, anything like that. All operators are also 
---overloaded. White is usually `rgb=1,1,1`.
---@class rgbm
---@field r number
---@field g number
---@field b number
---@field rgb rgb
---@field mult number
---@operator add(number|rgbm): rgbm
---@operator sub(number|rgbm): rgbm
---@operator mul(number|rgbm): rgbm
---@operator div(number|rgbm): rgbm
---@operator pow(number|rgbm): rgbm
---@operator len: number
---@operator unm: rgbm
local rgbm = nil

---Makes a copy of a vector.
---@return rgbm
function rgbm:clone() end

---Unpacks rgbm into rgb and number.
---@return rgb, number
function rgbm:unpack() end

---Turns rgbm into a table with four values.
---@return number[]
function rgbm:table() end

---Returns reference to rgbm class.
function rgbm:type() end

---@param rgb rgbm|rgb
---@param mult number?
---@return rgbm @Returns itself.
function rgbm:set(rgb, mult) end

---@param value1 rgbm
---@param value2 rgbm
---@param mix number
---@return rgbm @Returns itself.
function rgbm:setLerp(value1, value2, mix) end

---@param valueToAdd rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:add(valueToAdd, out) end

---@param valueToAdd rgbm
---@param scale number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:addScaled(valueToAdd, scale, out) end

---@param valueToSubtract rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:sub(valueToSubtract, out) end

---@param valueToMultiplyBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:mul(valueToMultiplyBy, out) end

---@param valueToDivideBy rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:div(valueToDivideBy, out) end

---@param exponent rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:pow(exponent, out) end

---@param multiplier number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:scale(multiplier, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:min(otherValue, out) end

---@param otherValue rgbm|number
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:max(otherValue, out) end

---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:saturate(out) end

---@param min rgbm
---@param max rgbm
---@param out rgbm|nil @Optional destination argument.
---@return rgbm @Returns itself or out value.
function rgbm:clamp(min, max, out) end

---Makes sure brightest value does not exceed 1.
---@return rgbm @Returns itself.
function rgbm:normalize() end

---Returns brightest value.
---@return number
function rgbm:value() end

---Returns luminance value.
---@return number
function rgbm:luminance() end

---Returns color (rgb*mult).
---@return rgb
function rgbm:color() end

---Returns HSV color of rgb*mult.
---@return hsv
function rgbm:hsv() end

---Returns rgb*mult turned to vec3.
---@return vec3
function rgbm:vec3() end

---Returns vec4, where X, Y and Z are RGB values and W is mult.
---@return vec4
function rgbm:vec4() end

---Returns string with hex representation and leading “#”.
---@return string
function rgbm:hex() end

--[[ common/ac_primitive_quat.d.lua ]]

---Creates new quaternion. It’s usually faster to create a new item with `quat(x, y, z, w)` directly, but the way LuaJIT works,
---that call only works with four numbers. If you only provide a single number, rest will be set to 0. This call, however, supports
---various calls (which also makes it slightly slower).
---@overload fun(value: quat): quat
---@overload fun(tableOfFour: number[]): quat
---@overload fun(value: number): quat
---@param x number?
---@param y number?
---@param z number?
---@param w number?
---@return quat
function quat.new(x, y, z, w) end

---Checks if value is quat or not.
---@param p any
---@return boolean
function quat.isquat(p) end

---Creates a new quaternion.
---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromAngleAxis(angle, x, y, z) end

---Creates a new quaternion.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat
function quat.fromDirection(x, y, z) end

---Creates a new quaternion.
---@param u quat
---@param v quat
---@return quat
function quat.between(u, v) end

---Temporary quaternion. For most cases though, it might be better to define those locally and use those. Less chance of collision.
---@return quat
function quat.tmp() end

---Quaternion. All operators are overloaded.
---@param x number? 
---@param y number? 
---@param z number? 
---@param w number? 
---@return quat
function quat(x, y, z, w) end

---Quaternion. All operators are overloaded.
---@class quat
---@field x number
---@field y number
---@field z number
---@field w number
local quat = nil

---Makes a copy of a quaternion.
---@return quat
function quat:clone() end

---Unpacks quat into four numbers.
---@return number, number, number, number
function quat:unpack() end

---Turns quat into a table with four values.
---@return number[]
function quat:table() end

---Returns reference to quat class.
function quat:type() end

---@param x quat|number
---@param y number?
---@param z number?
---@param w number?
---@return quat @Returns itself.
function quat:set(x, y, z, w) end

---@param angle number @In radians.
---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setAngleAxis(angle, x, y, z) end

---@return number @Angle in radians.
---@return number @Axis, X.
---@return number @Axis, Y.
---@return number @Axis, Z.
function quat:getAngleAxis() end

---@param u quat
---@param v quat
---@return quat @Returns itself.
function quat:setBetween(u, v) end

---@param x vec3|number
---@param y number?
---@param z number?
---@return quat @Returns itself.
function quat:setDirection(x, y, z) end

---@param valueToAdd quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:add(valueToAdd, out) end

---@param valueToSubtract quat|number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:sub(valueToSubtract, out) end

---@param valueToMultiplyBy quat
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:mul(valueToMultiplyBy, out) end

---@param multiplier number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:scale(multiplier, out) end

---@return number
function quat:length() end

---Normalizes itself (unless different `out` is provided).
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:normalize(out) end

---Rewrites own values with values of lerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:lerp(otherVector, mix, out) end

---Rewrites own values with values of slerp of itself and other quaternion (unless different `out` is provided).
---@param otherVector quat
---@param mix number
---@param out quat|nil @Optional destination argument.
---@return quat @Returns itself or out value.
function quat:slerp(otherVector, mix, out) end

--[[ common/ac_render_enums.lua ]]

---Render namespace for drawing custom shapes and other stuff like that.
render = {}

--[[ common/ac_ui.lua ]]

---Something that can be used as a texture, could be a texture filename, web URL, one of special values or an extra canvas, GIF or media player.
---If value starts with “%” and points to an icon in a DLL file, icon will be loaded (for scripts with full IO access only). Special values:
---- `color::X`: solid color texture (X can be three or four numbers or a hex representation).
---- `dynamic::…`: dynamic textures (require Graphics Adjustment to work, not very reliable in general but might work for some extra effects):
----  - `dynamic::screen`: LDR texture with scene contents.
----  - `dynamic::hdr`: HDR texture with scene contents.
----  - `dynamic::depth`: non-linear scene depth.
----  - `dynamic::noise`: general 32×32 noise texture.
---- `carN::…`: texture from a car with index N (0-based index), searches the same way car config would:
---  - `carN::dynamic::X`: car dynamic texture with a given key.
---  - `carN::car::X`: texture “X” from car KN5.
---  - `carN::special::driver`: driver icon (updates live for things like active voice chat).
---  - `carN::special::livery`: livery icon.
---  - `carN::special::theme`: theme image based on car livery color.
---  - Other values will look for an extension texture.
---- `track::…`: texture the track, searches the same way car config would:
---  - `track::track::X`: texture “X” from track KN5.
---  - Other values will look for an extension texture.
---@alias ui.ImageSource ui.ExtraCanvas|ui.SharedTexture|ui.GIFPlayer|ui.MediaPlayer|ac.GeometryShot|string|nil

---Very simple thing for smooth UI animations. Call it with a number for its initial state and it would
---return you a function. Each frame, call this function with your new target value and it would give you
---a smoothly changing numerical value. Unlike functions like `math.applyLag()`, this one is a bit more
---complicated, taking into account velocity as well.
---@param initialValue number @Initial value with which animation will start.
---@param weightMult number? @Weight multiplier for smoother or faster animation. Default value: 1.
---@return fun(target: number): number
function ui.SmoothInterpolation(initialValue, weightMult) end

---Another simple helper for easily creating elements fading in and out. Just pass it a draw callback and
---and initial state (should it be visible or not), and then call returned function every frame passing it
---a boolean to specify if item should be visible or not. Example:
---```
---local timeLeft = 120
---
---local function drawTimeLeft()
---  ui.text(string.format('Time left: %02.0f', math.max(0, timeLeft)))
---  -- keep in mind: when timer would reach 0, block would still be visible for a bit while fading out, so
---  -- that’s why there is that `math.max()` call
---end
---
---local fadingTimer = ui.FadingElement(drawTimeLeft)
---
---function script.update(dt)
---  timeLeft = timeLeft - dt
---  fadingTimer(timeLeft > 0 and timeLeft < 60)  -- only show timer if time left is below 60 seconds
---end
---```
---@param drawCallback fun() @Draw callback. Would only be called if alpha is above 0.2%, so there is no overhead if element is hidden.
---@param initialState boolean? @Should element be visible from the start. Default value: `false`.
---@return fun(state: boolean)
function ui.FadingElement(drawCallback, initialState) end

---@param filename string @Filename of a file to get the icon of. File might not exist, or it could only be a file extension.
---@param specialized boolean? @Set to `true` to try and get the icon for that exact file when possible. Usually just means it’ll look for exact icons of EXE files. Default value: `false`.
---@return ui.FileIcon
ui.FileIcon = function (filename, specialized) end

---Helper for drawing file icons.
---@class ui.FileIcon
local _uiFileIcon = {}

---Set icon style.
---@param style ui.FileIcon.Style
function _uiFileIcon:style(style) end

---@param name string @Name of the font, should be the name you can see when, for example, opening font with Windows Font Viewer (and not the name of the file). If your TTF file has a single font it in, you can use a path to it instead.
---@param dir string|nil @Optionally, path to a directory with TTF files in it. If provided, instead of looking for font in “content/fonts” and “extension/fonts”, CSP will scan given folder. Alternatively you can also use a path to a file here too, if you know for sure which file it’ll be (with TTF, different styles often go in different files).
---@return ui.DWriteFont
ui.DWriteFont = function (name, dir) end

---DirectWrite font name builder. Instead of using it, you can simply provide a string, but this thing might be a nicer way. You can chain its methods too:
---```
---local MyFavouriteFont = ui.DWriteFont('Best Font', './data'):weight(ui.DWriteFont.Weight.Bold):style(ui.DWriteFont.Style.Italic):stretch(ui.DWriteFont.Stretch.Condensed)
---…
---ui.pushFont(MyFavouriteFont)  -- you could also just put font here, but if defined once and reused, it would generate less garbage for GC to clean up.
---ui.dwriteText('Hello world!', 14)
---ui.popFont()
---```
---@class ui.DWriteFont
local _uiDWriteFont = {}

---Set font weight. Bold styles can be emulated even if there isn’t such font face, although quality of real font face would be better.
---@param weight ui.DWriteFont.Weight|integer @Alternatively, could be an integer in 1…999 range.
---@return self
function _uiDWriteFont:weight(weight) end

---Set font style. Italic style can be emulated even if there isn’t such font face, although quality of real font face would be better.
---@param style ui.DWriteFont.Style
---@return self
function _uiDWriteFont:style(style) end

---Set font stretch.
---@param stretch ui.DWriteFont.Stretch
---@return self
function _uiDWriteFont:stretch(stretch) end

---Set a custom axis value (available on Windows 10 Build 20348 or newer, otherwise values will be ignored).
---@param key 'weight'|'width'|'slant'|'opticalSize'|'italic'|string @Font variation table with list of keys is shown on https://fontdrop.info/.
---@param value number
---@return self
---@overload fun(s: ui.DWriteFont, values: {weight: number?, width: number?, slant: number?, opticalSize: number?, italic: number?}): self
function _uiDWriteFont:axis(key, value) end

---Disable font size rounding. Please use carefully: if you would to animate font size, it would quickly generate way too many atlases
---and increase both VRAM consumption and drawing time. If you need to animate font size, consider using `ui.beginScale()`/`ui.endScale()` instead.
---@param allow boolean? @Default value: `true`.
---@return self
function _uiDWriteFont:allowRealSizes(allow) end

---Allow or disallow use of colored emojis. If disabled, default black and white system glyphs will be drawn instead to system capabilities.
---Emoji are enabled by default.
---@param allow boolean? @Default value: `true`.
---@return self
function _uiDWriteFont:allowEmoji(allow) end

---Added in 0.3.0-preview121. Allows to tune spacing between characters. Not available before Windows 8.
---@param leading number @The spacing before each character, in reading order.
---@param trailing number @The spacing after each character, in reading order.
---@param minimumAdvanceWidth number @The minimum advance of each character, to prevent characters from becoming too thin or zero-width. This must be zero or greater.
---@return self
function _uiDWriteFont:spacing(leading, trailing, minimumAdvanceWidth) end

--[[ common/ac_ui.lua ]]

---Returns an icon for a given weather type
---@param weatherType ac.WeatherType
---@return ui.Icons
function ui.weatherIcon(weatherType) end

---Push style variable.
---@param varID ui.StyleVar
---@param value number|vec2
function ui.pushStyleVar(varID, value) end

---Push ID (use it if you, for example, have a list of buttons created in a loop).
---@param value number|string
function ui.pushID(value) end

---Text input control. Returns updated string (which would be the input string unless it changed, so no)
---copying there. Second return value would change to `true` when text has changed. Example:
---```
---myText = ui.inputText('Enter something:', myText)
---```
---
---Third value returned is `true` if Enter was pressed while editing text.
---@param label string
---@param str string
---@param flags ui.InputTextFlags?
---@param size vec2? @If specified, text input is multiline.
---@return string
---@return boolean
---@return boolean
function ui.inputText(label, str, flags, size) end

---Color picker control. Returns true if color has changed (as usual with Lua, colors are passed)
---by reference so update value would be put in place of old one automatically.
---@param label string
---@param color rgb|rgbm
---@param flags ui.ColorPickerFlags?
---@return boolean
function ui.colorPicker(label, color, flags) end

---Color button control. Returns true if color has changed (as usual with Lua, colors are passed)
---by reference so update value would be put in place of old one automatically.
---@param label string
---@param color rgb|rgbm
---@param flags ui.ColorPickerFlags?
---@param size vec2?
---@return boolean
function ui.colorButton(label, color, flags, size) end

---Show popup message.
---@param icon ui.Icons
---@param message string
---@param undoCallback fun()|nil @If provided, there’ll be an undo button which, when clicked, will call this callback.
---@return {button: fun(self, icon: ui.Icons, message: string, callback: fun())} @Use `ui.toast():button(icon, title, callback)` if you want to add an extra icon.
function ui.toast(icon, message, undoCallback) end

---Draw a window with transparent background.
---@generic T
---@param id string @Window ID, has to be unique within your script.
---@param pos vec2 @Window position.
---@param size vec2 @Window size.
---@param noPadding boolean? @Disables window padding. Default value: `false`.
---@param inputs boolean? @Enables inputs (buttons and such). Default value: `false`.
---@param content fun(): T? @Window content callback.
---@return T
---@overload fun(id: string, pos: vec2, size: vec2, content: fun())
---@overload fun(id: string, pos: vec2, size: vec2, noPadding: boolean, content: fun())
function ui.transparentWindow(id, pos, size, noPadding, inputs, content) end

---Draw a window with semi-transparent background.
---@generic T
---@param id string @Window ID, has to be unique within your script.
---@param pos vec2 @Window position.
---@param size vec2 @Window size.
---@param noPadding boolean? @Disables window padding. Default value: `false`.
---@param inputs boolean? @Enables inputs (buttons and such). Default value: `false`.
---@param content fun(): T? @Window content callback.
---@return T
---@overload fun(id: string, pos: vec2, size: vec2, content: fun())
---@overload fun(id: string, pos: vec2, size: vec2, noPadding: boolean, content: fun())
function ui.toolWindow(id, pos, size, noPadding, inputs, content) end

---Draw a tooltip with custom content.
---@generic T
---@param padding vec2? @Tooltip padding. Default value: `vec2(20, 8)`.
---@param content fun(): T? @Window content callback.
---@return T
---@overload fun(content: fun())
function ui.tooltip(padding, content) end

---Set `columns` above 1 to start a column layout. Set it back to 1 to stop the layout. Since 0.3.0, there is a new override
---taking flags. When layouting columns, use `ui.nextColumn()` to switch to the next column, or row if current column is the last one.
---@param columns integer? @Default value: 1.
---@param border boolean? @Default value: `true`.
---@param id string|nil @Default value: `nil`.
---@overload fun(columns: integer, flags: ui.ColumnsFlags, id: string?)
function ui.columns(columns, border, id) end

---Draw a child window: perfect for clipping content, for scrolling lists, etc. Think of it more like
---a HTML div with overflow set to either scrolling or hidden, for example.
---@generic T
---@param id string @Window ID, has to be unique within given context (like, two sub-windows of the same window should have different IDs).
---@param size vec2 @Window size.
---@param border boolean? @Window border.
---@param flags ui.WindowFlags? @Window flags.
---@param content fun(): T? @Window content callback.
---@return T?
---@overload fun(id: string, size: vec2, border: boolean, content: fun())
---@overload fun(id: string, size: vec2, content: fun())
function ui.childWindow(id, size, border, flags, content) end

---Draw a tree node element: a collapsible block with content inside it (which might include other tree
---nodes). Great for grouping things together. Note: if you need to have a tree node with changing label,
---use label like “your changing label###someUniqueID” for it to work properly. Everything after “###” will
---count as ID and not be shown. Same trick applies to other controls as well, such as tabs, buttons, etc.
---@generic T
---@param label string @Tree node label (which also acts like its ID).
---@param flags ui.TreeNodeFlags? @Tree node flags.
---@param content fun(): T? @Tree node content callback (called only if tree node is expanded).
---@return T?
---@overload fun(label: string, content: fun())
function ui.treeNode(label, flags, content) end

---Draw a section with tabs. Inside, use `ui.tabItem()` to draw actual tabs like so:
---```
---ui.tabBar('someTabBarID', function ()
---  ui.tabItem('Tab 1', function () --[[ Contents of Tab 1 ]] end)
---  ui.tabItem('Tab 2', function () --[[ Contents of Tab 2 ]] end)
---end)
---```
---@generic T
---@param id string @Tab bar ID.
---@param flags ui.TabBarFlags? @Tab bar flags.
---@param content fun(): T? @Individual tabs callback.
---@return T?
---@overload fun(id: string, content: fun())
function ui.tabBar(id, flags, content) end

---Draw a new tab in a tab bar. Note: if you need to have a tab with changing label,
---use label like “your changing label###someUniqueID” for it to work properly. Everything after “###” will
---count as ID and not be shown. Same trick applies to other controls as well, such as tree nodes, buttons, etc.
---```
---ui.tabBar('someTabBarID', function ()
---  ui.tabItem('Tab 1', function () --[[ Contents of Tab 1 ]] end)
---  ui.tabItem('Tab 2', function () --[[ Contents of Tab 2 ]] end)
---end)
---```
---@generic T
---@param label string @Tab label.
---@param flags ui.TabItemFlags? @Tab flags.
---@param content fun(): T? @Tab content callback (called only if tab is selected).
---@param opened refbool? @Pass a `refbool` with `true` value here to show close button. When clicked, value in `refbool` will  be set to `false`.
---@return T
---@overload fun(label: string, content: fun())
function ui.tabItem(label, flags, content, opened) end

---Sets a callback that will be called when image is loaded. If image is already loaded, calls `callback` immediately, before
---exiting the function.
---
---Note: By default images from local files are loaded syncronously, use `ui.setAsynchronousImagesLoading(true)` function to change this behaviour.
---@param imageSource ui.ImageSource @Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.
---@param callback fun() @Callback to call once image is loaded.
function ui.onImageReady(imageSource, callback) end

---Adds context menu to previously drawn item which would open when certain mouse button would be pressed. Once it happens,
---content callback will be called each frame to draw contents of said menu.
---```
---ui.itemPopup(ui.MouseButton.Right, function ()
---  if ui.selectable('Item 1') then --[[ Item 1 was clicked ]] end
---  if ui.selectable('Item 2') then --[[ Item 2 was clicked ]] end
---  ui.separator()
---  if ui.selectable('Item 3') then --[[ Item 3 was clicked ]] end
---  -- Other types of controls would also work
---end)
---```
---@generic T
---@param id string @Context menu ID.
---@param mouseButton ui.MouseButton @Mouse button
---@param content fun(): T? @Menu content callback (called only if menu is opened).
---@return T
---@overload fun(id: string, content: fun())
---@overload fun(mouseButton: ui.MouseButton, content: fun())
---@overload fun(content: fun())
function ui.itemPopup(id, mouseButton, content) end

---Adds a dropdown list (aka combo box). Items are drawn in content callback function, or alternatively
---it can work with a list of strings and an ID of a selected item, returning either ID of selected item and
---boolean with `true` value if it was changed, or if ID is a refnumber, it would just return a boolean value
---for whatever it was changed or not.
---@generic T
---@param label string @Label of the element.
---@param previewValue string? @Preview value.
---@param flags ui.ComboFlags? @Combo box flags.
---@param content fun(): T? @Combo box items callback.
---@return T
---@overload fun(label: string, previewValue: string?, content: fun())
---@overload fun(label: string, selectedIndex: integer, flags: ui.ComboFlags, content: string[]): integer, boolean
---@overload fun(label: string, selectedIndex: refnumber, flags: ui.ComboFlags, content: string[]): boolean
function ui.combo(label, previewValue, flags, content) end

---Adds a slider. For value, either pass `refnumber` and slider would return a single boolean with `true` value
---if it was moved (and storing updated value in passed `refnumber`), or pass a regular number and then
---slider would return number and then a boolean. Example:
---```
----- With refnumber:
---local ref = refnumber(currentValue)
---if ui.slider('Test', ref) then currentValue = ref.value end
---
----- Without refnumber:
---local value, changed = ui.slider('Test', currentValue)
---if changed then currentValue = value end
---
----- Or, of course, if you don’t need to know if it changed (and, you can always use `ui.itemEdited()` as well):
---currentValue = ui.slider('Test', currentValue)
---```
---I personally prefer to hide slider label and instead use its format string to show what’s it for. IMGUI would
---not show symbols after “##”, but use them for ID calculation.
---```
---currentValue = ui.slider('##someSliderID', currentValue, 0, 100, 'Quantity: %.0f')
---```
---By the way, a bit of clarification: “##” would do
---that, but “###” would result in ID where only symbols going after “###” are taken into account. Helps if you
---have a control which label is constantly changing. For example, a tab showing a number of elements or current time.
---
---To enter value with keyboard, hold Ctrl and click on it.
---@param label string @Slider label.
---@param value refnumber|number @Current slider value.
---@param min number? @Default value: 0.
---@param max number? @Default value: 1.
---@param format string|'%.3f'|nil @C-style format string. Default value: `'%.3f'`.
---@param power number|boolean|nil @Power for non-linear slider. Default value: `1` (linear). Pass `true` to enable integer mode instead.
---@return number @Possibly updated slider value.
---@return boolean @True if slider has moved.
---@overload fun(label: string, value: number, min: number, max: number, format: string, power: number): number, boolean
function ui.slider(label, value, min, max, format, power) end

---Draws race flag of a certain type, or in a certain color in its usual position.
---Use it if you want to add a new flag type: this way, if custom UI later would replace flags with
---a different look (or even if it’s just a custom texture mod), it would still work.
---
---Note: if your script can access physics and you need a regular flag, using `physics.overrideRacingFlag()`
---would work better (it would also affect track conditions and such).
---@param color ac.FlagType|rgbm
function ui.drawRaceFlag(color) end

---Draws icon for car state, along with low fuel icon. If more than one icon is visible at once, subsequent ones are drawn
---to the right of previous icon. Settings altering position and opacity of low fuel icon also apply here. Background is
---included by default: simply pass a semi-transparent symbol here.
---@param iconID ui.Icons|fun(iconSize: number) @Might be an icon ID or anything else `ui.icon()` can take, or a function taking icon size.
---@param color rgbm? @Icon tint for background. Default value: `rgbm.colors.white`.
---@param hint string? @Optional hint appearing if mouse is hovering the icon.
function ui.drawCarIcon(iconID, color, hint) end

---Generates ID to use with `ui.icon()` to draw an icon from an atlas. Might be faster to safe the result
---of the call and reuse that, although it’s not that expensive if you only need to render a couple of icons.
---@param filename string @Texture filename.
---@param uv1 number|vec2 @UV coordinates of the upper left corner in 0…1 range, 0 for the top left corner.
---@param uv2 number|vec2 @UV coordinates of the bottom right corner in 0…1 range, 0 for the top left corner.
---@return ui.Icons @Returns an ID to be used as an argument for `ui.icon()` function.
function ui.atlasIconID(filename, uv1, uv2) end

---Generates a table acting like icons atlas.
---@generic T
---@param filename string @Texture filename.
---@param columns integer @Number of columns in the atlas.
---@param rows integer @Number of rows in the atlas.
---@param icons T @Table with icons from left top corner, each icon is a table with 1-based row and column indices.
---@return T
function ui.atlasIcons(filename, columns, rows, icons) end

---@param resolution vec2|integer @Resolution in pixels. Usually textures with sizes of power of two work the best.
---@param mips integer? @Number of MIPs for a texture. MIPs are downsized versions of main texture used to avoid aliasing. Default value: 1 (no MIPs).
---@param antialiasingMode render.AntialiasingMode? @Antialiasing mode. Default value: `render.AntialiasingMode.None` (disabled).
---@param textureFormat render.TextureFormat? @Texture format. Default value: `render.TextureFormat.R8G8B8A8.UNorm`.
---@param flags render.TextureFlags? @Extra flags. Default value: `0`.
---@return ui.ExtraCanvas
---@overload fun(resolution: vec2|integer, mips: integer, textureFormat: render.TextureFormat)
function ui.ExtraCanvas(resolution, mips, antialiasingMode, textureFormat, flags) end

---@alias ui.GaussianBlurKernelSize 7|15|23|35|63|127

---Extra canvases are textures you can use in UI calls instead of filenames or apply as material textures to scene geometry,
---and also edit them live by drawing things into them using “ui…” functions. A few possible use cases as an example:
---- If your app or display uses a complex background or another element, it might be benefitial to draw it into a texture once and then reuse it;
---- If you want to apply some advanced transformations to some graphics, it might work better to use texture;
---- It can also be used to blur some elements by drawing them into a texture and then drawing it blurred.
---
---Note: update happens from a different short-lived UI context, so interactive controls would not work here.
---@class ui.ExtraCanvas
local _ui_ExtraCanvas = nil

---Disposes canvas and releases resources.
function _ui_ExtraCanvas:dispose() end

---Return explicit MIP to use as an image. If called with index of 0, returns texture similar to main one, but only with a single MIP.
---@param index integer @0-based MIP index.
function _ui_ExtraCanvas:mip(index) end

---Sets canvas name for debugging. Canvases with set name appear in Lua Debug App, allowing to monitor their state.
---@param name string? @Name to display texture as. If set to `nil` or `false`, name will be reset and texture will be hidden.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:setName(name) end

---Updates texture, calling `callback` to draw things with. If you want to do several changes, it would work better to group them in a
---single `canvas:update()` call.
---
---Note: canvas won’t be cleared here, to clear it first, use `canvas:clear()` method.
---@param callback fun(dt: number) @Drawing function. Might not be called if canvas has been disposed or isn’t available for drawing into.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:update(callback) end

---Updates texture using a shadered quad. Faster than using `:update()` with `ui.renderShader()`:
---no time will be wasted setting up IMGUI pass and preparing all that data, just a single draw call.
---Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, mip: integer, blendMode: render.BlendMode, async: boolean, cacheKey: number, defines: table, textures: table, values: table, directValuesExchange: boolean, shader: string}|`{textures = {}, values = {}, shader = 'float4 main(PS_IN pin) {return float4(pin.Tex.x, pin.Tex.y, 0, 1);}'}` "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas. Default value: `vec2(0, 0)`.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas. Default value: size of canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `mip` (`integer`): 0-based index of target MIP layer. Default value: `0`. Use `:mip(index - 1)` as a texture input to access previous MIP view in case you want to generate new MIPs from previous ones. If this parameter is above 0, automatic MIPs generation stops.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.Opaque`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `cacheKey` (`number`): Optional cache key for compiled shader (caching will depend on shader source code, but not on included files, so make sure to change the key if included files have changed).\n- `defines` (`table`): Defines to pass to the shader, either boolean, numerical or string values (don’t forget to wrap complex expressions in brackets). False values won’t appear in code and true will be replaced with 1 so you could use `#ifdef` and `#ifndef` with them.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `directValuesExchange` (`boolean`): If you’re reusing table between calls instead of recreating it each time and pass `true` as this parameter, `values` table will be swapped with an FFI structure allowing to skip data copying step and achieve the best performance. Note: with this mode, you’ll have to transpose matrices manually.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function _ui_ExtraCanvas:updateWithShader(params) end

---Updates texture using a shader with a fullscreen pass. Faster than using `:update()` with `ui.renderShader()`:
---no time will be wasted setting up IMGUI pass and preparing all that data, just a single draw call.
---Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Unlike `:updateWithShader()`, this version is single pass stereo-aware and can be used in the middle of
---rendering scene, and has access to camera state and some rendering pipeline textures by default (see “fullscreen.fx” template).
---Use it if you need to prepare an offscreen buffer to apply to the scene.
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, mip: integer, blendMode: render.BlendMode, async: boolean, cacheKey: number, defines: table, textures: table, values: table, directValuesExchange: boolean, shader: string}|`{textures = {}, values = {}, shader = 'float4 main(PS_IN pin) {return float4(pin.Tex.x, pin.Tex.y, 0, 1);}'}` "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas. Default value: `vec2(0, 0)`.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas. Default value: size of canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `mip` (`integer`): 0-based index of target MIP layer. Default value: `0`. Use `:mip(index - 1)` as a texture input to access previous MIP view in case you want to generate new MIPs from previous ones. If this parameter is above 0, automatic MIPs generation stops.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.Opaque`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `cacheKey` (`number`): Optional cache key for compiled shader (caching will depend on shader source code, but not on included files, so make sure to change the key if included files have changed).\n- `defines` (`table`): Defines to pass to the shader, either boolean, numerical or string values (don’t forget to wrap complex expressions in brackets). False values won’t appear in code and true will be replaced with 1 so you could use `#ifdef` and `#ifndef` with them.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `directValuesExchange` (`boolean`): If you’re reusing table between calls instead of recreating it each time and pass `true` as this parameter, `values` table will be swapped with an FFI structure allowing to skip data copying step and achieve the best performance. Note: with this mode, you’ll have to transpose matrices manually.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function _ui_ExtraCanvas:updateSceneWithShader(params) end

---Clears canvas.
---@param col rgbm? @Default value: `rgbm.colors.transparent`.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:clear(col) end

---Manually applies antialiasing to the texture (works only if it was created with a specific antialiasing mode).
---By default antialiasing is applied automatically, but calling this function switches AA to a manual mode.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:applyAntialiasing() end

---Generates MIPs. Once called, switches texture to manual MIPs generating mode. Note: this operation is not that expensive, but it’s not free.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:mipsUpdate() end

---Overrides exposure used if antialiasing mode is set to YEBIS value. By default scene exposure is used.
---@param value number? @Exposure used by YEBIS post-processing. Pass `nil` to reset to default behavior.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:setExposure(value) end

---Saves canvas as an image.
---@param filename string @Destination filename.
---@param format ac.ImageFormat|nil @Texture format (by default guessed based on texture name).
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:save(filename, format) end

---Returns image encoded in DDS format. Might be useful if you would need to store an image
---in some custom form (if so, consider compressing it with `ac.compress()`).
---
---Note: you can later use `ui.decodeImage()` to get a string which you can then pass as a texture name
---to any of texture receiving functions. This way, you can load image into a new canvas later: just
---create a new canvas (possibly using `ui.imageSize()` first to get image size) and update it drawing
---imported image to the full size of the canvas.
---@return string|nil @Binary data, or `nil` if binary data export has failed.
function _ui_ExtraCanvas:encode() end

---Returns texture resolution (or zeroes if element has been disposed).
---@return vec2
function _ui_ExtraCanvas:size() end

---Returns number of MIP maps (1 for no MIP maps and it being a regular texture).
---@return integer
function _ui_ExtraCanvas:mips() end

---Returns shared handle to the texture. Shared handle can be used in other scripts with `ui.SharedTexture()`, or, if `crossProcess` flag
---is set to `true`, also accessed by other processes.
---@param crossProcess boolean? @Set to `true` to be able to pass a handle to other processes. Requires `render.TextureFlags.Shared` flag to be set during creation. Default value: `false`.
---@return integer
function _ui_ExtraCanvas:sharedHandle(crossProcess) end

---Clones current canvas.
---@return ui.ExtraCanvas @Returns new canvas.
function _ui_ExtraCanvas:clone() end

---Backup current state of canvas, return a function which can be called to restore original state. Note:
---it clones current canvas texture, so don’t make too many backup copies at once.
---@return fun() @Returns function which will restore original canvas state when called. Function can be called more than once.
function _ui_ExtraCanvas:backup() end

---Copies contents from another canvas, CPU canvas data, image or an icon. Faster than copying by drawing. If source is disposed or missing,
---does not alter the contents of the canvas.
---@param other ui.ExtraCanvas|ui.ExtraCanvasData|ui.Icons @Canvas to copy content from.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:copyFrom(other) end

---Fills with canvas with blurred version of another texture, applying two optimized gaussian blur passes.
---@param other ui.ImageSource @Canvas to copy content from.
---@param kernelSize ui.GaussianBlurKernelSize? @Kernel size. Default value: 63.
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:gaussianBlurFrom(other, kernelSize) end

---Downloads data from GPU to CPU asyncronously (usually takes about 0.15 ms to get the data). Resulting data can be
---used to access colors of individual pixels or upload it back to CPU restoring original state.
---@param callback fun(err: string, data: ui.ExtraCanvasData)
---@return ui.ExtraCanvas @Returns itself for chaining several methods together.
function _ui_ExtraCanvas:accessData(callback) end

---Contents of `ui.ExtraCanvas` copied to CPU. There, that data can no longer be used to draw things (but it can be uploaded
---back to GPU with `canvas:copyFrom()`), but it can be used to quickly access colors of individual pixels. Unlike `ui.ExtraCanvas`,
---instances of `ui.ExtraCanvasData` consume RAM, not VRAM.
---
---To save RAM while storing several copies of data, you can use `data:compress()` to apply fast LZ4 compression. Note that each time
---you would use data by reading colors of pixels, data would get decompressed automatically. Copying extra data back to canvas with
---`canvas:copyFrom()` works with both compressed and decompressed data (data would be decompressed temporary).
---@class ui.ExtraCanvasData
local _ui_ExtraCanvasData = nil

---Disposes canvas and releases resources.
function _ui_ExtraCanvasData:dispose() end

---Compresses data using LZ4 algorithm if data wasn’t compressed already.
---@return ui.ExtraCanvasData @Returns itself for chaining several methods together.
function _ui_ExtraCanvasData:compress() end

---Returns original texture resolution (or zeroes if data has been disposed).
---@return vec2
function _ui_ExtraCanvasData:size() end

---Returns `true` if data is currently compressed.
---@return boolean
function _ui_ExtraCanvasData:compressed() end

---Returns space taken by data in bytes.
---@return integer
function _ui_ExtraCanvasData:memoryFootprint() end

---Returns numeric value of a pixel of R32FLOAT texture. If coordinates are outside, or data has been disposed, returns zeroes.
---@param x integer @0-based X coordinate.
---@param y integer @0-based Y coordinate.
---@return number @Pixel color from 0 to 1.
---@overload fun(s: ui.ExtraCanvasData, pos: vec2): number
function _ui_ExtraCanvasData:floatValue(x, y) end

---Returns color of a pixel of RGBA8888 texture. If coordinates are outside, or data has been disposed, returns zeroes.
---@param x integer @0-based X coordinate.
---@param y integer @0-based Y coordinate.
---@return rgbm @Pixel color from 0 to 1.
---@overload fun(s: ui.ExtraCanvasData, pos: vec2): rgbm
function _ui_ExtraCanvasData:color(x, y) end

---Writes color of a pixel to a provided `rgbm` value. Same as `data:color()`, but does not create new color values, so should be
---easier on garbage collector and more useful if you need to go through a lot of pixels for some reason.
---@param color rgbm @0-based X coordinate.
---@param x integer @0-based X coordinate.
---@param y integer @0-based Y coordinate.
---@return rgbm @Pixel color from 0 to 1 (same as input `color`).
---@overload fun(s: ui.ExtraCanvasData, color: rgbm, pos: vec2): rgbm
function _ui_ExtraCanvasData:colorTo(color, x, y) end

---Returns a function which returns `true` when keyboard shortcut is pressed.
---@param key {key: ui.KeyIndex, ctrl: boolean, alt: boolean, shift: boolean, super: boolean}|`{ key = ui.KeyIndex.A, ctrl = false }`
---@return fun(withRepeat: boolean|nil): boolean
---@overload fun(key: ui.KeyIndex|integer, ...): function
function ui.shortcut(key, ...) end

---Draws image using custom drawcall (not an IMGUI drawcall). Any transformations and color shifts
---wouldn’t work. But there are some extra shading features available here.
---@param params {filename: string, p1: vec2, p2: vec2, color: rgbm, colorOffset: rgbm, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, mask1: string, mask1UV1: vec2, mask1UV2: vec2, mask1Flags: render.TextureMaskFlags, mask2: string, mask2UV1: vec2, mask2UV2: vec2, mask2Flags: render.TextureMaskFlags}|`{filename = '', p1 = vec2(0, 0), p2 = vec2(1, 1), color = rgbm.colors.white, uv1 = vec2(0, 0), uv2 = vec2(1, 1), blendMode = render.BlendMode.BlendAccurate}` "Table with properties:\n- `filename` (`string`): Path to the image, absolute or relative to script folder or AC root. URLs are also accepted.\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas.\n- `color` (`rgbm`): Tint of the image, with white it would be drawn as it is. In this call, can be above 0. Default value: `rgbm.colors.white`.\n- `colorOffset` (`rgbm`): Color offset. Default value: `rgbm.colors.transparent`.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `mask1` (`string`): Optional mask #1, resulting image will be drawn only if mask is non-transparent and with non-zero alpha channel. Default value: `nil`.\n- `mask1UV1` (`vec2`): Texture coordinates for upper left corner of a mask. Default value: `vec2(0, 0)`.\n- `mask1UV2` (`vec2`): Texture coordinates for bottom right corner of a mask. Default value: `vec2(1, 1)`.\n- `mask1Flags` (`render.TextureMaskFlags`): Flags for the first mask. Default value: 6.\n- `mask2` (`string`): Optional mask #2, resulting image will be drawn only if mask is non-transparent and with non-zero alpha channel. Default value: `nil`.\n- `mask2UV1` (`vec2`): Texture coordinates for upper left corner of a mask. Default value: `vec2(0, 0)`.\n- `mask2UV2` (`vec2`): Texture coordinates for bottom right corner of a mask. Default value: `vec2(1, 1)`.\n- `mask2Flags` (`render.TextureMaskFlags`): Flags for the second mask. Default value: 6."
function ui.renderTexture(params) end

---Draws a quad with a custom shader. Shader is compiled at first run, which might take a few milliseconds.
---If you’re drawing things continuously, use `async` parameter and shader will be compiled in a separate thread,
---while drawing will be skipped until shader is ready.
---
---You can bind up to 32 textures and pass any number/boolean/vector/color/matrix values to the shader, which makes
---it a very effective tool for any custom drawing you might need to make.
---
---Example:
---```
---ui.renderShader({
---  async = true,
---  p1 = vec2(),
---  p2 = ui.windowSize(),
---  blendMode = render.BlendMode.BlendAdd,
---  textures = {
---    txInput1 = 'texture.png',  -- any key would work, but it’s easier to have a common prefix like “tx”
---    txInput2 = mediaPlayer,
---    txMissing = false
---  },
---  values = {
---    gValueColor = rgbm(1, 2, 0, 0.5),  -- any key would work, but it’s easier to have a common prefix like “g”
---    gValueNumber = math.random(),
---    gValueVec = vec2(1, 2),
---    gFlag = math.random() > 0.5
---  },
---  shader = [[
---    float4 main(PS_IN pin) {
---      float4 in1 = txInput1.Sample(samAnisotropic, pin.Tex);
---      float4 in2 = txInput2.Sample(samAnisotropic, pin.Tex + gValueVec);
---      return gFlag ? in1 + in2 * gValueColor : in2;
---    }
---  ]]
---})
---```
---
---Tip: to simplify and speed things up, it might make sense to move table outside of a function to reuse it from frame
---to frame, simply accessing and updating textures, values and other parameters before call. However, make sure not to
---add new textures and values, otherwise it would require to recompile shader and might lead to VRAM leaks (if you would
---end up having thousands of no more used shaders). If you don’t have a working texture at the time of first creating
---that table, use `false` for missing texture value.
---
---Note: if shader would fail to compile, a C++ exception will be triggered, terminating script completely (to prevent AC
---from crashing, C++ exceptions halt Lua script that triggered them until script gets a full reload).
---@return boolean @Returns `false` if shader is not yet ready and no drawing occured (happens only if `async` is set to `true`).
---@param params {p1: vec2, p2: vec2, uv1: vec2, uv2: vec2, blendMode: render.BlendMode, async: boolean, cacheKey: number, defines: table, textures: table, values: table, directValuesExchange: boolean, shader: string}|`{p1 = vec2(0, 0), p2 = vec2(1, 1), blendMode = render.BlendMode.BlendAccurate, textures = {}, values = {}, shader = 'float4 main(PS_IN pin) {return float4(pin.Tex.x, pin.Tex.y, 0, 1);}'}` "Table with properties:\n- `p1` (`vec2`): Position of upper left corner relative to whole screen or canvas.\n- `p2` (`vec2`): Position of bottom right corner relative to whole screen or canvas.\n- `uv1` (`vec2`): Texture coordinates for upper left corner. Default value: `vec2(0, 0)`.\n- `uv2` (`vec2`): Texture coordinates for bottom right corner. Default value: `vec2(1, 1)`.\n- `blendMode` (`render.BlendMode`): Blend mode. Default value: `render.BlendMode.BlendAccurate`.\n- `async` (`boolean`): If set to `true`, drawing won’t occur until shader would be compiled in a different thread.\n- `cacheKey` (`number`): Optional cache key for compiled shader (caching will depend on shader source code, but not on included files, so make sure to change the key if included files have changed).\n- `defines` (`table`): Defines to pass to the shader, either boolean, numerical or string values (don’t forget to wrap complex expressions in brackets). False values won’t appear in code and true will be replaced with 1 so you could use `#ifdef` and `#ifndef` with them.\n- `textures` (`table`): Table with textures to pass to a shader. For textures, anything passable in `ui.image()` can be used (filename, remote URL, media element, extra canvas, etc.). If you don’t have a texture and need to reset bound one, use `false` for a texture value (instead of `nil`)\n- `values` (`table`): Table with values to pass to a shader. Values can be numbers, booleans, vectors, colors or 4×4 matrix. Values will be aligned automatically.\n- `directValuesExchange` (`boolean`): If you’re reusing table between calls instead of recreating it each time and pass `true` as this parameter, `values` table will be swapped with an FFI structure allowing to skip data copying step and achieve the best performance. Note: with this mode, you’ll have to transpose matrices manually.\n- `shader` (`string`): Shader code (format is HLSL, regular DirectX shader); actual code will be added into a template in “assettocorsa/extension/internal/shader-tpl/ui.fx”."
function ui.renderShader(params) end

---Begins new group offset horizontally to the right, pushes item width to fill available space. Call `ui.endSubgroup()` when done.
---@param offsetX number? @Default value: 20.
function ui.beginSubgroup(offsetX) end

---Ends group began with `ui.beginSubgroup()`.
function ui.endSubgroup() end

---Stops rest of Assetto Corsa from responding to keyboard events (key bindings, etc.), also sets `getUI().wantCaptureKeyboard` flag.
---Note: if you writing a script reacting to general keyboard events, consider checking that flag to make sure IMGUI doesn’t have
---keyboard captured currently.
---
---Resulting structure is a good way to access keyboard input data, both the button events and characters being entered.
---@param wantCaptureKeyboard boolean? @Default value: `true`.
---@param wantCaptureText boolean? @Default value: `false`.
---@param globalInput boolean? @Set to `true` to capture input from something like a script display. Default value: `false`.
---@return ui.CapturedKeyboard
function ui.captureKeyboard(wantCaptureKeyboard, wantCaptureText, globalInput) end

---Similar to `ui.invisibleButton()`, but this one can be activated similar to text input and if it is active, will monitor keyboard state.
---@param id string? @Default value: `'nil'`.
---@param size vec2? @Default value: `vec2(0, 0)`.
---@return ui.CapturedKeyboard?
---@return boolean @Set to `true` if area was just activated.
function ui.interactiveArea(id, size) end

---@class ui.CapturedKeyboard
---@field pressedCount integer @Number of buttons in `.pressed` array.
---@field pressed integer[] @Zero-based array of pressed buttons with direct access (be careful).
---@field repeated integer[] @Zero-based array of flags if pressed buttons are repeated (the same size as `pressed`).
---@field releasedCount integer @Number of buttons in `.released` array.
---@field released integer[] @Zero-based array of released buttons with direct access (be careful).
local _ui_CapturedKeyboard = nil

---Characters being typed. Automatically takes into account keyboard layout, held shift and all that stuff.
---@return string @Empty string if there were no characters.
function _ui_CapturedKeyboard:queue() end

---@return boolean
function _ui_CapturedKeyboard:down(index) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyCtrl(button) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyShift(button) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyAlt(button) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyCtrlShift(button) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyCtrlAlt(button) end

---@param button ui.KeyIndex?
---@return boolean
function _ui_CapturedKeyboard:hotkeyCtrlShiftAlt(button) end

---Create a new popup. Function `callback()` will be called each frame to render its content until popup is closed. Pass `title` in parameters to create
---a window instead (you can still call `ui.closePopup()` from the window to close it).
---@param callback fun()
---@param params {onClose: fun()?, position: vec2?, pivot: vec2?, size: vec2|{min: vec2?, max: vec2?, initial: vec2?}?, padding: vec2?, flags: ui.WindowFlags?, backgroundColor: rgbm?, title: string?, parentless: boolean?}?
function ui.popup(callback, params) end

---Creates a new layer with user icons. Use `carN::special::driver` to draw an icon of a driver in a certain car (replace N with 0-based car index).
---@param priority integer @Layer with higher priority will be used.
---@param column number? @Column. If set, extra icons per user can be set. Columns are ordered from lowest to biggest. To get number of icon columns use `ac.getCar().extraIconsCount`. To draw an icon X, use `carN::special::driver::X`. Note: unlike main icons, those extra icons are not drawn in most parts of UI. New CSP UI only draws up to two extra icons per driver.
---@return fun(carIndex: integer, icon: ui.Icons) @Call this function to override actual icons using 0-based car index. Note: car scripts can override icon of their drivers only.
function ui.UserIconsLayer(priority, column) end

---Note: unlike `ui.itemRectMin()` and `ui.itemRectMax()`, this one returns references instead of creating new vectors. Be careful if you
---are to call this function and reuse results after calling it again.
---@return vec2
---@return vec2
function ui.itemRect() end

---Adds a new settings item in settings list in apps.
---@param params {icon: ui.Icons, name: string, size: {default: vec2, min: vec2, max: vec2, automatic: nil|boolean}, id: string, padding: vec2, backgroundColor: rgbm, category: 'settings'|'main'|'developer'|nil, tags: string[]|nil, parent: string, onOpen: fun(), onClose: fun(), onMenu: fun(), onRemove: fun(), keepClosed: boolean}|`{icon = ui.Icons.Settings, name = '', size = {default = vec2(), min = vec2(), max = vec2(), automatic = false}}` "Table with properties:\n- `icon` (`ui.Icons`): Settings icon.\n- `name` (`string`): Name of the settings item (name of a script by default).\n- `size` (`{default: vec2, min: vec2, max: vec2, automatic: nil|boolean}`): Size settings. Default size: `vec2(320, 240)`, default min size: `vec2(40, 20)`.\n- `id` (`string`): If specified, state of a window will be remembered across AC runs or Lua reloads.\n- `padding` (`vec2`): Custom padding for the window.\n- `backgroundColor` (`rgbm`): Custom background color for the window.\n- `category` (`'settings'|'main'|'developer'|nil`): Optionally, this function can be used for simply creating new apps.\n- `tags` (`string[]|nil`): Optional list of tags for search to find the app.\n- `parent` (`string`): ID of a parent window. If set, and parent window is found, `category` will be ignored.\n- `onOpen` (`fun()`): Callback called when the tool is opened.\n- `onClose` (`fun()`): Callback called when the tool is closed.\n- `onMenu` (`fun()`): Callback for extra items in context menu opening from taskbar.\n- `onRemove` (`fun()`): Callback called once when the tool is removed. If set, there will be an item for removing the tool in taskbar context menu.\n- `keepClosed` (`boolean`): Set to `true` to keep app closed even if it was opened before."
---@param callback fun() @Callback function to draw contents of the settings window.
---@return ac.Disposable|fun(command: 'open'|'close'|'toggle'|'opened'|'focus'|string): any
function ui.addSettings(params, callback) end

---@param from integer @1-based index, similar to string.sub().
---@param to integer @1-based index, similar to string.sub().
---@param color rgbm|nil @Default value: `nil`.
---@param bold boolean|nil @Default value: `nil`.
function ui.setNextTextSpanStyle(from, to, color, bold) end

---@param command 'getSelected'|'getText'|'setText'|'keepStateOnEscape'|'suggest'|'selectAll'|'delete'|'undo'|'redo'|'paste'|'copy'|'cut'|''
---@param argument string|number|boolean|nil @Default value: `nil`.
---@param lookActive boolean? @Default value: `true`.
---@return string?
function ui.inputTextCommand(command, argument, lookActive) end

---Draw filled circle (if `angleTo - angleFrom ≥ 2π`) or its sector. Optionally textured.
---@param center vec2 @Center of the circle.
---@param radius number @Circle radius.
---@param angleFrom number @Starting angle in radians.
---@param angleTo number @Ending angle in radians.
---@param color rgb|rgbm? @Color. Default value: `rgbm.colors.white`.
---@param image ui.ImageSource @Optional background image.
function ui.drawPie(center, radius, angleFrom, angleTo, color, image) end
