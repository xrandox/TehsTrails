Teh.hpmarkers = {
    hpMarkersAreHidden = false,
    hpCategory = World:CategoryByType("tt.mc.hp")
}

Debug:Watch("HP Markers", Teh.hpmarkers)

function Teh_HPMarker(marker, gameTime)
    if (Teh.hpmarkers.hpCategory:IsVisible() == false) then
        marker.InGameVisibility = false
        Teh.hpmarkers.hpMarkersAreHidden = true
    else
        marker.InGameVisibility = true
        Teh.hpmarkers.hpMarkersAreHidden = false
    end
end