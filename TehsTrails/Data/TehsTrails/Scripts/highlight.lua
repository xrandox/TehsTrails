Teh.highlight = {
    currentWaypoint = nil,
    waypointHighlighted = false,
    currentSize = 100,
    sizeGrowing = true,
    timeSinceStarted = 0
}

Debug:Watch("highlight", Teh.highlight)

local function Teh_Highlight_Reset()
    local waypoint = Teh.highlight.currentWaypoint
    waypoint.MapVisibility = false
    waypoint.MiniMapVisibility = false
    Teh.highlight.waypointHighlighted = false
end

--Sets the given marker GUID as the current waypoint and highlights it
function Teh_Highlight_Waypoint(marker, isfocused, markerguid)
    if (not World:CategoryByType("tt.mc.s.ewh"):IsVisible()) then return end

    local waypoint = World:MarkerByGuid(markerguid)

    if (isfocused) then
        if (Teh.highlight.waypointHighlighted) then
            Teh_Highlight_Reset()
        end
        waypoint:SetTexture("Data/TehsTrails/Markers/waypoint-highlight.png")
        waypoint.MapVisibility = true
        waypoint.MiniMapVisibility = true
        Teh.highlight.currentWaypoint = waypoint
        Teh.highlight.waypointHighlighted = true
        Teh.highlight.timeSinceStarted = 0
    end

end

--Grows or shrinks the highlight on the map
function Teh_Tick_Highlight(gameTime)
    if (not World:CategoryByType("tt.mc.s.ewh"):IsVisible()) then Teh_Highlight_Reset() return end
    local elapsedSeconds = gameTime.ElapsedGameTime.TotalSeconds
    Teh.highlight.timeSinceStarted = Teh.highlight.timeSinceStarted + elapsedSeconds
    if (Teh.highlight.timeSinceStarted > 300) then Teh_Highlight_Reset() return end

    local size = Teh.highlight.currentSize
    local growing = Teh.highlight.sizeGrowing
    local MAX_SIZE = 200
    local MIN_SIZE = 100
    local INTERVAL = 180 * elapsedSeconds

    if (growing) then size = size + INTERVAL;
    else size = size - INTERVAL; end
    Teh.highlight.currentSize = size

    if (size > MAX_SIZE) then growing = false end
    if (size < MIN_SIZE) then growing = true end
    Teh.highlight.sizeGrowing = growing

    Teh.highlight.currentWaypoint.MapDisplaySize = size
end

--Checks if highlighted waypoing is focused, if it is, stop highlighting it.
--Returns true if the waypoint is still highlighted
function Teh_Validate_Highlight()
    local waypoint = Teh.highlight.currentWaypoint
    if (waypoint.Focused) then
            Teh_Highlight_Reset()
        return false
    end
    return true
end

