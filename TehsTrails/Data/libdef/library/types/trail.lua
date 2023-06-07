---@meta

---A marker pack trail.
---@class Trail
---@field Alpha number # The opacity of the trail (0 - 1).
---@field AnimationSpeed number # The speed of the trail animation (0 - 1).
---@field BehaviorFiltered boolean # [READ-ONLY] Indicates if the trail is actively filtered by a behavior.
---@field Behaviors IBehavior[]
---@field CanFade boolean
---@field Category Category # [READ-ONLY]
---@field CullDirection integer
---@field FadeFar number
---@field FadeNear number
---@field Guid any
---@field InGameVisibility any
---@field IsWall boolean
---@field MapId integer # [READ-ONLY]
---@field MapVisibility boolean
---@field MiniMapVisibility boolean
---@field ResetLength number
---@field Texture Texture
---@field Tint Color
---@field TrailSampleColor Color # The color of the trail on the minimap.
---@field TrailScale number
---@field TriggerRange number
local Trail = {}

---Focuses the trail.
function Trail.Focus(this) end

---Triggers the trail.
---@param isAutoTriggered boolean # Indicates if the trigger was from an auto trigger or if it was manually triggered.
function Trail.Interact(this, isAutoTriggered) end

---Unfocuses the trail.
function Trail.Unfocus(this) end

--#region Extension Functions

---Removes the trail.
function Trail.Remove(this) end

---Returns any matching behavior by its type name.
---@param behaviorName string # The name of the behavior type.
---@return IBehavior behavior
function Trail.GetBehavior(this, behaviorName) end

--#endregion