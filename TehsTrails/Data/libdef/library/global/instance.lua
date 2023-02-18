---@meta

---@class I
I = {}

---Creates a new Vector3.
---@param x number # The X coordinate.
---@param y number # The Y coordinate.
---@param z number # The Z coordinate.
---@return Vector3 vector3
function I.Vector3(this, x, y, z) end

---Creates a new Color.
---@param r integer # The red component of the color (0 - 255)
---@param g integer # The green component of the color (0 - 255)
---@param b integer # The blue component of the color (0 - 255)
---@param a? integer # The alpha component of the color (0 - 255).  255 if no value is provided.
---@return Color color
function I.Color(this, r, g, b, a) end