Teh.skyscale = {
    triggerRangeReduced = false,
    notOnSkyscale = true
}

Debug:Watch("Skyscale Info", Teh.skyscale)

local skyscaleMarkers = World:CategoryByType("tt.mc.cm.mm.skyscale"):GetMarkers()

local function hideInfo()
    for _, value in ipairs(skyscaleMarkers) do
        value.TriggerRange = 0
    end
    Teh_SaveValue("hasSkyscale", "true")
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

function Teh_SkyscaleOptionalMarker(marker, gameTime)
    -- If they have a skyscale, hide the optional markers
    if (Teh.skyscale.triggerRangeReduced) then
        marker.InGameVisibility = false
    end
end

if (Teh.storage.hasSkyscale == true) then
    hideInfo()
end