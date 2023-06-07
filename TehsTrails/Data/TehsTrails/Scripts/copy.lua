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
    }
}

Debug:Watch("copy", Teh.copy)

-- Preload the visibility values to our internal table
local c = Teh.copy.categoriesToWatch

Teh.copy.visibility["tt"] = c["tt"]:IsVisible()
Teh.copy.visibility["overflow"] = c["overflow"]:IsVisible()
Teh.copy.visibility["bhud"] = c["bhud"]:IsVisible()
Teh.copy.visibility["ign"] = c["ign"]:IsVisible()
Teh.copy.visibility["kofi"] = c["kofi"]:IsVisible()


-- Copies the display name of the given category to the clipboard
function Teh_Copy(category)
    User.SetClipboard(category.DisplayName)
end

-- Handles listening for visibility changes in the watched categories
function Teh_CopyTickHandler()
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