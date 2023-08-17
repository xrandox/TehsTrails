
-- This is a maker-only function that converts markers to their continent coordinates. Never gets run during normal pack use.
function Teh_Convert_Markers()
    -- Note for Teh: Doing this with the test pack is preferred
    local startMarkers = World:CategoryByType("tt.start"):GetMarkers(true)

    for i, marker in ipairs(startMarkers) do

        --hardcoded from lions arch
        local mapBottomLeftX = -27648
        local mapTopRightX = 30720
        local continentBottomRightX = 50432
        local continentTopLeftX = 48000
        local mapBottomLeftY = -18432
        local mapTopRightY = 18432
        local continentBottomRightY = 32256
        local continentTopLeftY = 30720

        local xContinent = continentTopLeftX + (1 * (((marker.Position.X * 39.3701) - mapBottomLeftX) / (mapTopRightX - mapBottomLeftX)) * (continentBottomRightX - continentTopLeftX))
        local yContinent = continentTopLeftY + (-1 * (((marker.Position.Y * 39.3701) - mapTopRightY) / ( mapTopRightY - mapBottomLeftY)) * (continentBottomRightY - continentTopLeftY))

        local str = "{ x = " .. xContinent .. ", y = " .. yContinent .. " },"
        Debug:Print(str)

    end
end