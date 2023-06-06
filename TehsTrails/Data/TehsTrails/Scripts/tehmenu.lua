-- Click Functions

local function newColor(menu)
    -- clear any other checked boxes
    for index, value in ipairs(Teh.trailcolors.colors) do
        if (value[1] ~= menu.Name) then
            Debug:Print("Supposedly set " .. value[1] .. " to false")
            value[3].Checked = false
        else
            value[3].Checked = true
        end
    end

    -- change the color
    Teh_ChangeColor(menu.Name)
end

local function startingPointMarkers(menu)
    Teh_Toggle_Storage("globalMarkersToggled")
    menu.Checked = Teh_Is_True("globalMarkersToggled")
    Teh_ToggleGlobalMarker()
end

local function minimapTrails(menu)
    Teh_Toggle_Storage("minimapToggled")
    menu.Checked = Teh_Is_True("minimapToggled")
    Teh_SetMinimapVisibility()
end

local function mapZones(menu)
    Teh_Toggle_Storage("heartZonesOnMap")
    menu.Checked = Teh_Is_True("heartZonesOnMap")
    Teh_SetHeartZoneMapVisibility()
end

local function minimapZones(menu)
    Teh_Toggle_Storage("heartZonesOnMinimap")
    menu.Checked = Teh_Is_True("heartZonesOnMinimap")
    Teh_SetHeartZoneMinimapVisibility()
end

local function heartFollower(menu)
    Teh_Toggle_Storage("followerInfoToggled")
    menu.Checked = Teh_Is_True("followerInfoToggled")
end

local function heartPointer(menu)
    Teh_Toggle_Storage("followerVisibleToggled")
    menu.Checked = Teh_Is_True("followerVisibleToggled")
end

local function waypointHighlight(menu)
    Teh_Toggle_Storage("highlightToggled")
    menu.Checked = Teh_Is_True("highlightToggled")
end

local function routeMarkerHighlight(menu)
    Teh_Toggle_Storage("bounceToggled")
    menu.Checked = Teh_Is_True("bounceToggled")
end

local function resetClicked(menu)
    Teh_Reset_Scripts()
end

-- Creating Menu
local mainMenu = Menu:Add("Tehs Trails", nil)

-- Color menu
local colorMenu = mainMenu:Add("Select Trail Color", nil)

for i, value in ipairs(Teh.trailcolors.colors) do
    local name = value[1]
    local checked = false
    if (name == Teh.storage.trailColor) then
        checked = true
    end
    Teh.trailcolors.colors[i][3] = colorMenu:Add(name, newColor, true, checked)
end

mainMenu:Add("Toggle Starting Point Markers", startingPointMarkers, true, Teh_Is_True("globalMarkersToggled"))

-- Map menu
local mapOptionMenu = mainMenu:Add("Map Visibility Options", nil)
mapOptionMenu:Add("Show Main Trail on Minimap", minimapTrails, true, Teh_Is_True("minimapToggled"))
mapOptionMenu:Add("Show Heart Zones on Map", mapZones, true, Teh_Is_True("heartZonesOnMap"))
mapOptionMenu:Add("Show Heart Zones on Minimap", minimapZones, true, Teh_Is_True("heartZonesOnMinimap"))

-- Heart follower menu
local heartFollowerMenu = mainMenu:Add("Heart Follower Options", nil)
heartFollowerMenu:Add("Enable Heart Info Following", heartFollower, true, Teh_Is_True("followerInfoToggled"))
heartFollowerMenu:Add("Enable Visible Heart Pointer", heartPointer, true, Teh_Is_True("followerVisibleToggled"))

-- Other options
mainMenu:Add("Enable Waypoint Highlights", waypointHighlight, true, Teh_Is_True("highlightToggled"))
mainMenu:Add("Enable Route Marker Highlights", routeMarkerHighlight, true, Teh_Is_True("bounceToggled"))

-- Script reset
mainMenu:Add("  [  RESET ALL SCRIPTS  ]  ", resetClicked)