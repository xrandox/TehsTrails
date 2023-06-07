Teh.static = {
    -- List of the map ID's we have markers on in, split by area
    maps = {
        core = { 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 34, 35, 39, 50, 51, 53, 54, 62, 65, 73, 91, 139, 218, 326 },
        eod = { 1422, 1428, 1438, 1442, 1452 },
        hot = { 1043, 1045, 1052 },
        pof = { 1210, 1211, 1226, 1228 },
        all = { 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 34, 35, 39, 50, 51, 53, 54, 62, 65, 73, 91, 139, 218, 326, 1043, 1045, 1052, 1210, 1211, 1226, 1228, 1422, 1428, 1438, 1442, 1452 }
    },
    -- Category types we want shown always, according to which areas they should be shown in
    categories = {
        all = {
            "tt.credits.null.ign",
            "tt.credits.zotmer.discord",
            "tt.credits.snow.snow2",
            "tt.credits.foxe.foxe3",
            "tt.credits.odeh.odeh1",
            "tt.credits.radd.radd0",
            "tt.credits.orig.orig2",
            "tt.credits.maptesters.contributor",
            "tt.credits.assets.assets0",
            "tt.credits.tt.link",
            "tt.credits.overflow.link",
            "tt.credits.bhud.link",
            "tt.credits.mail.m.ign",
            "tt.credits.kofi.k.link",
            "tt.credits.a",
            "tt.credits.f",
            "tt.credits.k"
        },
        core = {

        },
        eod = {

        },
        hot = {

        },
        pof = {

        }
    }
}

Debug:Watch("static", Teh.static)

local mapID = Mumble.CurrentMap.Id

-- Returns true if a map ID is in the table of ID's
local function mapIsIn(table, val)
    for _, v in ipairs(table) do
        if (v == val) then
            return true
        end
    end

    return false
end

-- Creates invisable markers with the categories from a given table
local function markerFromTable (table)
    -- Attributes to use for all the markers
    local attributes = {
        MapVisibility = false,
        MiniMapVisibility = false,
        InGameVisibility = false,
        xpos = 0,
        ypos = 0,
        zpos = 0,
        type = nil
    }

    -- For each category, create a marker with that type
    for _, category in ipairs(table) do
        attributes.type = category
        Pack:CreateMarker(attributes)
    end
end

-- Create markers from the respective categories if the current mapID is in the table

local maps = Teh.static.maps
local categories = Teh.static.categories

-- Core maps
if (mapIsIn(maps.core, mapID)) then
    markerFromTable(categories.core)
    markerFromTable(categories.all)

-- EoD maps
elseif (mapIsIn(maps.eod, mapID)) then
    markerFromTable(categories.eod)
    markerFromTable(categories.all)

-- HoT maps
elseif (mapIsIn(maps.hot, mapID)) then
    markerFromTable(categories.hot)
    markerFromTable(categories.all)

-- PoF maps
elseif (mapIsIn(maps.pof, mapID)) then
    markerFromTable(categories.pof)
    markerFromTable(categories.all)
end
