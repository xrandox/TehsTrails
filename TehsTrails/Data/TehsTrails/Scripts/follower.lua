Teh.heartfollower = {
    currentTarget = nil,
    isFollowing = false,
    followMarker = nil,
    target2 = nil,
    visible = false,
    originalMarker = nil,
}

Debug:Watch("heartfollower", Teh.heartfollower)

local category = World:CategoryByType("tt.s.tgsp")

--Creates a follower targeting the specified target GUID
local function createFollower(heartMarker, targetGuid)
    if (Teh.heartfollower.isFollowing) then --if we already have a follower, reset it
        Teh_FollowerReset()
    end

    local info = heartMarker:GetBehavior("InfoModifier").InfoValue

    local follower = Pack:CreateMarker({
        Info = info,
        TriggerRange = 5,
        InGameVisibility = false,
        MiniMapVisibility = false,
        MapVisibility = false,
        IconSize = "0.5",
        Category = category,
        iconFile = "Data/TehsTrails/Markers/Renown_Heart_empty.png"
    })

    if (Teh_GetBool("followerVisibleToggled")) then
        follower.InGameVisibility = true
        Teh.heartfollower.visible = true
    end

    heartMarker.TriggerRange = 0
    Teh.heartfollower.originalMarker = heartMarker
    Teh.heartfollower.currentTarget = World:MarkerByGuid(targetGuid)
    Teh.heartfollower.isFollowing = true
    Teh.heartfollower.followMarker = follower
    Teh.heartfollower.currentTarget.TriggerRange = 15
end

--Sets the given GUID as the target and creates a marker to point towards it and carrys around the info from the original marker
function Teh_HeartFollower(marker, isfocused, guid)
    if (not Teh_GetBool("followerInfoToggled")) then return end

    if (isfocused) then
        createFollower(marker, guid)
    end
end

--Same as Teh_HeartFollower only it points to endGuid but doesnt disappear until in disappearGuid's focus
function Teh_HeartFollower2(marker, isfocused, endGuid, disappearGuid)
    if (not Teh_GetBool("followerInfoToggled")) then return end

    if (isfocused) then
        createFollower(marker, endGuid)
        Teh.heartfollower.target2 = World:MarkerByGuid(disappearGuid)
    end
end

-- Animates the follower
function Teh_FollowerTickHandler(gameTime)
    local target = Teh.heartfollower.currentTarget
    local follower = Teh.heartfollower.followMarker

    -- Visibility checks
    if (not Teh_GetBool("followerInfoToggled")) then
        Teh_FollowerReset()
        return
    end

    if (not Teh_GetBool("followerVisibleToggled")) then
        Teh.heartfollower.visible = false
        follower.InGameVisibility = false
    else
        Teh.heartfollower.visible = true
        follower.InGameVisibility = true
    end

    --Reset checks
    if (Teh.heartfollower.target2 == nil and target.Focused) then
        Teh_FollowerReset()
        return
    end

    if (Teh.heartfollower.target2 ~= nil and Teh.heartfollower.target2.Focused) then
        Teh_FollowerReset()
        return
    end

    -- Animating the position/rotation
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

--Reset the follower
function Teh_FollowerReset()
    Teh.heartfollower.currentTarget.TriggerRange = 0
    Teh.heartfollower.originalMarker.TriggerRange = 15
    Teh.heartfollower.followMarker:Remove()
    Teh.heartfollower.currentTarget = nil
    Teh.heartfollower.isFollowing = false
    Teh.heartfollower.followMarker = nil
    Teh.heartfollower.target2 = nil
    Teh.heartfollower.visible = false
    Teh.heartfollower.originalMarker = nil
end