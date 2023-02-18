---@meta

---@class Event
Event = {}

---Registers the provided function with the tick handler.  The provided function will be called every tick.
---@param delegate fun(gameTime: GameTime)
function Event.OnTick(this, delegate) end