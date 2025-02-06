Teh.trailhighlighting = {
    trailCategories = { "tt.eod.mt.th", "tt.hot.mt.th", "tt.mc.mt.th", "tt.soto.mt.th", "tt.eodl.mt.th", "tt.sotol.mt.th" },
    firstTrailCategories = { "tt.eod.mt.th.t1", "tt.hot.mt.th.t1", "tt.mc.mt.th.t1", "tt.soto.mt.th.t1", "tt.eodl.mt.th.t1", "tt.sotol.mt.th.t1" },
    mainTrailCategories = { "tt.eod.mt.nt", "tt.hot.mt.nt", "tt.mc.mt.nt", "tt.soto.mt.nt", "tt.eodl.mt.nt", "tt.sotol.mt.nt" },
    allTrails = {},
    firstTrail = {},
    activeTrail = nil,
    activeTrailNumber = nil,
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
    for i, trail in pairs(Teh.trailhighlighting.allTrails) do
        if (trail == Teh.trailhighlighting.activeTrail) then
            return i
        end
    end
end

local function highlightActiveTrail()
    if (Teh_GetBool('trailHighlighting') == false) then
        return
    end

    for _, trail in pairs(Teh.trailhighlighting.mainTrails) do
        trail.InGameVisibility = false
        trail.MapVisibility = false
        trail.MiniMapVisibility = false
    end

    Teh_TrailHighlightGray()

    Teh_TrailHighightInvisible()

    Teh_TrailHighlightTransparency()

    local activeTrail = Teh.trailhighlighting.activeTrail
    activeTrail.Alpha = 1
    local color = Teh.storage.trailColor
    local colorValue = Teh.trailcolors.colors[1][2]
    for _, value in ipairs(Teh.trailcolors.colors) do
        if (value[1] == color) then
            colorValue = value[2]
        end
    end
    activeTrail.Tint = colorValue
    activeTrail.Texture = I:Texture(Pack, "Data/TehsTrails/Markers/trailwhite.png")
    activeTrail.TrailSampleColor = colorValue
    activeTrail.InGameVisibility = true
    activeTrail.MapVisibility = true
    activeTrail.MiniMapVisibility = Teh_GetBool('minimapToggled')
end

--#endregion

--#region GLOBAL FUNCTIONS

function Teh_TrailHighlightGray()
    if (Teh_GetBool('trailHighlighting') == false) then
        return
    end

    if (Teh_GetBool('trailHighlightingGray') == true) then
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Tint = I:Color(0.5, 0.5, 0.5, 1)
        end
    else
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Tint = I:Color(1, 1, 1, 1)
        end
    end
end

function Teh_TrailHighightInvisible()
    if (Teh_GetBool('trailHighlighting') == false) then
        return
    end

    if (Teh_GetBool('trailHighlightingInvisible') == true) then
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.InGameVisibility = false
            trail.MapVisibility = false
            trail.MiniMapVisibility = false
        end
    else
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.InGameVisibility = true
            trail.MapVisibility = true
            trail.MiniMapVisibility = Teh_GetBool('minimapToggled')
        end
    end
end

function Teh_TrailHighlightTransparency()
    if (Teh_GetBool('trailHighlighting') == false) then
        return
    end

    if (Teh_GetBool('trailHighlightingTransparency') == true) then
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Alpha = 0.25
        end
    else
        for _, trail in pairs(Teh.trailhighlighting.allTrails) do
            trail.Alpha = 1
        end
    end
end

function Teh_HightlightTrailSegment(marker, isAutoTrigger, guid)
    if (Teh_GetBool('trailHighlighting') == false) then
        return
    end

    Teh.trailhighlighting.activeTrail = World:TrailByGuid(guid)
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()
    highlightActiveTrail()
end



function Teh_ChangeHighlightTrailSegment(amount)
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
    Teh.trailhighlighting.activeTrail = Teh.trailhighlighting.firstTrail[1]
    Teh.trailhighlighting.activeTrailNumber = getActiveTrailNumber()

    highlightActiveTrail()
end

function Teh_ToggleTrailHighlighting()
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