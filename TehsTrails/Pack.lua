function Teh_Highlight_Waypoint(marker, isfocused, markerguid)
    local waypoint = World:MarkerByGuid(markerguid);

    if (isfocused) then
        waypoint:SetTexture("Data/TehsTrails/Markers/waypoint-highlight.png");
        waypoint.MapVisibility = true;
        waypoint.MiniMapVisibility = true;
        waypoint.glow = true;
    else
        waypoint:SetTexture("Data/TehsTrails/Markers/Waypoint.png");
        waypoint.MapVisibility = false;
        waypoint.MiniMapVisibility = false;
        waypoint.glow = false;
    end
end