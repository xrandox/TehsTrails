Teh.choosewaypoint = {
    chooseableWaypoints = {},
    isRunning = false,
    currentSize = 75,
    sizeGrowing = true
}

Debug:Watch("Teh_ChooseWaypoint", Teh.choosewaypoint)
local MAX_SIZE = 150
local MIN_SIZE = 75

local function startWatcher(marker)
    if (next(Teh.choosewaypoint.chooseableWaypoints) == nil) then
        marker:GetBehavior("InfoModifier").InfoValue = "You're done! (Hopefully...)"
        return
    end
    Teh.choosewaypoint.isRunning = true
end

local function stopWatcher(marker)
    Teh.choosewaypoint.isRunning = false
    Teh.choosewaypoint.currentSize = MIN_SIZE
    Teh.choosewaypoint.sizeGrowing = true
    Teh.choosewaypoint.chooseableWaypoints[marker.Guid] = nil
    marker:Remove()

    for _, m in pairs(Teh.choosewaypoint.chooseableWaypoints) do
        m.MapDisplaySize = MIN_SIZE * Mumble.UI.MapScale
        m.MapVisibility = false
    end
end

local function waypointWatcher()
    for _, marker in pairs(Teh.choosewaypoint.chooseableWaypoints) do
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

    for _, marker in pairs(Teh.choosewaypoint.chooseableWaypoints) do
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

function Teh_ChooseWaypointMarker(marker)
    Teh.choosewaypoint.chooseableWaypoints[marker.Guid] = marker
end

function Teh_ChooseWaypointTrigger(marker, isfocused)
    if (isfocused and Teh.choosewaypoint.isRunning == false) then
        startWatcher(marker)
    end
end

Event:OnTick(chooseWaypointTickHandler)