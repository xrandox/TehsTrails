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

---Creates a new Marker.
---@param pack Pack # The pack to associate the marker with.
---@param attributes? table # A dictionary of attributes.
---@return Marker marker # The created marker.
function I.Marker(this, pack, attributes) end

---Creates a new Guid.
---@param base64 string # The base64 encoded Guid.
---@return Guid guid
function I.Guid(this, base64) end

---Gets a texture by Asset ID from the public CDN.
---@param textureId integer
---@return Texture texture
function I.Texture(this, textureId) end

---Gets a texture from a marker pack.
---@param pack Pack
---@param texturePath string # The relative path to the texture (relative to the root of the marker pack).
---@return Texture texture
function I.Texture(this, pack, texturePath) end