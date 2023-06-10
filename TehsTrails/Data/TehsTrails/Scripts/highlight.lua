Teh.highlight = {
    currentWaypoint = nil,
    currentTeleport = nil,
    waypointHighlighted = false,
    currentSize = 100,
    sizeGrowing = true,
    timeSinceStarted = 0,
    secondaryTarget = nil,
    optionalWaypoint = nil,
    category = World:CategoryByType("tt.s.ewh")
}

Debug:Watch("highlight", Teh.highlight)
local MAX_SIZE = 200
local MIN_SIZE = 100

-- Resets the highlight
function Teh_HighlightReset()
    local waypoint = Teh.highlight.currentWaypoint
    waypoint.MapVisibility = false
    waypoint.MiniMapVisibility = false
    waypoint.TriggerRange = 0
    if (Teh.highlight.optionalWaypoint ~= nil) then
        Teh.highlight.optionalWaypoint.MapVisibility = false
        Teh.highlight.optionalWaypoint.MiniMapVisibility = false
        Teh.highlight.optionalWaypoint.TriggerRange = 0
    end
    Teh.highlight.currentTeleport.TriggerRange = 15
    Teh.highlight.currentWaypoint = nil
    Teh.highlight.currentTeleport = nil
    Teh.highlight.waypointHighlighted = false
    Teh.highlight.currentSize = 100
    Teh.highlight.sizeGrowing = true
    Teh.highlight.timeSinceStarted = 0
    Teh.highlight.secondaryTarget = nil
    Teh.highlight.optionalWaypoint = nil
end

--Sets the given marker GUID as the current waypoint and highlights it
function Teh_HighlightWaypoint(marker, isfocused, markerguid)
    if (not Teh_GetBool("highlightToggled")) then return end

    local waypoint = World:MarkerByGuid(markerguid)

    if (isfocused) then
        if (Teh.highlight.waypointHighlighted) then
            Teh_HighlightReset()
        end

        -- If optional waypoint, we have to show that one too
        if (Teh.highlight.optionalWaypoint ~= nil) then
            Teh.highlight.optionalWaypoint:SetTexture("Data/TehsTrails/Markers/waypoint-highlight2.png")
            Teh.highlight.optionalWaypoint.MapVisibility = true
            Teh.highlight.optionalWaypoint.MiniMapVisibility = true
            Teh.highlight.optionalWaypoint.TriggerRange = 15
        end

        waypoint:SetTexture("Data/TehsTrails/Markers/waypoint-highlight.png")
        waypoint.MapVisibility = true
        waypoint.MiniMapVisibility = true
        waypoint.TriggerRange = 15
        Teh.highlight.currentTeleport = marker
        Teh.highlight.currentWaypoint = waypoint
        Teh.highlight.waypointHighlighted = true
        marker.TriggerRange = 0
    end
end

-- Highlights the given marker guid, but also sets a secondary target that will clear the waypoint when focused
function Teh_HighlightWaypoint2(marker, isfocused, markerguid, secondaryTarget)
    Teh.highlight.secondaryTarget = World:MarkerByGuid(secondaryTarget)
    Teh_HighlightWaypoint(marker, isfocused, markerguid)
end

-- Highlights the given marker guid, but also highlights a second waypoint in blue, reaching either will clear it
function Teh_HighlightWaypoint3(marker, isfocused, markerguid, optionalWaypoint)
    Teh.highlight.optionalWaypoint = World:MarkerByGuid(optionalWaypoint)
    Teh.highlight.secondaryTarget = Teh.highlight.optionalWaypoint
    Teh_HighlightWaypoint(marker, isfocused, markerguid)
end

-- Animates the highlight on the map
function Teh_HighlightTickHandler(gameTime)
    if (not Teh_GetBool("highlightToggled")) then
        Teh_HighlightReset()
        return
    end
    local elapsedSeconds = gameTime.ElapsedGameTime.TotalSeconds
    Teh.highlight.timeSinceStarted = Teh.highlight.timeSinceStarted + elapsedSeconds
    if (Teh.highlight.timeSinceStarted > 300) then
        Teh_HighlightReset()
        return
    end

    local size = Teh.highlight.currentSize
    local growing = Teh.highlight.sizeGrowing
    local INTERVAL = 180 * elapsedSeconds

    if (growing) then
        size = size + INTERVAL;
    else
        size = size - INTERVAL;
    end
    Teh.highlight.currentSize = size

    if (size > MAX_SIZE) then growing = false end
    if (size < MIN_SIZE) then growing = true end
    Teh.highlight.sizeGrowing = growing

    Teh.highlight.currentWaypoint.MapDisplaySize = size
    -- If optional waypoint, we have to grow/shrink that too
    if (Teh.highlight.optionalWaypoint ~= nil) then
        Teh.highlight.optionalWaypoint.MapDisplaySize = size
    end
end

--Checks if highlighted waypoing is focused, if it is, stop highlighting it.
--Returns true if the waypoint is still highlighted
function Teh_ValidateHighlight()
    local waypoint = Teh.highlight.currentWaypoint
    local secondaryTarget = Teh.highlight.secondaryTarget
    if (waypoint.Focused) then
        Teh_HighlightReset()
        return false
    end
    if (secondaryTarget ~= nil and secondaryTarget.Focused) then
        Teh_HighlightReset()
        return false
    end
    return true
end
