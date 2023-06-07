Teh.storage = {
    --These are the default values
    minimapToggled = "false",
    heartZonesOnMap = "false",
    heartZonesOnMinimap = "false",
    globalMarkersToggled = "false",
    followerInfoToggled = "true",
    followerVisibleToggled = "true",
    bounceToggled = "true",
    highlightToggled = "true",
    hasSkyscale = "false",
    trailColor = "Light Blue [Default]"
}

Debug:Watch("Storage", Teh.storage)

-- Load defaults on startup
for key, _ in pairs(Teh.storage) do
    local storedValue = Storage:ReadValue("tehstrails", key)
    if (storedValue ~= nil) then
        Teh.storage[key] = storedValue
    end
end

-- Saves the the value into storage
function Teh_SaveValue(key, value)
    Storage:UpsertValue("tehstrails", key, tostring(value))
    Teh.storage[key] = value
end

-- Returns the boolean value of the stored keys string value
function Teh_GetBool(key)
    if (Teh.storage[key] == "true") then return true
    else return false end
end

-- Toggles the boolean value of the given setting
function Teh_ToggleStorage(key)
    if (Teh_GetBool(key)) then
        Teh_SaveValue(key, "false")
    else
        Teh_SaveValue(key, "true")
    end
end