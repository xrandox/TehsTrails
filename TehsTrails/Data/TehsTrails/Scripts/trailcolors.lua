Teh.trailcolors = {
    colors = {
        -- Name, Color, Menu Reference
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

Debug:Watch("Teh_TrailColors", Teh.trailcolors)
local mainTrails = World:PathablesByGuid("cb6VPxgSL0yytSwws/y+Vg==")

-- Change the color of the main trail to the requested color name
function Teh_ChangeColor(name)
    if (mainTrails == nil) then
        Debug:Error("Failed to change trail color: Could not get reference to main trail")
        return
    end

    for _, value in ipairs(Teh.trailcolors.colors) do
        if (value[1] == name) then
            for _, trail in ipairs(mainTrails) do
                Debug:Print("Changing trail color to " .. name)
                trail.Tint = value[2]
                trail.Texture = I:Texture(Pack, "Data/TehsTrails/Markers/trailwhite.png")
                trail.TrailSampleColor = value[2]
                trail.InGameVisibility = true
            end
            Teh_SaveValue("trailColor", name)
        end
    end
end

Teh_ChangeColor(Teh.storage.trailColor)