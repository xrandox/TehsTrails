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

function Teh_Highlight_Reset()
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
    Teh.highlight.currentTeleport = nil
    Teh.highlight.waypointHighlighted = false
    Teh.highlight.secondaryTarget = nil
    Teh.highlight.optionalWaypoint = nil
end

function Teh_Highlight_Waypoint_2(marker, isfocused, markerguid, secondaryTarget)
    Teh.highlight.secondaryTarget = World:MarkerByGuid(secondaryTarget)
    Teh_Highlight_Waypoint(marker, isfocused, markerguid)
end

function Teh_Highlight_Waypoint_3(marker, isfocused, markerguid, optionalWaypoint)
    Teh.highlight.optionalWaypoint = World:MarkerByGuid(optionalWaypoint)
    Teh.highlight.secondaryTarget = Teh.highlight.optionalWaypoint
    Teh_Highlight_Waypoint(marker, isfocused, markerguid)
end

--Sets the given marker GUID as the current waypoint and highlights it
function Teh_Highlight_Waypoint(marker, isfocused, markerguid)
    if (Teh.storage.highlightToggled == "false") then return end

    local waypoint = World:MarkerByGuid(markerguid)

    if (isfocused) then
        if (Teh.highlight.waypointHighlighted) then
            Teh_Highlight_Reset()
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
        Teh.highlight.timeSinceStarted = 0
        marker.TriggerRange = 0
    end
end

--Grows or shrinks the highlight on the map
function Teh_Tick_Highlight(gameTime)
    if (Teh.storage.highlightToggled == "false") then
        Teh_Highlight_Reset()
        return
    end
    local elapsedSeconds = gameTime.ElapsedGameTime.TotalSeconds
    Teh.highlight.timeSinceStarted = Teh.highlight.timeSinceStarted + elapsedSeconds
    if (Teh.highlight.timeSinceStarted > 300) then
        Teh_Highlight_Reset()
        return
    end

    local size = Teh.highlight.currentSize
    local growing = Teh.highlight.sizeGrowing
    local MAX_SIZE = 200
    local MIN_SIZE = 100
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
function Teh_Validate_Highlight()
    local waypoint = Teh.highlight.currentWaypoint
    local secondaryTarget = Teh.highlight.secondaryTarget
    if (waypoint.Focused) then
        Teh_Highlight_Reset()
        return false
    end
    if (secondaryTarget ~= nil) then
        if (secondaryTarget.Focused) then
            Teh_Highlight_Reset()
            return false
        end
    end
    return true
end
