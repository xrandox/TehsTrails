Teh.versioncheck = {
    version = PathingVersion,
    isGoodVersion = false
}

Debug:Watch("Version Check", Teh.versioncheck)

-- Minimum version numbers required
local minMajor = 1
local minMinor = 2
local minPatch = 1

-- Splits the module version into major minor and patch for comparison
local function splitVersion(version)
    local major, minor, patch = version:match("(%d+)%.(%d+)%.(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

-- Creates an alert marker to tell the user to update their pathing module
local function createAlert(version)
    local pos = Mumble.PlayerCharacter.Position
    local alert = Pack:CreateMarker({
        info = "I've detected that you are currently running TehsTrails on Pathing version " .. version .. ". TehsTrails requires at least version 1.2.1 to run correctly. Please update your Pathing module.",
        TriggerRange = 10000,
        AutoTrigger = true
    })
    alert:SetTexture("Data/TehsTrails/Markers/caution.png")
    alert:SetPos(pos)
end

-- Checks if the current version is high enough to run the pack
function Teh_VersionCheck()
    if (PathingVersion == nil) then
        createAlert("<1.2.1")
        return false
    end

    local currentMajor, currentMinor, currentPatch = splitVersion(PathingVersion)

    if (currentMajor < minMajor) or
    (currentMinor < minMinor and currentMajor == minMajor) or
    (currentPatch < minPatch and currentMinor == minMinor and currentMajor == minMajor)
    then
        createAlert(PathingVersion)
        return false
    else
        Teh.versioncheck.isGoodVersion = true
        return true
    end
end
