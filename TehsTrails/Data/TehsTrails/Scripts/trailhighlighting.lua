Teh.trailhighlighting = {
    trailCategories = { "tt.eod.mt.th", "tt.hot.mt.th", "tt.mc.mt.th", "tt.soto.mt.th" },
    firstTrailCategories = { "tt.eod.mt.th.t1", "tt.hot.mt.th.t1", "tt.mc.mt.th.t1", "tt.soto.mt.th.t1" },
    mainTrailCategories = { "tt.eod.mt.nt", "tt.hot.mt.nt", "tt.mc.mt.nt", "tt.soto.mt.nt" },
    allTrails = {},
    firstTrail = {},
    activeTrail = nil,
    activeTrailNumber = 1,
    mainTrails = {},
    consumed = {},
    warningmarker = nil
}

Debug:Watch('Teh_TrailHighlighting', Teh.trailhighlighting)

--#region PRELOAD
local function preload(categoryTypes, luaTable)
    Debug:Print("Preloading trails for highlighting")
    for _, categoryType in ipairs(categoryTypes) do
        local category = World:CategoryByType(categoryType)
        if (category ~= nil) then
            local trails = category:GetTrails(true)
            if (trails ~= nil) then
                for _, trail in pairs(trails) do
                    table.insert(luaTable, trail)
                end
            end
        end
    end
end

preload(Teh.trailhighlighting.trailCategories, Teh.trailhighlighting.allTrails)
preload(Teh.trailhighlighting.firstTrailCategories, Teh.trailhighlighting.firstTrail)
preload(Teh.trailhighlighting.mainTrailCategories, Teh.trailhighlighting.mainTrails)

--#endregion

--#region LOCAL FUNCTIONS
local function getActiveTrailNumber()
    Debug:Print("Getting active trail number")
    for i, trail in pairs(Teh.trailhighlighting.allTrails) do
        if (trail == Teh.trailhighlighting.activeTrail) then
            return i
        end
    end
end

local function loadStorage()
    local mapId = tostring(Mumble.CurrentMap.Id)
    local playerName = Mumble.PlayerCharacter.Name

    -- Check if the mapId and playerName exist in the table
    if Teh.storage.trailHighlightingStates[mapId] and Teh.storage.trailHighlightingStates[mapId][playerName] then
        local guid = Teh.storage.trailHighlightingStates[mapId][playerName]
        Teh.trailhighlighting.activeTrail = World:TrailByGuid(guid)
    else
        Teh.trailhighlighting.activeTrail = Teh.trailhighlighting.firstTrail[1]
    end

    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
end

local function saveStorage()
    local guid = Teh.trailhighlighting.activeTrail.Guid:ToBase64()
    local mapId = tostring(Mumble.CurrentMap.Id)
    local playerName = Mumble.PlayerCharacter.Name

    -- Check if the mapId already exists in the table
    if not Teh.storage.trailHighlightingStates[mapId] then
        Teh.storage.trailHighlightingStates[mapId] = {}  -- Create a new table for this map if it doesn't exist
    end
    
    -- Store the guid for the player under the mapId
    Teh.storage.trailHighlightingStates[mapId][playerName] = guid

    Teh_SaveTable('trailHighlightingStates', Teh.storage.trailHighlightingStates)
end

local function createWarningMarker()
    local playerPos = Mumble.PlayerCharacter.Position
    local attributes = {
        MapVisibility = false,
        MiniMapVisibility = false,
        InGameVisibility = true,
        xpos = playerPos.X,
        ypos = playerPos.Z,
        zpos = playerPos.Y,
        info = "It seems there was an issue highlighting the trail. Recommendation:\n\nClick Pathing Icon -> Scripts -> TehsTrails -> Trail Highlighting -> Highlight Functions -> Reset Trail Highlighting\n\n If problems persist, please report them to im.null on Discord",
        infoRange = 30,
        iconFile = "Data/TehsTrails/Markers/caution.png",
        type = "tt",
        name = "Warning",
        Guid = I:Guid("7EKux8QGH0SnuQ/ztQr/tQ==")
    }
    Teh.trailhighlighting.warningmarker = Pack:CreateMarker(attributes)
end

