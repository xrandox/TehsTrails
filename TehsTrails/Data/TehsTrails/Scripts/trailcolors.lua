Teh.trailcolors = {
    trailtypes = {
        ["main"] = {
            ["menuName"] = "Main Trail Color",
            ["menuDescription"] = "Change the color of all main trails",
            ["categoryTypes"] = {"tt.mc.ct", "tt.hot.ct", "tt.eod.ct", "tt.eodl.ct", "tt.soto.ct", "tt.sotol.ct"},
            ["texturePath"] = "Data/TehsTrails/Markers/trailwhite.png",
            ["defaultPath"] = "Data/TehsTrails/Markers/trailwhite.png",
            ["trails"] = {},
            ["colors"] = {
                {"Light Blue [Default]", I:Color(74, 213, 255), nil},
                {"Dark Blue", I:Color(19, 30, 182), nil},
                {"Dark Purple", I:Color(114, 31, 103), nil},
                {"Light Green", I:Color(161, 255, 74), nil},
                {"Grey", I:Color(90, 89, 88), nil},
                {"Light Grey", I:Color(178, 171, 167), nil},
                {"Orange", I:Color(252, 128, 47), nil},
                {"Pink", I:Color(254, 82, 207), nil},
                {"Red", I:Color(206, 49, 49), nil},
                {"White", I:Color(255, 255, 255), nil},
                {"Yellow", I:Color(255, 232, 0), nil},
                {"Pastel Blue", I:Color(189, 224, 254), nil},
                {"Pastel Green", I:Color(208, 244, 222), nil},
                {"Pastel Purple", I:Color(205, 180, 219), nil},
                {"Pastel Pink", I:Color(255, 200, 221), nil},
                {"Pastel Yellow", I:Color(252, 246, 189), nil}
            }
        },
        ["hp"] = {
            ["menuName"] = "Hero Point Trail Color",
            ["menuDescription"] = "Change the color of all hero point trails",
            ["categoryTypes"] = {"tt.mc.hp.hpt", "tt.hot.hp.hpt"},
            ["texturePath"] = "Data/TehsTrails/Markers/hp-white.png",
            ["defaultPath"] = "Data/TehsTrails/Markers/hp-white.png",
            ["trails"] = {},
            ["colors"] = {
                {"Yellow [Default]", I:Color(255, 232, 0), nil},
                {"Light Blue", I:Color(74, 213, 255), nil},
                {"Dark Blue", I:Color(19, 30, 182), nil},
                {"Dark Purple", I:Color(114, 31, 103), nil},
                {"Light Green", I:Color(161, 255, 74), nil},
                {"Grey", I:Color(90, 89, 88), nil},
                {"Light Grey", I:Color(178, 171, 167), nil},
                {"Orange", I:Color(252, 128, 47), nil},
                {"Pink", I:Color(254, 82, 207), nil},
                {"Red", I:Color(206, 49, 49), nil},
                {"White", I:Color(255, 255, 255), nil},
                {"Pastel Blue", I:Color(189, 224, 254), nil},
                {"Pastel Green", I:Color(208, 244, 222), nil},
                {"Pastel Purple", I:Color(205, 180, 219), nil},
                {"Pastel Pink", I:Color(255, 200, 221), nil},
                {"Pastel Yellow", I:Color(252, 246, 189), nil}
            }
        },
        ["heart"] = {
            ["menuName"] = "Heart Trail Color",
            ["menuDescription"] = "Change the color of all heart trails",
            ["categoryTypes"] = {"tt.mc.h.ht"},
            ["texturePath"] = "Data/TehsTrails/Markers/HeartTrail-white.png",
            ["defaultPath"] = "Data/TehsTrails/Markers/HeartTrail.png",
            ["trails"] = {},
            ["colors"] = {
                {"Yellow and Black [Default]", nil, nil},
                {"Light Blue", I:Color(74, 213, 255), nil},
                {"Dark Blue", I:Color(19, 30, 182), nil},
                {"Dark Purple", I:Color(114, 31, 103), nil},
                {"Light Green", I:Color(161, 255, 74), nil},
                {"Grey", I:Color(90, 89, 88), nil},
                {"Light Grey", I:Color(178, 171, 167), nil},
                {"Orange", I:Color(252, 128, 47), nil},
                {"Pink", I:Color(254, 82, 207), nil},
                {"Red", I:Color(206, 49, 49), nil},
                {"White", I:Color(255, 255, 255), nil},
                {"Pastel Blue", I:Color(189, 224, 254), nil},
                {"Pastel Green", I:Color(208, 244, 222), nil},
                {"Pastel Purple", I:Color(205, 180, 219), nil},
                {"Pastel Pink", I:Color(255, 200, 221), nil},
                {"Pastel Yellow", I:Color(252, 246, 189), nil},
            }
        },
        ["tos"] = {
            ["menuName"] = "Trail of Shame Color",
            ["menuDescription"] = "Change the color of all trails of shame",
            ["categoryTypes"] = {"tt.mc.tos", "tt.soto.tos"},
            ["texturePath"] = "Data/TehsTrails/Markers/TrailOfShame-white.png",
            ["defaultPath"] = "Data/TehsTrails/Markers/TrailOfShame.png",
            ["trails"] = {},
            ["colors"] = {
                {"Red [Default]", nil, nil},
                {"Light Blue", I:Color(74, 213, 255), nil},
                {"Dark Blue", I:Color(19, 30, 182), nil},
                {"Dark Purple", I:Color(114, 31, 103), nil},
                {"Light Green", I:Color(161, 255, 74), nil},
                {"Grey", I:Color(90, 89, 88), nil},
                {"Light Grey", I:Color(178, 171, 167), nil},
                {"Orange", I:Color(252, 128, 47), nil},
                {"Pink", I:Color(254, 82, 207), nil},
                {"Red", I:Color(206, 49, 49), nil},
                {"Yellow", I:Color(255, 232, 0), nil},
                {"White", I:Color(255, 255, 255), nil},
                {"Pastel Blue", I:Color(189, 224, 254), nil},
                {"Pastel Green", I:Color(208, 244, 222), nil},
                {"Pastel Purple", I:Color(205, 180, 219), nil},
                {"Pastel Pink", I:Color(255, 200, 221), nil},
                {"Pastel Yellow", I:Color(252, 246, 189), nil},
            }
        }
    }
}

