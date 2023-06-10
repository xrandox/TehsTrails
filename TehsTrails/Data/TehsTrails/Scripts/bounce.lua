Teh.bounce = {
    currentTarget = nil,
    isBouncing = false,
    wasFocused = false,
    timeSinceStarted = 0
}

Debug:Watch("bounce", Teh.bounce)

-- Reset the bouncing marker to normal
function Teh_BounceReset()
    local target = Teh.bounce.currentTarget
    local bounce = target:GetBehavior("BounceModifier")
    bounce.BounceHeight = 0
    Teh.bounce.isBouncing = false
    local category = target.Category.Name
    if (category == "1") then
        target:SetTexture("Data/TehsTrails/Markers/1.png")
    elseif (category == "2") then
        target:SetTexture("Data/TehsTrails/Markers/2.png")
    elseif (category == "3") then
        target:SetTexture("Data/TehsTrails/Markers/3.png")
    end
    Teh.bounce.currentTarget = nil
    Teh.bounce.wasFocused = false
    Teh.bounce.timeSinceStarted = 0
end

-- Checks if the player enters the markers trigger range, if they do, waits for them to no longer be in the trigger range to stop it from bouncing
function Teh_BounceTickHandler(gameTime)
    Teh.bounce.timeSinceStarted = Teh.bounce.timeSinceStarted + gameTime.ElapsedGameTime.TotalSeconds
    if (not Teh_GetBool("bounceToggled")) then Teh_BounceReset() return end
    if (Teh.bounce.timeSinceStarted > 300) then Teh_BounceReset() return end

    if (Teh.bounce.wasFocused) then
        if (not Teh.bounce.currentTarget.Focused) then
                Teh_BounceReset()
            return
        end
        return
    end

    if (Teh.bounce.currentTarget.Focused) then
        Teh.bounce.wasFocused = true
    end
end

-- Makes the marker with the given guid bounce until you enter and leave it's trigger range
function Teh_Bounce(marker, isAutoTrigger, guid)
    if (not Teh_GetBool("bounceToggled")) then return end

    local target = World:MarkerByGuid(guid)
    local category = target.Category.Name

    local bounce = target:GetBehavior("BounceModifier")
    bounce.BounceHeight = 1

    if (category == "1") then
        target:SetTexture("Data/TehsTrails/Markers/1-shadow.png")
    elseif (category == "2") then
        target:SetTexture("Data/TehsTrails/Markers/2-shadow.png")
    elseif (category == "3") then
        target:SetTexture("Data/TehsTrails/Markers/3-shadow.png")
    end
    Teh.bounce.currentTarget = target
    Teh.bounce.isBouncing = true
    Teh.bounce.wasFocused = false
    Teh.bounce.timeSinceStarted = 0
end