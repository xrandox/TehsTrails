Teh.menu ={

}

local function nothing()

end

function Teh_Create_Menu()

    local menu = Menu:Add("TehsTrails", nothing(), false, false)

    menu:Add("  [  CLEAR ALL SCRIPTS  ]  ", Teh_Reset_Scripts(), false, false)
end