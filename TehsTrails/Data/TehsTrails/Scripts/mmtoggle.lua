Teh.mmtoggle = {
    hpTrailCategories = { World:CategoryByType("tt.mc.hp.hpt"), World:CategoryByType("tt.hot.hp.hpt")},
}

local mainTrail = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Vg==")
local heartZone = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Pg==")
local hpTrail = World:TrailByGuid("cBjdPjPzKUCzvLBRSwAogQ==")
local tosTrail = World:TrailByGuid("e5IfDBZwtkC6VYNhUxXhng==")

function Teh_SetMinimapVisibility()
    if (mainTrail == nil) then
        Debug:Warn("Could not find reference to Main Trail on the current map: " .. Mumble.CurrentMap.Id)
        return
    end
    mainTrail.MiniMapVisibility = Teh_GetBool("minimapToggled")
    Teh_TryHighlightActiveTrail()
end

function Teh_SetHeartZoneMapVisibility()
    if (heartZone == nil) then return end
    heartZone.MapVisibility = Teh_GetBool("heartZonesOnMap")
end

function Teh_SetHeartZoneMinimapVisibility()
    if (heartZone == nil) then return end
    heartZone.MiniMapVisibility = Teh_GetBool("heartZonesOnMinimap")
end

function Teh_SetHPTrailMapVisibility()
    if (hpTrail == nil) then return end
    hpTrail.MapVisibility = Teh_GetBool("hpTrailsOnMap")
end

function Teh_SetHPTrailMinimapVisibility()
    if (hpTrail == nil) then return end
    hpTrail.MiniMapVisibility = Teh_GetBool("hpTrailsOnMinimap")
end

function Teh_SetTosTrailMapVisibility()
    if (tosTrail == nil) then return end
    tosTrail.MapVisibility = Teh_GetBool("tosTrailsOnMap")
end

function Teh_SetTosTrailMinimapVisibility()
    if (tosTrail == nil) then return end
    tosTrail.MiniMapVisibility = Teh_GetBool("tosTrailsOnMinimap")
end

-- Check toggles on start up
Teh_SetMinimapVisibility()
Teh_SetHeartZoneMapVisibility()
Teh_SetHeartZoneMinimapVisibility()
Teh_SetHPTrailMapVisibility()
Teh_SetHPTrailMinimapVisibility()
Teh_SetTosTrailMapVisibility()
Teh_SetTosTrailMinimapVisibility()