function Teh_Reset_Scripts()
    if (Teh.bounce.isBouncing) then Teh_Bounce_Reset() end
    if (Teh.heartfollower.isFollowing) then Teh_Follower_Reset() end
    if (Teh.highlight.waypointHighlighted) then Teh_Highlight_Reset() end
    saveValue("hasSkyscale", "false")
    saveValue("trailColor", "Light Blue [Default]")
end