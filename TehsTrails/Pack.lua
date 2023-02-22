Teh = {}

Debug:Print("Loading Lua")

Teh.highlight = {
    currentWaypoint = nil,
    waypointHighlighted = false,
    currentSize = 100,
    sizeGrowing = true
}

Teh.heartfollower = {
    currentTarget = nil,
    isFollowing = false,
    followMarker = nil
}

Teh.bounce = {
    currentTarget = nil,
    isBouncing = false,
    wasFocused = false,
    originalPosition = nil,
    originalRotation = nil
}



function Hide_reminders()
    Debug:Print("Hiding Reminders")
    World.CategoryByType("tt.mc.cm.se"):Hide()
    Debug:Print("Hid Reminders")
end

--Sets the given marker GUID as the current waypoint and highlights it
function Teh_Highlight_Waypoint(marker, isfocused, markerguid)
    if (World:CategoryByType("tt.mc.s.ewh"):IsVisible()) then return end
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
function Teh_Grow_Highlight(gameTime)
    local size = Teh.highlight.currentSize
    local growing = Teh.highlight.sizeGrowing
    local MAX_SIZE = 200
    local MIN_SIZE = 100
    local INTERVAL = 180 * gameTime.ElapsedGameTime.TotalSeconds

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
        Teh_Tick_Highlight(gameTime)
    end

    if (Teh.heartfollower.isFollowing) then
        Teh_Tick_HeartFollower()
    end

    if (Teh.bounce.isBouncing) then
        Teh_Tick_Bounce()
    end
end

--Checks if the highlighted waypoint is still valid
--If it is, checks if the map is open and grows/shrinks it
function Teh_Tick_Highlight(gameTime)
    if (Teh_Validate_Highlight()) then
        Teh_Grow_Highlight(gameTime)
    end
end

function Teh_Tick_HeartFollower(gameTime)
    local target = Teh.heartfollower.currentTarget
    local follower = Teh.heartfollower.followMarker

    if (target.Focused) then
        Teh.heartfollower.isFollowing = false
        Teh.heartfollower.followMarker.InGameVisibility = true
        Teh.heartfollower.followMarker:SetPos(Teh.heartfollower.originalPosition)
        Teh.heartfollower.followMarker:SetRot(math.rad(90),0,0)
        return
    end

    local playerPos = Mumble.PlayerCharacter.Position
    local vector = (target.Position - playerPos)
    vector = vector / vector:Length()
    local targetPos = playerPos + vector * 2

    follower:SetPos(targetPos.X, targetPos.Y, targetPos.Z - 1.5)
    local rotZ = (math.atan2(vector.Y, vector.X) - ((3 * math.pi) / 2))
    local rotX = (-math.atan(vector.Z, vector.X))
    follower:SetRotZ(rotZ)
    follower:SetRotX(rotX)
end

function Teh_Heart_Follower(marker, isfocused, guid)
    -- We use the category as a toggle for this feature.
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then return end
    if (isfocused) then
        --create a copy of target marker to be the pointer
        Teh.heartfollower.originalPosition = marker.Position
        Teh.heartfollower.originalRotation = marker.Rotation
        Teh.heartfollower.currentTarget = World:MarkerByGuid(guid)
        Teh.heartfollower.isFollowing = true
        local follower = marker
        if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then follower.InGameVisibility = false end
        follower.TriggerRange = 5
        Teh.heartfollower.followMarker = follower
    end
end


function Teh_Bounce(marker, isAutoTrigger, guid)
    if (not isAutoTrigger) then return end
    if (not World:CategoryByType("tt.mc.s.ermb"):IsVisible()) then return end
    local target = World:MarkerByGuid(guid)
    local bounce = target:GetBehavior("BounceModifier")
    bounce.BounceHeight = 1
    Teh.bounce.currentTarget = target
    Teh.bounce.isBouncing = true
    Teh.bounce.wasFocused = false
end

function Teh_Tick_Bounce()
    if (Teh.bounce.wasFocused) then
        if (not Teh.bounce.currentTarget.Focused) then
            local bounce = Teh.bounce.currentTarget:GetBehavior("BounceModifier")
            bounce.BounceHeight = 0
            Teh.bounce.isBouncing = false
            return
        end
        return
    end
    if (Teh.bounce.currentTarget.Focused) then
        Teh.bounce.wasFocused = true
    end
end

Debug:Print("Hiding Reminders")

Hide_reminders()

Debug:Print("Setting Tick Handler")

Event:OnTick(Teh_Tick_Handler)

Debug:Print("Lua Loaded")
