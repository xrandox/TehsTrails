Teh.heartfollower = {
    currentTarget = nil,
    isFollowing = false,
    followMarker = nil,
    target2 = nil,
    originalPosition = nil
}

Debug:Watch("heartfollower", Teh.heartfollower)

--Sets the given GUID as the target and yoinks the original marker to follow the user around
function Teh_Heart_Follower(marker, isfocused, guid)
    -- We use the category as a toggle for this feature.
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then return end
    if (isfocused) then
        --create a copy of target marker to be the pointer
        Teh.heartfollower.originalPosition = marker.Position
        Teh.heartfollower.currentTarget = World:MarkerByGuid(guid)
        Teh.heartfollower.isFollowing = true
        local follower = marker
        if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then follower.InGameVisibility = false end
        follower.TriggerRange = 5
        Teh.heartfollower.followMarker = follower
    end
end

-- Animates the follower
function Teh_Tick_HeartFollower(gameTime)
    local target = Teh.heartfollower.currentTarget
    local follower = Teh.heartfollower.followMarker

    if (Teh.heartfollower.target2 == nil and target.Focused) then
        Teh_Follower_Reset()
        return
    end

    if (not (Teh.heartfollower.target2 == nil)) then
        if (Teh.heartfollower.target2.Focused) then
            Teh_Follower_Reset()
            return
        end
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

function Teh_Follower_Reset()
    Teh.heartfollower.isFollowing = false
    Teh.heartfollower.followMarker.InGameVisibility = true
    Teh.heartfollower.followMarker:SetPos(Teh.heartfollower.originalPosition)
    Teh.heartfollower.followMarker.RotationXyz = nil
    Teh.heartfollower.currentTarget = nil
    Teh.heartfollower.followMarker = nil
    Teh.heartfollower.originalPosition = nil
    Teh.heartfollower.target2 = nil
end

function Teh_Heart_Follower_2(marker, isfocused, endGuid, disappearGuid)
    -- We use the category as a toggle for this feature.
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then return end
    if (isfocused) then
        Debug:Print("Heart follower pointing to: " .. endGuid .. " and disappearing at " .. disappearGuid)
        --create a copy of target marker to be the pointer
        Teh.heartfollower.originalPosition = marker.Position
        Teh.heartfollower.currentTarget = World:MarkerByGuid(endGuid)
        Teh.heartfollower.target2 = World:MarkerByGuid(disappearGuid)
        Teh.heartfollower.isFollowing = true
        local follower = marker
        if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then follower.InGameVisibility = false end
        follower.TriggerRange = 5
        Teh.heartfollower.followMarker = follower
    end
end