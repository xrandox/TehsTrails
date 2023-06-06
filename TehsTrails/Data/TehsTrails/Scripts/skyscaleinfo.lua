Teh.skyscale = {
    triggerRangeReduced = false,
    notOnSkyscale = true
}

Debug:Watch("Skyscale Info", Teh.skyscale)

local skyscaleMarkers = World:CategoryByType("tt.mc.cm.mm.skyscale"):GetMarkers()

local function hideInfo()
    for index, value in ipairs(skyscaleMarkers) do
        value.TriggerRange = 0
    end
    saveValue("hasSkyscale", "true")
    Teh.skyscale.triggerRangeReduced = true
end

function Teh_Skyscale(marker, gameTime)
    if (Teh.triggerRangeReduced == true) then return end

    local behavior = marker:GetBehavior("MountFilter")
    local isFiltered = behavior:IsFiltered()
    Teh.skyscale.notOnSkyscale = isFiltered
    if (isFiltered == false) then
        hideInfo()
    end
end

if (Teh.storage.hasSkyscale == true) then
    hideInfo()
end