-- Click Functions

local function newColor(menu)
    -- clear any other checked boxes
    for index, value in ipairs(Teh.trailcolors.colors) do
        if (value[1] ~= menu.Name) then
            value[3].Checked = false
        else
            value[3].Checked = true
        end
    end

    -- change the color
    Teh_ChangeColor(menu.Name)
end

local function startingPointMarkers(menu)
    Teh_ToggleStorage("globalMarkersToggled")
    menu.Checked = Teh_GetBool("globalMarkersToggled")
    Teh_ToggleGlobalMarker()
end

local function minimapTrails(menu)
    Teh_ToggleStorage("minimapToggled")
    menu.Checked = Teh_GetBool("minimapToggled")
    Teh_SetMinimapVisibility()
end

local function mapZones(menu)
    Teh_ToggleStorage("heartZonesOnMap")
    menu.Checked = Teh_GetBool("heartZonesOnMap")
    Teh_SetHeartZoneMapVisibility()
end

local function minimapZones(menu)
    Teh_ToggleStorage("heartZonesOnMinimap")
    menu.Checked = Teh_GetBool("heartZonesOnMinimap")
    Teh_SetHeartZoneMinimapVisibility()
end

local function heartFollower(menu)
    Teh_ToggleStorage("followerInfoToggled")
    menu.Checked = Teh_GetBool("followerInfoToggled")
end

local function heartPointer(menu)
    Teh_ToggleStorage("followerVisibleToggled")
    menu.Checked = Teh_GetBool("followerVisibleToggled")
end

local function waypointHighlight(menu)
    Teh_ToggleStorage("highlightToggled")
    menu.Checked = Teh_GetBool("highlightToggled")
end

local function routeMarkerHighlight(menu)
    Teh_ToggleStorage("bounceToggled")
    menu.Checked = Teh_GetBool("bounceToggled")
end

local function resetClicked(menu)
    if (Teh.bounce.isBouncing) then Teh_BounceReset() end
    if (Teh.heartfollower.isFollowing) then Teh_FollowerReset() end
    if (Teh.highlight.waypointHighlighted) then Teh_HighlightReset() end
    Teh_SaveValue("hasSkyscale", "false")
end

-- Creating Menu
local mainMenu = Menu:Add("Tehs Trails", nil)

-- Color menu
local colorMenu = mainMenu:Add("Select Trail Color", nil, false, false, "Changes the color of the main trail")

for i, value in ipairs(Teh.trailcolors.colors) do
    local name = value[1]
    local checked = false
    if (name == Teh.storage.trailColor) then
        checked = true
    end
    Teh.trailcolors.colors[i][3] = colorMenu:Add(name, newColor, true, checked)
end

mainMenu:Add("Toggle Starting Point Markers", startingPointMarkers, true, Teh_GetBool("globalMarkersToggled"), "Shows a highlight over the starting point for all zones (Core Tyria Only)")

-- Map menu
local mapOptionMenu = mainMenu:Add("Map Visibility Options", nil, false, false, "Requires Default for Show Trails on Map in Pathing Settings to work properly")
mapOptionMenu:Add("Show Main Trail on Minimap", minimapTrails, true, Teh_GetBool("minimapToggled"), "Draw the main trail on the minimap")
mapOptionMenu:Add("Show Heart Zones on Map", mapZones, true, Teh_GetBool("heartZonesOnMap"), "Draw heart zones on the Map")
mapOptionMenu:Add("Show Heart Zones on Minimap", minimapZones, true, Teh_GetBool("heartZonesOnMinimap"), "Draw heart zones on the Minimap")

-- Heart follower menu
local heartFollowerMenu = mainMenu:Add("Heart Follower Options", nil)
heartFollowerMenu:Add("Enable Heart Info Following", heartFollower, true, Teh_GetBool("followerInfoToggled"), "Makes it so that the information for hearts stays with you until you reach the end of the heart")
heartFollowerMenu:Add("Enable Visible Heart Pointer", heartPointer, true, Teh_GetBool("followerVisibleToggled"), "Points to the end of the heart to make it easier to get back on the trail after finishing a heart")

-- Other options
local ewh = mainMenu:Add("Enable Waypoint Highlights", waypointHighlight, true, Teh_GetBool("highlightToggled"), "Adds a highlight around the waypoint you are supposed to teleport to. Highly recommended to leave this on")
local rmh = mainMenu:Add("Enable Route Marker Highlights", routeMarkerHighlight, true, Teh_GetBool("bounceToggled"), "Adds a highlight and bounce effect to the route marker you are supposed to follow")

-- Script reset
local ras = mainMenu:Add("  [  RESET ALL SCRIPTS  ]  ", resetClicked, false, false, "Resets all currently running scripts in case there is a malfunction")