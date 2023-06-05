Teh = {}

Debug:Print("Loading Lua")

-- Loading storage first
Pack:Require("Data/TehsTrails/Scripts/storage.lua")

Pack:Require("Data/TehsTrails/Scripts/hide.lua")
Pack:Require("Data/TehsTrails/Scripts/lookups.lua")
Pack:Require("Data/TehsTrails/Scripts/reset.lua")
Pack:Require("Data/TehsTrails/Scripts/follower.lua")
Pack:Require("Data/TehsTrails/Scripts/bounce.lua")
Pack:Require("Data/TehsTrails/Scripts/highlight.lua")
--Pack:Require("Data/TehsTrails/Scripts/settings.lua")
Pack:Require("Data/TehsTrails/Scripts/globalmarker.lua")
Pack:Require("Data/TehsTrails/Scripts/staticcategories.lua")
Pack:Require("Data/TehsTrails/Scripts/copy.lua")
Pack:Require("Data/TehsTrails/Scripts/tehmenu.lua")
--Pack:Require("Data/TehsTrails/Scripts/globalconverter.lua")

function Teh_Tick_Handler(gameTime)

    Teh_Reset_Handler(gameTime)

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

    if(Teh.globalmarker.category:IsVisible()) then
        if (Teh.globalmarker.isVisible) then return
        else
            Teh_Global_Marker()
            return
        end
    else
        if (Teh.globalmarker.isVisible) then
            Teh_Hide_Global_Markers()
        end
    end

    if (not Teh.static.ran) then
        Teh_Static_Categories(Mumble.CurrentMap.Id)
    end

    if (not Teh.copy.preloaded) then
        Teh_Preload_Copy()
    else Teh_Copy_Tick_Handler() end

    --Teh_Settings_Handler()
end

--Teh_Create_Menu()
--Teh_Convert_Markers()

Event:OnTick(Teh_Tick_Handler)
