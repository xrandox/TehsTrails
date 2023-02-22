Teh.bounce = {
    currentTarget = nil,
    isBouncing = false,
    wasFocused = false,
    originalPosition = nil,
    originalRotation = nil
}

Debug:Watch("bounce", Teh.bounce)

-- Makes the marker with the given guid bounce until you enter and leave it's trigger range
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

-- Checks if the player enters the markers trigger range, if they do, waits for them to no longer be in the trigger range to stop it from bouncing
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