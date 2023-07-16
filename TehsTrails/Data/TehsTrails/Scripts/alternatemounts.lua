-- Constants
local MOUNT_IDS = {
    ["beetle"] = 2213302,
    ["jackal"] = 2179789,
    ["raptor"] = 2179792,
    ["skimmer"] = 2179791,
    ["skyscale"] = 2141699,
    ["springer"] = 2179790,
}

local PARENT_CATEGORY = "tt.mc.cm.mm."
local PARENT_PATH = "Data/TehsTrails/Markers/"
local PATH_END = ".png"

Teh.alternatemounts = {
    isSwitched = false
}

Debug:Watch("Teh_AlternateMounts", Teh.alternatemounts)

-- Function to actually change the mount icons
local function switchMounts()
    for mountName, id in pairs(MOUNT_IDS) do
        local mountCategory = World:CategoryByType(PARENT_CATEGORY .. mountName)
        local mountMarkers = mountCategory:GetMarkers()
        if (mountMarkers ~= nil) then
            for _, marker in pairs(mountMarkers) do
                if (Teh.alternatemounts.isSwitched) then
                    marker:SetTexture(id)
                else
                    marker:SetTexture(PARENT_PATH .. mountName .. PATH_END)
                end
            end
        end
    end
end

-- Global function to switch which mount art is used
function Teh_AlternateMounts()
    Teh_ToggleStorage("alternateMounts")
    Teh.alternatemounts.isSwitched = Teh_GetBool("alternateMounts")
    switchMounts()
end

-- Load initial value from storage
Teh.alternatemounts.isSwitched = Teh_GetBool("alternateMounts")

-- If it's switched, switch them
if (Teh.alternatemounts.isSwitched) then
    switchMounts()
end