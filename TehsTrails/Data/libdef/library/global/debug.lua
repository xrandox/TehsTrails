---@meta

---@class Debug
Debug = {}

---Writes a message out to the script console.
---@param message string # The message to write out to the console.
function Debug.Print(this, message) end

---Writes a warning out to the script console.
---@param message string # The warning message to write out to the console.
function Debug.Warn(this, message) end

---Writes an error out to the script console.
---@param message string # The error message to write out to the console.
function Debug.Error(this, message) end

---Adds a static value or a table to the watch panel in the script console.
---@param key string # The key to show in the watch panel.
---@param value table # The value or table to watch.
---@overload fun(this: any, key: string, value: any)
function Debug.Watch(this, key, value) end

---Stops watching a static value or table.
---@param key string # The key used when calling Debug:Watch to clear.
function Debug.ClearWatch(this, key) end