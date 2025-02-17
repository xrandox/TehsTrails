local function showInformation()
    Debug:Info("Showing information")
    local pos = Mumble.PlayerCharacter.Position
    local markerOptions = {
        info = "Hey there, trailblazer!\n\nWelcome to TehsTrails V6!\n\nThis version brings various new scripting features and improvements. I highly recommend clicking on the pathing icon and poking around the Scripts -> Teh's Trails menu to customize things to your liking.\n\nIf you ever run into any issues, feel free to join the Teh's Trails discord, you can find the link in the Copy Links script menu.\n\nHappy Trails!",
        iconSize = 2,
        Alpha =  0.85,
        xpos = pos.X,
        ypos = pos.Z,
        zpos = pos.Y,
    }
    local marker = Pack:CreateMarker(markerOptions)
    marker:SetTexture("Data/TehsTrails/Markers/Teh.png")
end

local function tryShowInfo(gameTime)
    if (Teh_GetBool("versionSixFirstLaunch") == false) then return end
    if (Teh.tutorial.shown == false) then
        showInformation()
        Teh_ToggleStorage("versionSixFirstLaunch")
    end
end

if (Teh_GetBool("versionSixFirstLaunch") == true) then
    Event:OnTick(tryShowInfo)
end