local function highlightActiveTrail()
    Debug:Print("Highlighting active trail -- begin")
    if (Teh_GetBool('trailHighlighting') == false) then
        Debug:Print("Trail highlighting is disabled, ignoring")
        return
    end

    for _, trail in pairs(Teh.trailhighlighting.mainTrails) do
        trail.InGameVisibility = false
        trail.MapVisibility = false
        trail.MiniMapVisibility = false
    end

    if (Teh_GetBool('trailHighlightingShowOnMapStill') == true) then
        Debug:Print("Show on map still enabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.MapVisibility = true
            trail.MiniMapVisibility = Teh_GetBool('minimapToggled')
        end
    else
        Debug:Print("Show on map still disabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.MapVisibility = false
            trail.MiniMapVisibility = false
        end
    end

    if (Teh_GetBool('trailHighlightingGray') == true) then
        Debug:Print("Gray highlighting enabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Tint = I:Color(80, 80, 80, 255)
            trail.TrailSampleColor = I:Color(80, 80, 80, 255)
        end
    else
        Debug:Print("Gray highlighting disabled")
        Teh_ChangeColor("main", Teh.storage.trailColorTable["main"])
    end

    if (Teh_GetBool('trailHighlightingInvisible') == true) then
        Debug:Print("Invisible highlighting enabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.InGameVisibility = false
        end
    else
        Debug:Print("Invisible highlighting disabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.InGameVisibility = true
        end
    end

    if (Teh_GetBool('trailHighlightingTransparency') == true) then
        Debug:Print("Transparency highlighting enabled")
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Alpha = 0.3
        end
    else
        Debug:Print("Transparency highlighting disabled")
        Teh_ChangeTransparency(Teh.storage.transparency)
    end

    Debug:Print("Highlighting active trail -- setting attributes")
    local activeTrail = Teh.trailhighlighting.activeTrail

    if (activeTrail == nil) then
        Debug:Print("Active trail is nil, returning")
        createWarningMarker()
        return
    end

    Debug:Print("Highlighting active trail -- setting transparency")
    local transparency = Teh.storage.transparency
    for _, value in ipairs(Teh.trailtransparency.transparencies) do
        if (value[1] == transparency) then
            activeTrail.Alpha = value[2]
        end
    end

    Debug:Print("Highlighting active trail -- setting color")
    local color = Teh.storage.trailColorTable["main"]
    local colorTable = Teh.trailcolors.trailtypes["main"]["colors"]
    Debug:Print("Got color table")
    local colorValue = colorTable[1][2]
    Debug:Print("Got default color value, attempting to loop colors")
    for _, value in pairs(Teh.trailcolors.trailtypes["main"]["colors"]) do
        if (value[1] == color) then
            Debug:Print("Found matching color")
            colorValue = value[2]
        end
    end
    activeTrail.Tint = colorValue

    Debug:Print("Highlighting active trail -- setting other attributes")
    activeTrail.Texture = I:Texture(Pack, "Data/TehsTrails/Markers/trailwhite.png")
    activeTrail.TrailSampleColor = colorValue
    activeTrail.InGameVisibility = true
    activeTrail.MapVisibility = true
    activeTrail.MiniMapVisibility = Teh_GetBool('minimapToggled')
    Debug:Print("Highlighting active trail -- done")
    saveStorage()
end

--#endregion

--#region GLOBAL FUNCTIONS

function Teh_TryHighlightActiveTrail()
    highlightActiveTrail()
end

function Teh_HighlightTrailSegment(marker, isAutoTrigger, guid)
    Debug:Print("Highlight trail segment marker with guid " .. marker.Guid .. " triggered")
    if (Teh_GetBool('trailHighlighting') == false) then
        Debug:Print("Trail highlighting is disabled, ignoring")
        return
    end

    for _, m in ipairs(Teh.trailhighlighting.consumed) do
        if (m == marker) then
            Debug:Print("Trail segment marker already consumed, ignoring")
            return
        end
    end

    Debug:Print("Highlighting trail with guid: " .. guid)

    Teh.trailhighlighting.activeTrail = World:TrailByGuid(guid)
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
    highlightActiveTrail()

    table.insert(Teh.trailhighlighting.consumed, marker)
end

function Teh_ChangeHighlightTrailSegment(amount)
    Debug:Print("Changing highlighted trail segment by " .. amount)
    local nextTrailNumber = Teh.trailhighlighting.activeTrailNumber + amount
    if (nextTrailNumber > #Teh.trailhighlighting.allTrails) then
        nextTrailNumber = 1
    elseif (nextTrailNumber < 1) then
        nextTrailNumber = #Teh.trailhighlighting.allTrails
    end

    Teh.trailhighlighting.activeTrail = Teh.trailhighlighting.allTrails[nextTrailNumber]
    Teh.trailhighlighting.activeTrailNumber = nextTrailNumber

    highlightActiveTrail()
end

function Teh_ResetHighlightTrailSegment()
    Debug:Print("Resetting highlighted trail segment")
    Teh.trailhighlighting.activeTrail = Teh.trailhighlighting.firstTrail[1]
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
    Teh.trailhighlighting.consumed = {}
    highlightActiveTrail()
    if Teh.trailhighlighting.warningmarker then
        Teh.trailhighlighting.warningmarker.InGameVisibility = false
        Teh.trailhighlighting.warningmarker:Remove()
    end
end

function Teh_ToggleTrailHighlighting()
    Debug:Print("Toggling trail highlighting")
    if (Teh_GetBool('trailHighlighting') == true) then
        loadStorage()
        highlightActiveTrail()
    else
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.InGameVisibility = false
            trail.MapVisibility = false
            trail.MiniMapVisibility = false
        end

        for _, trail in pairs(Teh.trailhighlighting.mainTrails) do
            trail.InGameVisibility = true
            trail.MapVisibility = true
            trail.MiniMapVisibility = Teh_GetBool('minimapToggled')
        end

        saveStorage()
    end
end

function Teh_ResetAllMapTrailsForCharacter()
    Debug:Print("Resetting all map trails for character")
    local playerName = Mumble.PlayerCharacter.Name

    for _, map in pairs(Teh.storage.trailHighlightingStates) do
        if (map[playerName]) then
            map[playerName] = nil
        end
    end

    Teh.trailhighlighting.activeTrail = Teh.trailhighlighting.firstTrail[1]
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
    highlightActiveTrail()
    if Teh.trailhighlighting.warningmarker then
        Teh.trailhighlighting.warningmarker.InGameVisibility = false
        Teh.trailhighlighting.warningmarker:Remove()
    end
end

--#endregion

--#region FINAL INIT

if (Teh_GetBool('trailHighlighting') == true) then
    loadStorage()
    highlightActiveTrail()
end

--#endregion