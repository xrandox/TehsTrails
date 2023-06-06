Teh = {}

Debug:Print("Loading Lua")

-- Loading storage first
Pack:Require("Data/TehsTrails/Scripts/storage.lua")
Pack:Require("Data/TehsTrails/Scripts/trailcolors.lua")
Pack:Require("Data/TehsTrails/Scripts/hide.lua")
Pack:Require("Data/TehsTrails/Scripts/lookups.lua")
Pack:Require("Data/TehsTrails/Scripts/reset.lua")
Pack:Require("Data/TehsTrails/Scripts/follower.lua")
Pack:Require("Data/TehsTrails/Scripts/bounce.lua")
Pack:Require("Data/TehsTrails/Scripts/highlight.lua")
Pack:Require("Data/TehsTrails/Scripts/mmtoggle.lua")
Pack:Require("Data/TehsTrails/Scripts/globalmarker.lua")
Pack:Require("Data/TehsTrails/Scripts/staticcategories.lua")
Pack:Require("Data/TehsTrails/Scripts/copy.lua")
Pack:Require("Data/TehsTrails/Scripts/skyscaleinfo.lua")
Pack:Require("Data/TehsTrails/Scripts/tehmenu.lua")
--Pack:Require("Data/TehsTrails/Scripts/globalconverter.lua")

Teh_ChangeColor(Teh.storage.trailColor)

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

    if (not Teh.static.ran) then
        Teh_Static_Categories(Mumble.CurrentMap.Id)
    end

    if (not Teh.copy.preloaded) then
        Teh_Preload_Copy()
    else Teh_Copy_Tick_Handler() end

end

--Teh_Convert_Markers()

Event:OnTick(Teh_Tick_Handler)
