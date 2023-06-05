local trailCategory = World:CategoryByType("tt.mc.ct.mapB")

-- Toggles the actual visibility 
local function toggleMinimapVisibility()
    local allTrails = trailCategory:GetMarkers(true);
    if (Teh.storage.minimapToggled == "true") then
        for index, value in ipairs(allTrails) do
            value.MiniMapVisibility = true
        end
    else
        for index, value in ipairs(allTrails) do
            value.MiniMapVisibility = false
        end
    end
end

-- Toggles the minimap
function Teh_FlipMinimapToggle()
    if (Teh.storage.minimapToggled == "true") then
        saveValue("minimapToggled", "false")
    else
        saveValue("minimapToggled", "true")
    end

    toggleMinimapVisibility()
end

-- Check toggle on start up
toggleMinimapVisibility()