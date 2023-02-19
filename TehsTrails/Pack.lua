Teh = {}

Debug:Print("Loading Lua")

Teh.highlight = {
    currentWaypoint = nil,
    waypointHighlighted = false,
    currentSize = 100,
    sizeGrowing = true
}

Teh.heartpointer = {
    currentTarget = nil,
    isPointing = false,
    pointerMarker = nil
}



function Hide_reminders()
    Debug:Print("Hiding Reminders")
    World.CategoryByType("tt.mc.cm.se"):Hide()
    Debug:Print("Hid Reminders")
end

--Sets the given marker GUID as the current waypoint and highlights it
function Teh_Highlight_Waypoint(marker, isfocused, markerguid)
    local waypoint = World:MarkerByGuid(markerguid)

    if (isfocused) then
        waypoint:SetTexture("Data/TehsTrails/Markers/waypoint-highlight.png")
        waypoint.MapVisibility = true
        waypoint.MiniMapVisibility = true
        Teh.highlight.currentWaypoint = waypoint
        Teh.highlight.waypointHighlighted = true
    end

end

--Grows or shrinks the highlight on the map
function Teh_Grow_Highlight()
    local size = Teh.highlight.currentSize
    local growing = Teh.highlight.sizeGrowing
    local MAX_SIZE = 200
    local MIN_SIZE = 100
    local INTERVAL = 2

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
        waypoint:SetTexture("Data/TehsTrails/Markers/Waypoint.png")
        waypoint.MapVisibility = false
        waypoint.MiniMapVisibility = false
        Teh.highlight.waypointHighlighted = false
        return false
    end

    return true
end

function Teh_Tick_Handler(gameTime)
    if (Teh.highlight.waypointHighlighted) then
        Teh_Tick_Highlight()
    end

    if (Teh.heartpointer.isPointing) then
        Teh_Tick_HeartPointer()
    end
end

--Checks if the highlighted waypoint is still valid
--If it is, checks if the map is open and grows/shrinks it
function Teh_Tick_Highlight(gameTime)
    if (Teh_Validate_Highlight()) then
        if (Mumble.UI.IsMapOpen) then Teh_Grow_Highlight() end
    end
end

function Teh_Tick_HeartPointer(gameTime)
    local target = Teh.heartpointer.currentTarget
    local pointer = Teh.heartpointer.pointerMarker

    if (target.Focused) then
        Teh.heartpointer.isPointing = false
        Teh.heartpointer.pointerMarker.InGameVisibility = false;
        return
    end

    local playerPos = Mumble.PlayerCharacter.Position
    local vector = (target.Position - playerPos)
    vector = vector / vector:Length()
    local targetPos = playerPos + vector * 2

    pointer:SetPos(targetPos.X, targetPos.Y, targetPos.Z - 1.5)
    local rotZ = (math.atan2(vector.Y, vector.X) - ((3 * math.pi) / 2))
    local rotX = (-math.atan(vector.Z, vector.X))
    pointer:SetRotZ(rotZ)
    pointer:SetRotX(rotX)
end

-- Credit to Freesnow for the base point function
function Teh_Heart_Pointer(marker, isfocused, guid)
    -- We use the category as a toggle for this feature.
    if (isfocused) then
        Debug:Print("Start Heart marker focused")
        --create a copy of target marker to be the pointer
        local pointer = Pack:CreateMarker()
        local target = World:MarkerByGuid(guid)
        pointer.Texture = target.Texture
        pointer.MiniMapVisibility = false;
        pointer.MapVisibility = false;
        Teh.heartpointer.currentTarget = target
        Teh.heartpointer.isPointing = true
        Teh.heartpointer.pointerMarker = pointer
    end
end



Debug:Print("Hiding Reminders")

Hide_reminders()

Debug:Print("Setting Tick Handler")

Event:OnTick(Teh_Tick_Handler)

Debug:Print("Lua Loaded")
