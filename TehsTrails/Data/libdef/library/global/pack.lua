---@meta

---@class Pack
Pack = {}

---Executes the Lua file specified.
---@param path string The relative path to the script.  Must be relative to the root of the marker pack.  `.lua` at the end is optional.
function Pack.Require(this, path) end

---Creates a new marker within the marker pack.
---@param attributes? table # A dictionary of attributes.
---@return Marker marker # The created marker.
function Pack.CreateMarker(this, attributes) end