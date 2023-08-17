---@meta

---A marker pack marker.
---@class Marker
---@field Alpha number # The opacity of the marker (0 - 1).
---@field AutoTrigger boolean
---@field BehaviorFiltered boolean # [READ-ONLY] Indicates if the marker is actively filtered by a behavior.
---@field Behaviors IBehavior[]
---@field CanFade boolean
---@field Category Category # [READ-ONLY]
---@field CullDirection integer
---@field DistanceToPlayer number
---@field DrawOrder number
---@field FadeFar number
---@field FadeNear number
---@field Focused boolean
---@field Guid any
---@field HeightOffset number
---@field InGameVisibility any
---@field InvertBehavior boolean
---@field MapDisplaySize number
---@field MapId integer # [READ-ONLY]
---@field MapVisibility boolean
---@field MaxSize number
---@field MiniMapVisibility boolean
---@field MinSize number
---@field Position Vector3
---@field ResetLength number
---@field RotationXyz Vector3
---@field ScaleOnMapWithZoom boolean
---@field Size number
---@field Texture Texture
---@field Tint Color
---@field TipDescription string
---@field TipName string
---@field TriggerRange number
local Marker = {}

---Focuses the marker.
function Marker.Focus(this) end

---Triggers the marker.
---@param isAutoTriggered boolean # Indicates if the trigger was from an auto trigger or if it was manually triggered.
function Marker.Interact(this, isAutoTriggered) end

---Unfocuses the marker.
function Marker.Unfocus(this) end

--#region Extension Functions

---Sets the x,y,z position of the marker.
---@param x number
---@param y number
---@param z number
---@overload fun(this: any, vector: Vector3)
function Marker.SetPos(this, x, y, z) end

---Set the X coordinate of the marker.
---@param x number # The X coordinate to set the marker to.
function Marker.SetPosX(this, x) end

---Set the Y coordinate of the marker.
---@param this any
---@param y number # The Y coordinate to set the marker to.
function Marker.SetPosY(this, y) end

---Set the Z coordinate of the marker.
---@param z number # The Z coordinate to set the marker to.
function Marker.SetPosZ(this, z) end

---Set the rotation of the marker (in radians).
---@param x number
---@param y number
---@param z number
---@overload fun(this: any, vector: Vector3)
function Marker.SetRot(this, x, y, z) end

---Set the x rotation of the marker (in radians).
---@param x number
function Marker.SetRotX(this, x) end

---Set the y rotation of the marker (in radians).
---@param y number
function Marker.SetRotY(this, y) end

---Set the z rotation of the marker (in radians).
---@param z number
function Marker.SetRotZ(this, z) end

---Removes the marker.
function Marker.Remove(this) end

---Sets the texture of the marker.
---@param texturePath string # The relative path to the texture (relative to the root of the marker pack).
function Marker.SetTexture(this, texturePath) end

---Sets the texture of the marker using an asset from the public CDN.
---@param textureId integer # The relative path to the texture (relative to the root of the marker pack).
function Marker.SetTexture(this, textureId) end

---Returns any matching behavior by its type name.
---@param behaviorName string # The name of the behavior type.
---@return IBehavior behavior
function Marker.GetBehavior(this, behaviorName) end

--#endregion