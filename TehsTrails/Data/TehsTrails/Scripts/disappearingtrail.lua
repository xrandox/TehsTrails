Teh.disappearingtrails = {
    trailGuids = {
        "c16VPxgSL0yytSwws/y+Vg==",
        "c26VPxgSL0yytSwws/y+Vg==",
        "c36VPxgSL0yytSwws/y+Vg==",
        "c46VPxgSL0yytSwws/y+Vg==",
        "a16VPxgSL0yytSwws/y+Vg==",
        "a26VPxgSL0yytSwws/y+Vg==",
        "a36VPxgSL0yytSwws/y+Vg==",
        "a46VPxgSL0yytSwws/y+Vg=="
    },
    colors = {}
}

Debug:Watch("Teh_DisappearingTrails", Teh.disappearingtrails)

function Teh_DisappearingTrailTrigger(marker, isfocused, guid)
    if (isfocused == true) then
        local trail = World:TrailByGuid(guid)
        if (trail ~= nil) then
            trail:Remove()
            Debug:Warn("Removed trail with guid " .. guid)
        else
            Debug:Warn("Could not find trail to make disappear")
        end
    end
end

function Teh_ColorizeDisappearingTrails()
    local colorIndex = 13;
    for i, guid in ipairs(Teh.disappearingtrails.trailGuids) do
        local trail = World:TrailByGuid(guid)
        local mainColor = Teh.storage.trailColor
        if (trail ~= nil) then
            local thisColor = Teh.trailcolors.colors[colorIndex]

            if (thisColor[1] == mainColor) then
                colorIndex = colorIndex + 1
                if colorIndex > 16 then
                    colorIndex = 1
                end
                thisColor = Teh.trailcolors.colors[colorIndex]
            end

            trail.Tint = thisColor[2]
            trail.Texture = I:Texture(Pack, "Data/TehsTrails/Markers/trailwhite.png")
            trail.TrailSampleColor = thisColor[2]
            trail.InGameVisibility = true
            Teh.disappearingtrails.colors[i] = thisColor
            colorIndex = colorIndex + 1
            if colorIndex > 16 then
                colorIndex = 1
            end
        end
    end
end

Teh_ColorizeDisappearingTrails()