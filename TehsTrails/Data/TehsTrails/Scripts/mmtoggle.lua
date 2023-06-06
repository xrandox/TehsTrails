-- Sets the 
function Teh_SetMinimapVisibility()
    local mainTrail = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Vg==")
    if (mainTrail == nil) then return end
    mainTrail.MiniMapVisibility = Teh_Is_True("minimapToggled")
end

function Teh_SetHeartZoneMapVisibility()
    local heartZone = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Pg==")
    if (heartZone == nil) then return end
    heartZone.MapVisibility = Teh_Is_True("heartZonesOnMap")
end

function Teh_SetHeartZoneMinimapVisibility()
    local heartZone = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Pg==")
    if (heartZone == nil) then return end
    heartZone.MiniMapVisibility = Teh_Is_True("heartZonesOnMinimap")
end

-- Check toggles on start up
Teh_SetMinimapVisibility()
Teh_SetHeartZoneMapVisibility()
Teh_SetHeartZoneMinimapVisibility()