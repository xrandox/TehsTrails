---@meta

---@class TimeSpan
---@field Days integer # Gets the days component of the time interval.
---@field Hours integer # Gets the hours component of the time interval.
---@field Milliseconds integer # Gets the milliseconds component of the time interval.
---@field Minutes integer # Gets the minutes component of the time interval.
---@field Seconds integer # Gets the seconds component of the time interval.
---@field Ticks integer # Gets the number of ticks.
---@field TotalDays number # Gets the value of the time interval expressed in whole and fractional days.
---@field TotalHours number # Gets the value of the time interval expressed in whole and fractional hours.
---@field TotalMilliseconds number # Gets the value of the time interval expressed in whole and fractional milliseconds.
---@field TotalMinutes number # Gets the value of the time interval expressed in whole and fractional minutes.
---@field TotalSeconds number # Gets the value of the time interval expressed in whole and fractional seconds.
local TimeSpan = {}

---@class GameTime
---@field ElapsedGameTime TimeSpan # Time since the last tick call.
---@field TotalGameTime TimeSpan # Time since Blish HUD started.
local GameTime = {}