Debug:Watch("Teh_TrailColors", Teh.trailcolors)
for trailType, typeTable in pairs(Teh.trailcolors.trailtypes) do
    Debug:Print("Checking for trails of type " .. typeTable["menuName"])
    for _, categoryType in ipairs(typeTable["categoryTypes"]) do
        Debug:Print("Checking category " .. categoryType)
        local category = World:CategoryByType(categoryType)
        if (category ~= nil) then
            Debug:Print("Found category " .. categoryType)
            local trails = category:GetTrails()
            if (trails ~= nil) then
                for _, trail in ipairs(trails) do
                    Debug:Print("Found trail " .. trail.Guid)
                    table.insert(Teh.trailcolors.trailtypes[trailType]["trails"], trail)
                end
            end
        end
    end
end

-- Change the color of the main trail to the requested color name
function Teh_ChangeColor(trailType, colorName)
    Debug:Print("Attempting to change color of " .. trailType .. " to " .. colorName)
    local typeTable = Teh.trailcolors.trailtypes[trailType]

    if (typeTable["trails"] == nil) then
        Debug:Warn("No trail references found, cannot change color")
        return
    end

    local texturePath = typeTable["texturePath"]

    for i, colorTable in ipairs(typeTable["colors"]) do
        if (colorTable[1] == colorName) then
            Debug:Print("Found matching color " .. colorName)
            for _, trail in ipairs(typeTable["trails"]) do
                Debug:Print("Changing trail color to " .. colorName)
                if (i == 1) then
                    texturePath = typeTable["defaultPath"]
                end
                if (colorTable[2] ~= nil) then
                    trail.Tint = colorTable[2]
                end
                trail.Texture = I:Texture(Pack, texturePath)
                trail.TrailSampleColor = colorTable[2]
            end
            local savedColors = Teh.storage.trailColors
            savedColors[trailType] = colorName
            Teh_SaveValue("trailColor", savedColors)
            return
        end
    end
end

Teh_ChangeColor("main", Teh.storage.trailColors["main"])
Teh_ChangeColor("hp", Teh.storage.trailColors["hp"])
Teh_ChangeColor("heart", Teh.storage.trailColors["heart"])
Teh_ChangeColor("tos", Teh.storage.trailColors["tos"])