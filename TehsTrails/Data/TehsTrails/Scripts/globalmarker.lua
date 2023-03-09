Teh.globalmarker = {
    currentMarkers = {},
    isVisible = false,
    rects = Teh.lookups.rects,
    coordinateTable = Teh.lookups.coordinateTable,
    category = World:CategoryByType("tt.mc.s.tgsp")
}

Debug:Watch("Global_Marker", Teh.globalmarker)

-- This function turns markers in the coordinate table to markers in the current map
function Teh_Global_Marker()

    -- get lookup table for current map
    local map = Teh.globalmarker.rects[Mumble.CurrentMap.Id]

    -- for every pair of coordinates in the table, find the relative positioning and create the marker
    for i, coords in ipairs(Teh.globalmarker.coordinateTable) do

        local x = (map.MapRect.TopLeft.x + (coords.x - map.ContinentRect.TopLeft.x) / map.ContinentRect.Width * map.MapRect.Width) / 39.3701
        local y = (map.MapRect.TopLeft.y - (coords.y - map.ContinentRect.TopLeft.y) / map.ContinentRect.Height * map.MapRect.Height) / 39.3701

        local attributes = {
            xpos = x,
            ypos = 0,
            zpos = y,
            MapDisplaySize = 100,
            MapVisibility = true,
            ScaleOnMapWithZoom = false
        }

        Teh.globalmarker.currentMarkers[i] = Pack:CreateMarker(attributes)
        Teh.globalmarker.currentMarkers[i]:SetTexture("Data/TehsTrails/Markers/waypoint-highlight.png")
    end

    Teh.globalmarker.isVisible = true
end

-- This function hides removes the markers once the user turns them off
function Teh_Hide_Global_Markers()
    Teh.globalmarker.isVisible = false

    if (Teh.globalmarker.currentMarkers ~= {}) then
        for i, marker in ipairs(Teh.globalmarker.currentMarkers) do
            marker:Remove()
        end

        Teh.globalmarker.currentMarkers = {}
    end
end

-- Tick handler for global markers. Waits to see if 
function Teh_Global_Marker_Handler(gameTime)

end