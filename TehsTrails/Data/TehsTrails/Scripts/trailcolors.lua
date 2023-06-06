Teh.trailcolors = {
    colors = {
        -- name, texturePath
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
        {"Pastel Yellow", I:Color(252, 246, 189), nil},
    }
}

Debug:Watch("Trail Colors", Teh.trailcolors)

local mainTrail = World:TrailByGuid("cb6VPxgSL0yytSwws/y+Vg==")

-- Preload trail texture as a marker so we can reference it, this paired with a transparent default texture in the XML allows us to avoid "loading" the right color on map change
local marker = Pack:CreateMarker()
marker:SetPos(0,-10000,0)
marker:SetTexture("Data/TehsTrails/Markers/trailwhite.png")
marker.InGameVisibility = false
marker.MiniMapVisibility = false
marker.MapVisibility = false

function Teh_ChangeColor(name)
    for index, value in ipairs(Teh.trailcolors.colors) do
        if (value[1] == name) then
            mainTrail.Tint = value[2]
            mainTrail.Texture = marker.Texture
            mainTrail.InGameVisibility = true
            saveValue("trailColor", name)
        end
    end
end