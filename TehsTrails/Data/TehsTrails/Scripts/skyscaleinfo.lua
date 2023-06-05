Teh.skyscale = {
    triggerRangeReduced = false
}

local skyscaleMarkers = World:CategoryByType("tt.mc.cm.mm.skyscale")
local notifierMarker = World:CategoryByType("tt.mc.cm.mm.skyscaleNotifier")

local function hideInfo()
    skyscaleMarkers.TriggerRange = 0
    saveValue("hasSkyscale", "true")
    Teh.skyscale.triggerRangeReduced = true
end

if (Teh.storage.hasSkyscale ~= nil) then
    if (Teh.storage.hasSkyscale == true) then
        hideInfo()
    end
else
    saveValue("hasSkyscale", "false")
end

function Teh_Skyscale(marker, gameTime)
    if (Teh.triggerRangeReduced == true) then return end

    if (notifierMarker.IsVisible) then
        hideInfo()
        saveValue("hasSkyscale", "true")
        return
    end
end