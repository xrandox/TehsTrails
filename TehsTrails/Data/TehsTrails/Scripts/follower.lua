Teh.heartfollower = {
    currentTarget = nil,
    isFollowing = false,
    followMarker = nil,
    target2 = nil,
    visible = false,
    originalMarker = nil
}

Debug:Watch("heartfollower", Teh.heartfollower)

--Sets the given GUID as the target and creates a marker to point towards it and carry around the info from the original marker
function Teh_Heart_Follower(marker, isfocused, guid)
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then return end
    if (Teh.heartfollower.isFollowing) then return end

    if (isfocused) then
        local infoMod = marker:GetBehavior("InfoModifier")
        local info = infoMod.InfoValue

        local follower = Pack:CreateMarker( {
            Info = info,
            TriggerRange = 5,
            InGameVisibility = false,
            MiniMapVisibility = false,
            MapVisibility = false,
            IconSize = 0.5
        })

        follower:SetTexture("Data/TehsTrails/Markers/Renown_Heart_empty.png")

        if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then
            follower.InGameVisibility = true
            Teh.heartfollower.visible = true
       end

       marker.TriggerRange = 1
       Teh.heartfollower.originalMarker = marker
       Teh.heartfollower.currentTarget = World:MarkerByGuid(guid)
       Teh.heartfollower.isFollowing = true
       Teh.heartfollower.followMarker = follower

    end
end

-- Animates the follower
function Teh_Tick_HeartFollower(gameTime)
    local target = Teh.heartfollower.currentTarget
    local follower = Teh.heartfollower.followMarker

-- Visibility checks
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then
        Teh_Follower_Reset()
        return
    end

    if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then
        Teh.heartfollower.visible = false
        follower.InGameVisibility = false
    else
        Teh.heartfollower.visible = true
        follower.InGameVisibility = true
    end

--Reset checks
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

--Animate if visible
    if (Teh.heartfollower.visible) then
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

end

--Reset the follower
function Teh_Follower_Reset()
    Teh.heartfollower.originalMarker.TriggerRange = 15
    Teh.heartfollower.isFollowing = false
    Teh.heartfollower.followMarker:Remove()
    Teh.heartfollower.currentTarget = nil
    Teh.heartfollower.followMarker = nil
    Teh.heartfollower.target2 = nil
    Teh.heartfollower.visible = false
    Teh.heartfollower.originalMarker = nil
end

--Same as Teh_Heart_Follower only it points to endGuid but doesnt disappear until in disappearGuid's focus
function Teh_Heart_Follower_2(marker, isfocused, endGuid, disappearGuid)
    if (not World:CategoryByType("tt.mc.s.ehif"):IsVisible()) then return end
    if (Teh.heartfollower.isFollowing) then return end

    if (isfocused) then
        local infoMod = marker:GetBehavior("InfoModifier")
        local info = infoMod.InfoValue

        local follower = Pack:CreateMarker( {
            Info = info,
            TriggerRange = 5,
            InGameVisibility = false,
            MiniMapVisibility = false,
            MapVisibility = false,
            IconSize = 0.5
        })

        follower:SetTexture("Data/TehsTrails/Markers/Renown_Heart_empty.png")

        if (not World:CategoryByType("tt.mc.s.ehif.evhp"):IsVisible()) then
            follower.InGameVisibility = true
            Teh.heartfollower.visible = true
       end

       marker.TriggerRange = 1
       Teh.heartfollower.originalMarker = marker
       Teh.heartfollower.currentTarget = World:MarkerByGuid(endGuid)
       Teh.heartfollower.target2 = World:MarkerByGuid(disappearGuid)
       Teh.heartfollower.isFollowing = true
       Teh.heartfollower.followMarker = follower

    end
end