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

-- Load Values on startup
for key, value in pairs(Teh.storage) do
    local storedValue = Storage:ReadValue("tehstrails", key)
    if (storedValue ~= nil) then
        Teh.storage[key] = storedValue
    end
end

-- Check if the given key exists in the storage table
local function storageKeyExists(key)
    for k, _ in pairs(Teh.storage) do
        if (k == key) then
            return true
        end
    end
    return false
end

-- Saves the given value for the given key in the storage, as long as the key is valid
function saveValue(key, value)
    if (storageKeyExists(key)) then
        Storage:UpsertValue("tehstrails", key, tostring(value))
        Teh.storage[key] = value
    end
end

-- Returns the boolean value of the stored string
function Teh_Is_True(key)
    for k, value in pairs(Teh.storage) do
        if (k == key) then
            if (value == "true") then
                return true
            else return false end
        end
    end
end

-- Toggles the boolean value of the given setting
function Teh_Toggle_Storage(key)
    for k, value in pairs(Teh.storage) do
        if (k == key) then
            if (value == "true") then
                saveValue(key, "false")
                return
            else
                saveValue(key, "true")
                return
            end
        end
    end
end