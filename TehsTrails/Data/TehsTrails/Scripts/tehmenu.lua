-- Click Functions
local function toggleTutorial(menu)
    Teh_ToggleTutorial()
end

local function enableTrailHighlighting(menu)
    Teh_ToggleStorage("trailHighlighting")
    menu.Checked = Teh_GetBool("trailHighlighting")
    Teh_ToggleTrailHighlighting()
end

local function transparentTrail(menu)
    Teh_ToggleStorage("trailHighlightingTransparency")
    menu.Checked = Teh_GetBool("trailHighlightingTransparency")
    Teh_TrailHighlightTransparency()
end

local function grayOutTrail(menu)
    Teh_ToggleStorage("trailHighlightingGray")
    menu.Checked = Teh_GetBool("trailHighlightingGray")
    Teh_TrailHighlightGray()
end

local function invisibleTrail(menu)
    Teh_ToggleStorage("trailHighlightingInvisible")
    menu.Checked = Teh_GetBool("trailHighlightingInvisible")
    Teh_TrailHighightInvisible()
end

local function resetTrailHighlighting(menu)
    Teh_ResetHighlightTrailSegment()
end

local function nextTrailHighlight(menu)
    Teh_ChangeHighlightTrailSegment(1)
end

local function previousTrailHighlight(menu)
    Teh_ChangeHighlightTrailSegment(-1)
end

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

local function alternateMounts(menu)
    Teh_AlternateMounts()
    menu.Checked = Teh_GetBool("alternateMounts")
end

local function openShoppingList(menu)
    Teh_ToggleShoppingList()
end

local function resetClicked(menu)
    if (Teh.bounce.isBouncing) then Teh_BounceReset() end
    if (Teh.heartfollower.isFollowing) then Teh_FollowerReset() end
    if (Teh.highlight.waypointHighlighted) then Teh_HighlightReset() end
    Teh_SaveValue("hasSkyscale", "false")
end

-- Creating Menu
local mainMenu = Menu:Add("Tehs Trails", nil)

local stut = mainMenu:Add("Show/Hide Tutorial", toggleTutorial, false, false, "Shows/Hides the pack tutorial. Make sure you're in a flat, open space!")

local trailHighlighting = mainMenu:Add("Trail Highlighting", nil, false, false, "Change various settings for trail highlighting")
local eth = trailHighlighting:Add("Enable Trail Highlighting", enableTrailHighlighting, true, Teh_GetBool("trailHighlighting"), "Enables/Disables the trail highlighting feature")
local highlightSettings = trailHighlighting:Add("Highlight Settings", nil, false, false, "Settings for the trail highlighting feature")
local transparency = highlightSettings:Add("Transparency", transparentTrail, true, Teh_GetBool("trailHighlightingTransparency"), "When enabled, the trail will be transparent except for the highlighted segment")
local grayed = highlightSettings:Add("Gray Out Trail", grayOutTrail, true, Teh_GetBool("trailHighlightingGray"), "When enabled, the trail will be grayed out except for the highlighted segment")
local invisible = highlightSettings:Add("Invisible Trail", invisibleTrail, true, Teh_GetBool("trailHighlightingInvisible"), "When enabled, the trail will be invisible except for the highlighted segment")
local highlightFunctions = trailHighlighting:Add("Highlight Functions", nil, false, false, "Functions to help with trail highlighting")
local rth = highlightFunctions:Add("Reset Trail Highlighting", resetTrailHighlighting, false, false, "Resets the trail highlighting feature to the beginning of the trail")
local nth = highlightFunctions:Add("Next Trail Highlight", nextTrailHighlight, false, false, "Cycles the highlighted trail to next trail segment (not always in the expected order)")
local pth = highlightFunctions:Add("Previous Trail Highlight", previousTrailHighlight, false, false, "Cycles the highlighted trail to previous trail segment (not always in the expected order)")


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
local ami = mainMenu:Add("Enable Alternate Mount Icons", alternateMounts, true, Teh_GetBool("alternateMounts"), "Switches out the custom mount icons for the Anet icons")
local ssl = mainMenu:Add("Open/Close Shopping List", openShoppingList, false, false, "Opens/Closes the shopping list with the items to buy for trading post hearts. Open away from NPCs!")
-- Script reset
local ras = mainMenu:Add("  [  RESET ALL SCRIPTS  ]  ", resetClicked, false, false, "Resets all currently running scripts in case there is a malfunction")