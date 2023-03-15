Teh.copy = {
    categoriesToWatch = {
        ["tt"] = World:CategoryByType("tt.credits.tt.link"),
        ["overflow"] = World:CategoryByType("tt.credits.overflow.link"),
        ["bhud"] = World:CategoryByType("tt.credits.bhud.link"),
        ["ign"] = World:CategoryByType("tt.credits.mail.m.ign"),
        ["kofi"] = World:CategoryByType("tt.credits.kofi.k.link"),
    },
    visibility = {
        ["tt"] = nil,
        ["overflow"] = nil,
        ["bhud"] = nil,
        ["ign"] = nil,
        ["kofi"] = nil
    },
    preloaded = false
}

Debug:Watch("copy", Teh.copy)

-- Preloads the visibility values to our internal table
function Teh_Preload_Copy()
    local c = Teh.copy.categoriesToWatch

    for key, value in pairs(Teh.copy.visibility) do
        Teh.copy.visibility[key] = Teh.copy.categoriesToWatch[key]:IsVisible()
    end

    Teh.copy.preloaded = true
end

-- Copies the display name of the given category to the clipboard
function Teh_Copy(category)
    User.SetClipboard(category.DisplayName)
end

-- Handles listening for visibility changes in the watched categories
function Teh_Copy_Tick_Handler()
    -- For each watched category
    for key, value in pairs(Teh.copy.categoriesToWatch) do
        -- Get the current visibility
        local currentVis = value:IsVisible()
        -- If that doesn't match our saved visibility, then copy to clipboard and update the saved visibility
        if (currentVis ~= Teh.copy.visibility[key]) then
            Teh_Copy(value)
            Teh.copy.visibility[key] = currentVis
        end
    end
end