Teh.reset = {
    categoryShown = false,
    resetMarker = nil,
    category = nil,
}

Debug:Watch("reset", Teh.reset)

-- Preload the category
Teh.reset.category = World:CategoryByType("tt.sr")


-- Checks if scripts are running and returns true if any are
local function Teh_Check_Active_Scripts()
    -- If ANY of the below scripts are running, return true
    if (Teh.bounce.isBouncing) then return true end
    if (Teh.heartfollower.isFollowing) then return true end
    if (Teh.highlight.waypointHighlighted) then return true end

    return false
end

-- Shows the script reset category
local function Teh_Show_Reset_Category()
    Teh.reset.category:Show()
    Teh.reset.category.DefaultToggle = 1

    local attributes = {
        type = "tt.sr",
        xpos = 0,
        ypos = 0,
        zpos = 0
    }

    Teh.reset.resetMarker = Pack:CreateMarker(attributes)
    Teh.reset.categoryShown = true
end

-- Hides the script reset category
local function Teh_Hide_Reset_Category()
    if (Teh.reset.categoryShown == true) then
        Teh.reset.resetMarker:Remove()
        Teh.reset.category:Hide()
        Teh.reset.categoryShown = false
        Teh.reset.category.DefaultToggle = 0
    end
end

-- Handles the "reset" button category, that resets all active scripts when toggled
function Teh_Reset_Handler()
    -- If there are scripts active
    if (Teh_Check_Active_Scripts()) then
        -- If the category hasn't been shown, show it
        if (Teh.reset.categoryShown == false) then Teh_Show_Reset_Category() end
        -- If the category has been shown, and it's now not visible, that means the user has toggled it, so reset everything
        if (Teh.reset.categoryShown == true and (Teh.reset.category:IsVisible() == false)) then
            if (Teh.bounce.isBouncing) then Teh_Bounce_Reset() end
            if (Teh.heartfollower.isFollowing) then Teh_Follower_Reset() end
            if (Teh.highlight.waypointHighlighted) then Teh_Highlight_Reset() end

            Teh_Hide_Reset_Category()
        end
    end
end