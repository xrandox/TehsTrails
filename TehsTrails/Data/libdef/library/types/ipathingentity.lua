---@meta

---@class IPathable
---@field Guid any
---@field Behaviors IBehavior[]
---@field BehaviorFiltered boolean # [READ ONLY] Indicates if the pathable is actively filtered by a behavior.
---@field TriggerRange number
---@field DistanceToPlayer number
---@field MapId integer # [READ-ONLY]
---@field Category Category # [READ-ONLY]

local IPathable = {}

---Focuses the pathable.
function IPathable.Focus(this) end

---Triggers the pathable.
---@param isAutoTriggered boolean # Indicates if the trigger was from an auto trigger or if it was manually triggered.
function IPathable.Interact(this, isAutoTriggered) end

---Unfocuses the pathable.
function IPathable.Unfocus(this) end