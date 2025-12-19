Teh.trailtransparency = {
    transparencies = {
        -- Percent, value, Menu Reference
        {"100%", 1.0, nil},
        {"80%", 0.8, nil},
        {"60%", 0.6, nil},
        {"40%", 0.4, nil},
        {"20%", 0.2, nil}
    }
}

Debug:Watch("Teh_TrailTransparency", Teh.trailtransparency)
local trailCategory = World:CategoryByType("tt")
local categoryTrails = trailCategory:GetTrails(true)

function Teh_ChangeTransparency(percent)
    if (categoryTrails == nil) then
        Debug:Error("Failed to change trail transparency: Could not get reference to trails")
        return
    end

    for _, value in ipairs(Teh.trailtransparency.transparencies) do
        if (value[1] == percent) then
            for _, trail in ipairs(categoryTrails) do
                Debug:Print("Changing trail transparency to " .. percent)
                trail.Alpha = value[2]
            end
            Teh_SaveValue("transparency", percent)
        end
    end
end

Teh_ChangeTransparency(Teh.storage.transparency)