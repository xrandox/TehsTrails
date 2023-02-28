Teh = {}

Debug:Print("Loading Lua")

Pack:Require("Data/TehsTrails/Scripts/hide.lua")
Pack:Require("Data/TehsTrails/Scripts/follower.lua")
Pack:Require("Data/TehsTrails/Scripts/bounce.lua")
Pack:Require("Data/TehsTrails/Scripts/highlight.lua")
Pack:Require("Data/TehsTrails/Scripts/settings.lua")

function Teh_Tick_Handler(gameTime)
    if (Teh.highlight.waypointHighlighted) then
        if (Teh_Validate_Highlight()) then
            Teh_Tick_Highlight(gameTime)
        end
    end

    if (Teh.heartfollower.isFollowing) then
        Teh_Tick_HeartFollower()
    end

    if (Teh.bounce.isBouncing) then
        Teh_Tick_Bounce(gameTime)
    end

    --Teh_Settings_Handler()
end

Hide_reminders()

Event:OnTick(Teh_Tick_Handler)
