Teh.menu ={
    colors = {
        -- name, texturePath, menu reference
        {"Red", "Data/TehsTrails/Markers/RedTrail.png", nil},
        {"Grey", "Data/TehsTrails/Markers/GreyTrail.png", nil},
        {"Light Grey", "Data/TehsTrails/Markers/LightGreyTrail.png", nil},
        {"Orange", "Data/TehsTrails/Markers/OrangeTrail.png", nil},
        {"Pink", "Data/TehsTrails/Markers/PinkTrail.png", nil},
        {"Dark Purple", "Data/TehsTrails/Markers/DarkPurpleTrail.png", nil},
        {"Dark Blue", "Data/TehsTrails/Markers/DarkBlueTrail.png", nil},
        {"Green", "Data/TehsTrails/Markers/GreenTrail.png", nil},
        {"Blue", "Data/TehsTrails/Markers/Trail.png", nil}
    }
}

Debug:Watch("Menu", Teh.menu)

local function nothing() end

local function changeColor(name, texturePath)
    -- Uncheck all other colors
    for index, value in ipairs(Teh.menu.colors) do
        if (value[1] ~= name) then
            value[3].Checked = false
        end
    end

    -- Change the actual trail color
    local allTrails = World:CategoryByType("tt.mc.ct.mapB"):GetMarkers()
    for key, value in pairs(allTrails) do
        value:SetTexture(texturePath)
    end
    saveValue("trailColor", name)
end

function Teh_Create_Menu()
    local mainMenu = Menu:Add("Tehs Trails", nothing())

    -- Color menu
    local currentColor = "Blue"

    local colorMenu = mainMenu:Add("Select Trail Color", nothing())

    for i, value in ipairs(Teh.trailcolors.colors) do

        local checked = false
        local name = value[1]
        local texturePath = value[2]

        if (currentColor == name) then
            checked = true
        end

        -- Add in color switch function here
        Teh.menu.colors[i][3] = colorMenu:Add(name, changeColor(name, texturePath), true, checked)
    end

    -- Heart follower menu
    local heartFollower = mainMenu:Add("Enable Heart Info Followers", nothing(), true)
    heartFollower:Add("Enable Visible Heart Pointer", nothing(), true)

    -- Other script toggles
    mainMenu:Add("Enable Waypoint Highlights", nothing(), true)
    mainMenu:Add("Enable Bouncing Route Markers", nothing(), true)
    mainMenu:Add("Toggle Trails on Minimap", nothing(), true)

    -- Script reset
    mainMenu:Add("  [  RESET ALL SCRIPTS  ]  ", nothing())
end

Teh_Create_Menu()