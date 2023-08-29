Teh.choosewaypoint = {
    chooseableWaypoints = {},
    isRunning = false,
    runningSet = nil,
    currentSize = 75,
    sizeGrowing = true
}

Debug:Watch("Teh_ChooseWaypoint", Teh.choosewaypoint)
local MAX_SIZE = 150
local MIN_SIZE = 75

local function startWatcher(marker, waypointSet)
    if (next(Teh.choosewaypoint.chooseableWaypoints[waypointSet]) == nil) then
        if (waypointSet == 3) then
            Teh_HighlightWaypoint(marker, true, "AkKsZ7g6w06leMCc8LTD7A==")
            marker:GetBehavior("InfoModifier").InfoValue = "Now teleport to Bastion of the Celestial to finish out the routes"
        else
            marker:GetBehavior("InfoModifier").InfoValue = "You're done! (Hopefully...)"
        end
        return
    end
    Teh.choosewaypoint.isRunning = true
    Teh.choosewaypoint.runningSet = waypointSet
end

local function stopWatcher(marker)
    Teh.choosewaypoint.isRunning = false
    Teh.choosewaypoint.currentSize = MIN_SIZE
    Teh.choosewaypoint.sizeGrowing = true
    Teh.choosewaypoint.chooseableWaypoints[Teh.choosewaypoint.runningSet][marker.Guid] = nil
    marker:Remove()

    for _, m in pairs(Teh.choosewaypoint.chooseableWaypoints[Teh.choosewaypoint.runningSet]) do
        m.MapDisplaySize = MIN_SIZE * Mumble.UI.MapScale
        m.MapVisibility = false
    end
    Teh.choosewaypoint.runningSet = nil
end

local function waypointWatcher()
    for _, marker in pairs(Teh.choosewaypoint.chooseableWaypoints[Teh.choosewaypoint.runningSet]) do
        if marker.Focused then
            stopWatcher(marker)
            return
        end
    end
end

local function waypointAnimator(gameTime)
    local elapsedSeconds = gameTime.ElapsedGameTime.TotalSeconds
    local size = Teh.choosewaypoint.currentSize
    local growing = Teh.choosewaypoint.sizeGrowing
    local INTERVAL = 180 * elapsedSeconds

    if (growing) then
        size = size + INTERVAL;
    else
        size = size - INTERVAL;
    end
    Teh.choosewaypoint.currentSize = size

    if (size > MAX_SIZE) then growing = false end
    if (size < MIN_SIZE) then growing = true end
    Teh.choosewaypoint.sizeGrowing = growing

    for _, marker in pairs(Teh.choosewaypoint.chooseableWaypoints[Teh.choosewaypoint.runningSet]) do
        marker.MapVisibility = true
        marker.MapDisplaySize = size * Mumble.UI.MapScale
    end
end

local function chooseWaypointTickHandler(gameTime)
    if (Teh.choosewaypoint.isRunning) then
        waypointAnimator(gameTime)
        waypointWatcher()
    end
end

function Teh_ChooseWaypointMarker(marker, waypointSet)
    if (Teh.choosewaypoint.chooseableWaypoints[waypointSet] == nil) then
        Teh.choosewaypoint.chooseableWaypoints[waypointSet] = {}
    end
    Teh.choosewaypoint.chooseableWaypoints[waypointSet][marker.Guid] = marker
end

function Teh_ChooseWaypointTrigger(marker, isfocused, waypointSet)
    if (isfocused and Teh.choosewaypoint.isRunning == false) then
        startWatcher(marker, waypointSet)
    end
end

Event:OnTick(chooseWaypointTickHandler)