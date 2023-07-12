Teh.tutorial = {
    MARKERS_IN_CIRCLE = 8,
    MARKER_DISTANCE_FROM_PLAYER = 10,
    origin = nil,
    markerOffsets = {},
    markerInfoCatalog = {
        {},
        {},
        {},
        {},
        {},
        {},
        {},
        {}
    },
    markers = {}
}

Debug:Watch("tutorial", Teh.tutorial)


local function showTutorial()
    -- First we make the outer markers
    -- get angle between each marker
    local angle = 2 * math.pi / Teh.tutorial.MARKERS_IN_CIRCLE
    -- get player position as the origin
    Teh.tutorial.origin = Mumble.PlayerCharacter.Position

    for i = 1, Teh.tutorial.MARKERS_IN_CIRCLE do
        local theta = angle * i
        local x = Teh.tutorial.MARKER_DISTANCE_FROM_PLAYER * math.cos(theta)
        local y = Teh.tutorial.MARKER_DISTANCE_FROM_PLAYER * math.sin(theta)

        local attributes = {
            xpos = Teh.tutorial.origin.X + x,
            ypos = Teh.tutorial.origin.Z,
            zpos = Teh.tutorial.origin.Y + y,
            MapVisibility = false,
            InGameVisibility = true,
            Info = "Test " .. i,
            InfoRange = 5,
            type = "tt.mc.cm.rm.points_of_interest",
            iconFile = "Data/TehsTrails/Markers/talk.png"
        }

        local newMarker = Pack:CreateMarker(attributes)
        Debug:Print(newMarker.Category.DisplayName .. " X:" .. newMarker.Position.X .. " Y:" .. newMarker.Position.Y .. " Z:" .. newMarker.Position.Z)
        Debug:Watch("New Marker " .. i, newMarker)
        table.insert(Teh.tutorial.markers, newMarker)
    end

    -- End by making the marker on top of the player
    local attributes = {
        xpos = Teh.tutorial.origin.X,
        ypos = Teh.tutorial.origin.Y,
        zpos = Teh.tutorial.origin.Z,
        MapVisibility = false,
        InGameVisibility = true,
        Info = "Test 0",
        InfoRange = 5,
        Category = "tt.mc.cm.rm.points_of_interest",
        iconFile = "Data/TehsTrails/Markers/waypoint-highlight.png"
    }

    local newMarker = Pack:CreateMarker(attributes)
    table.insert(Teh.tutorial.markers, newMarker)
end

if (Teh_GetBool("firstLaunch")) then
    showTutorial()
    --Teh_ToggleStorage("firstLaunch")
end

