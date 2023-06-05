Teh.storage = {
    --These are the default values
    minimapToggled = "false",
    globalMarkersToggled = "false",
    followersToggled = "true",
    bounceToggled = "true",
    highlightToggled = "true",
    hasSkyscale = "false",
    trailColor = "Blue"
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