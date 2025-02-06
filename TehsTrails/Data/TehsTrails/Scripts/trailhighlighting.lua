Teh.trailhighlighting = {
    trailCategories = { "tt.eod.mt.th", "tt.hot.mt.th", "tt.mc.mt.th", "tt.soto.mt.th", "tt.eodl.mt.th", "tt.sotol.mt.th" },
    firstTrailCategories = { "tt.eod.mt.th.t1", "tt.hot.mt.th.t1", "tt.mc.mt.th.t1", "tt.soto.mt.th.t1", "tt.eodl.mt.th.t1", "tt.sotol.mt.th.t1" },
    mainTrailCategories = { "tt.eod.mt.nt", "tt.hot.mt.nt", "tt.mc.mt.nt", "tt.soto.mt.nt", "tt.eodl.mt.nt", "tt.sotol.mt.nt" },
    allTrails = {},
    firstTrail = {},
    activeTrail = nil,
    activeTrailNumber = 1,
    mainTrails = {}
}

Debug:Watch('Teh_TrailHighlighting', Teh.trailhighlighting)

--#region PRELOAD
local function preload(categoryTypes, luaTable)
    Debug:Print("Preloading trails for highlighting")
    for _, categoryType in ipairs(categoryTypes) do
        Debug:Print("Preloading trails for category: " .. categoryType)
        local category = World:CategoryByType(categoryType)
        if (category ~= nil) then
            Debug:Print("Category found: " .. category.Name)
            local trails = category:GetTrails(true)
            if (trails ~= nil) then
                Debug:Print("Trails found: " .. #trails)
                for _, trail in pairs(trails) do
                    Debug:Print("Trail found: " .. trail.Guid)
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
        Teh_ChangeColor("main", Teh.storage.trailColors["main"])
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

    Debug:Print("Highlighting active trail -- setting transparency")
    local transparency = Teh.storage.transparency
    for _, value in ipairs(Teh.trailtransparency.transparencies) do
        if (value[1] == transparency) then
            activeTrail.Alpha = value[2]
        end
    end

    Debug:Print("Highlighting active trail -- setting color")
    local color = Teh.storage.trailColors["main"]
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
    Debug:Print("Highlighting trail with guid: " .. guid)

    Teh.trailhighlighting.activeTrail = World:TrailByGuid(guid)
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
    highlightActiveTrail()
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

    highlightActiveTrail()
end

function Teh_ToggleTrailHighlighting()
    Debug:Print("Toggling trail highlighting")
    if (Teh_GetBool('trailHighlighting') == true) then
        Teh_ResetHighlightTrailSegment()
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
    end
end

--#endregion

--#region FINAL INIT

if (Teh_GetBool('trailHighlighting') == true) then
    Teh_ResetHighlightTrailSegment()
end

--#endregion