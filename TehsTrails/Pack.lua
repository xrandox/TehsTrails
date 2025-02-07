Teh = {}
TehsTrailsVersion = "BETA v6.0.0a"

Debug:Print("Pathing Version: v" .. PathingVersion)
Debug:Print("TehsTrails Version: " .. TehsTrailsVersion)
Debug:Print("Map: " .. Mumble.CurrentMap.Id)

-- First, hide the script reminders category (if the script runs, that means you have scripts enabled and dont need a reminder!)
World:CategoryByType("tt.mc.cm.se"):Hide()

-- Very next thing: do a version check
Pack:Require("Data/TehsTrails/Scripts/versioncheck.lua")

-- If the version check is good, then we load everything else
if (Teh_VersionCheck()) then
    -- Load storage first
    Pack:Require("Data/TehsTrails/Scripts/staticcategories.lua")

    if (Teh_MapIsIn(Teh.static.maps.all, Mumble.CurrentMap.Id) == false) then
        Debug:Print('Not in a map the pack is in. Stopped loading TehsTrails scripts.')
        return
    end

    Pack:Require("Data/TehsTrails/Scripts/storage.lua")
    Pack:Require("Data/TehsTrails/Scripts/alternatemounts.lua")
    Pack:Require("Data/TehsTrails/Scripts/mmtoggle.lua")
    Pack:Require("Data/TehsTrails/Scripts/lookups.lua")
    Pack:Require("Data/TehsTrails/Scripts/bounce.lua")
    Pack:Require("Data/TehsTrails/Scripts/highlight.lua")
    Pack:Require("Data/TehsTrails/Scripts/choosewaypoint.lua")
    Pack:Require("Data/TehsTrails/Scripts/globalmarker.lua")
    Pack:Require("Data/TehsTrails/Scripts/copy.lua")
    Pack:Require("Data/TehsTrails/Scripts/skyscaleinfo.lua")
    Pack:Require("Data/TehsTrails/Scripts/hpmarker.lua")
    Pack:Require("Data/TehsTrails/Scripts/follower.lua")
    Pack:Require("Data/TehsTrails/Scripts/tutorial.lua")
    Pack:Require("Data/TehsTrails/Scripts/shoppinglist.lua")
    Pack:Require("Data/TehsTrails/Scripts/trailcolors.lua")
    Pack:Require("Data/TehsTrails/Scripts/trailtransparency.lua")
    Pack:Require("Data/TehsTrails/Scripts/disappearingtrail.lua")
    Pack:Require("Data/TehsTrails/Scripts/trailhighlighting.lua")
    Pack:Require("Data/TehsTrails/Scripts/tehmenu.lua")
    --Pack:Require("Data/TehsTrails/Scripts/globalconverter.lua") used only when generating lookups

    local function tickHandler(gameTime)

        if (Teh.highlight.waypointHighlighted) then
            if (Teh_ValidateHighlight()) then
                Teh_HighlightTickHandler(gameTime)
            end
        end

        if (Teh.heartfollower.isFollowing) then
            Teh_FollowerTickHandler()
        end

        if (Teh.bounce.isBouncing) then
            Teh_BounceTickHandler(gameTime)
        end

        Teh_CopyTickHandler()

        Teh_TutorialTickHandler(gameTime)
    end

    --Teh_Convert_Markers() used only when generating lookups

    Event:OnTick(tickHandler)
end


