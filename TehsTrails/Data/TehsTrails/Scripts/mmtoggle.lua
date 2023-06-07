local mainTrail = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Vg==")
local heartZone = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Pg==")

function Teh_SetMinimapVisibility()
    mainTrail.MiniMapVisibility = Teh_GetBool("minimapToggled")
end

function Teh_SetHeartZoneMapVisibility()
    if (heartZone == nil) then return end
    heartZone.MapVisibility = Teh_GetBool("heartZonesOnMap")
end

function Teh_SetHeartZoneMinimapVisibility()
    if (heartZone == nil) then return end
    heartZone.MiniMapVisibility = Teh_GetBool("heartZonesOnMinimap")
end

-- Check toggles on start up
Teh_SetMinimapVisibility()
Teh_SetHeartZoneMapVisibility()
Teh_SetHeartZoneMinimapVisibility()