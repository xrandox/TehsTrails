-- Constants
local MARKERS_IN_CIRCLE = 11
local MARKER_DISTANCE_FROM_PLAYER = 10
local INFO_RANGE = 4
local MARKER_CATEGORY = "tt.mc.cm.rm.points_of_interest"
local MARKER_CATALOG = {
    {
        info = {
            "This marker shows the start of the trail on the current map.\n\nYou can also view the start of all maps by going to Scripts -> Tehs Trails -> Toggle Starting Point Markers, but you must be in a core map\n\n(Press F to flip to next page)",
            "While you can run the maps in any order, the pack does technically have an intended map-order, starting in Lion's Arch\n\nThis red marker shows the way to the next map in the intended map order\n\n(Press F to flip to the next page)",
            "If you want an overview of the full intended map-order, you can visit the wiki page\n\n(Press F copy the wiki link to your clipboard and return to the first page)"
        },
        iconFile = { "Data/TehsTrails/Markers/Start.png", "Data/TehsTrails/Markers/ExitMap.png", "Data/TehsTrails/Markers/Start.png" },
        iconSize = { 1, 1, 1 },
        copy = { "", "", "https://github.com/xrandox/TehsTrails/wiki/Map-Starting-Points-and-%22Intended%22-Map-Order" },
        copyMessage = "Wiki link copied to clipboard",
        maxPages = 3
    },
    {
        info = {
            "Scripts can be tweaked via the Pathing 'Scripts' menu\n\nTo access the menu, left-click the Pathing icon and hover over Scripts -> Tehs Trails\n\nThere you can change the settings to however you like\n\n(Press F to flip to next page)",
            "Please note that these script settings are unique to Teh's Trails and will have no affect on any other packs you have installed\n\nIf anything ever messes up, you can also reset all scripts in the script menu\n\n(Press F to return to the first page)"
        },
        iconFile = { "Data/TehsTrails/Markers/scripts.png", "Data/TehsTrails/Markers/scripts.png" },
        iconSize = { 1, 1 },
        copy = { "", "" },
        copyMessage = "",
        maxPages = 2
    },
    {
        info = {
            "This marker shows you when you should start completing a heart\n\nAlmost always, there will be a textbox with it telling you the fastest ways to complete the heart\n\nIt will follow you around and point to the finish marker so you can easily get back on track. This can be toggled in the script menu\n\n(Press F to flip to next page)",
            "You may see this marker occasionally at hearts. Many heart interactables can have their channel time interrupted by weaponswapping, and still grant credit. This allows you to interact with an object, weaponswap, and move on to the next one without needing to wait for the channel to complete\n\n(Press F to flip to next page)",
            "Sometimes you will see areas outlined with walls that look like this, these are hotspots to complete hearts\n\n(Press F to flip to next page)",
            "Some hearts also have separate trails, which look like this, to follow when completing the heart\n\n(Press F to return to the first page)"
        },
        iconFile = { "Data/TehsTrails/Markers/Renown_Heart_empty.png", "Data/TehsTrails/Markers/WeaponSwap.png", "Data/TehsTrails/Markers/HeartZone.png", "Data/TehsTrails/Markers/HeartTrail.png"},
        iconSize = { 0.8, 0.8, 0.8, 1 },
        copy = { "", "", "", "" },
        copyMessage = "",
        maxPages = 4
    },
    {
        info = {
            "Skyscale is used frequently to gain height for griffon dives\n\nThere's no real trick behind this since Anet made the change to allow midair dismounting\n\nSpamming dodges with your camera angled up while also holding spacebar to climb can be used to gain slightly higher altitude quicker than you could by just flying up, that's about it\n\n(Press F to flip to the next page)",
            "This marker signifies when you should dismount from Skyscale and swap to griffon\n\nThis allows you to superdive where you might not otherwise have the clearance\n\n(Press F to flip to the next page)",
            "If you dont have skyscale you can usually use B2G (see marker to left) instead, although not always\n\nYou can also make use of Glide Booster (Jade Bot required) to gain even more height if needed, or in place of B2G if you have T3\n\nWe recommend using Glide Booster and Mount Energy upgrades for your jade bot if possible. They make a big difference!\n\n(Press F to flip to the next page)",
            "Finally, you may occasionally see this marker in places with lots of enemies where you don't want to be put in combat. It just means to use the Stealth mount mastery\n\n(Press F to return to the first page)"
        },
        iconFile = { "Data/TehsTrails/Markers/skyscale.png", "Data/TehsTrails/Markers/DismountToGriff.png", "Data/TehsTrails/Markers/glidebooster.png", "Data/TehsTrails/Markers/StealthMount.png" },
        iconSize = { 1.2, 1.5, 1, 1 },
        copy = { "", "", "", "" },
        copyMessage = "",
        maxPages = 4
    },
    {
        info = {
            "This marker represents B2G, aka Bunny to Griffon. The idea is to dismount from a springer jump midair, then mount onto griffon for an immediate superdive\n\nThis allows you to superdive where you otherwise would not have the height\n\nThis technique used to be widely used, but midair dismounting has mostly taken its place nowadays\n\n(Press F to flip to the next page)",
            "It is fairly easy to do, the process looks like this:\n - Hold down jump key on springer\n - With 1/4 endurance bar left, also press and hold dismount key\n\n(Press F to flip to the next page)",
            "Feel free to watch the video at the provided link if you need a visual demonstration\n\n(Press F copy the video link to your clipboard and return to the first page)"
        },
        iconFile = { "Data/TehsTrails/Markers/BunnyToGriff.png", "Data/TehsTrails/Markers/BunnyToGriff.png", "Data/TehsTrails/Markers/BunnyToGriff.png"},
        iconSize = { 1.5, 1.5, 1.5 },
        copy = { "", "", "https://streamable.com/6udtba" },
        copyMessage = "Video link copied to clipboard",
        maxPages = 3
    },
    {
        info = {
            "This marker represents Jackal Launch, which is the hardest movement tech we use. The idea is to Pounce, Blink and press Bond of Faith in quick succession\n\nThis results in launching you a significant horizontal distance, but the timing can be tricky to get down\n\n(Press F to flip to the next page)",
            "On paper, the process is:\nPounce (attack dismount) -> Blink (dodge) -> Bond of Faith\n\nIf done correctly, the pounce + dodge will accelerate you to ~180 units/s and Bond of Faith will snapshot that speed for its initial velocity\n\n(Press F to flip to the next page)",
            "If you need a visual demonstration, you can watch the video at the provided link\n\nIf you can't consistently pull this off, feel free to ignore the markers, it's not a huge deal in most cases\n\n(Press F copy the video link to your clipboard and return to the first page)"
        },
        iconFile = {"Data/TehsTrails/Markers/JackalLaunch.png", "Data/TehsTrails/Markers/JLTut.png", "Data/TehsTrails/Markers/JackalLaunch.png"},
        iconSize = { 1.5, 2.5, 1.5 },
        copy = { "", "", "https://www.youtube.com/watch?v=BsFiWgqBnPA" },
        copyMessage = "Video link copied to clipboard",
        maxPages = 3
    },
    {
        info = {
            "This marker is used at hearts where you can buy an item at the trading post which can be turned in to the NPC and instantly complete the heart\n\nSome can be a bit expensive, but hearts suck so generally trading a few silver/gold to be able to instantly complete them is awesome\n\n(Press F to flip to the next page)",
            "If you want to prepare the items in advance, you can open the shopping list from the script menu:\n\nScripts -> Tehs Trails -> Open/Close Shopping List\n\nYou can then copy the required items one at a time and paste them into the TP to buy them\n\nRecommend doing this away from NPCs and then collecting from the TP afterwards, so you don't end up interacting with the NPC when copying to your clipboard\n\n(Press F to return to the first page)"
        },
        iconFile = {"Data/TehsTrails/Markers/Trading_Post.png", "Data/TehsTrails/Markers/Trading_Post.png"},
        iconSize = { 1.2, 1.2 },
        copy = { "", "" },
        copyMessage = "",
        maxPages = 2
    },
    {
        info = {
            "While you can use any class and build to do map comp, a proper build will save you a lot of time. Currently, Deadeye is the king of map comp\n\nIf you would like to get the build template code for the typical mapcomp DE build and learn about how it is played, go to the next page!\n\n(Press F to copy build template code and flip to the next page)",
            "The playstyle of this build is very simple, which is part of what makes it so good\n\nBasically, your deadeye's mark (steal) hits like a truck and will one-tap most things within 1500 range\n\nKilling a marked mob resets the marks cooldown and reduces your utility skill cooldowns, so you can spam it and your utility skills\n\nFor beefier enemies you can use stolen skills and or pistol 3/rifle 3\n\n(Press F to flip to the next page)",
            "On top of the insane ranged damage at the press of a single button, you have:\n - Withdraw for disengage/condi cleanse\n - Shadowstap + Infil Signet for two 1,200 teleports\n - Assassin's Signet for even more damage\n - Dagger Storm for groups/long evade\n\nYou can carry rifle for longer range clean up, or shortbow for more mobility with SB 5\n\nHighly recommend changing F1 to another keybind so you dont cripple your hands :D\n\n(Press F to return to the first page)"
        },
        iconFile = {"Data/TehsTrails/Markers/deadeye.png", "Data/TehsTrails/Markers/deadeye.png", "Data/TehsTrails/Markers/deadeye.png"},
        iconSize = { 1.2, 1.2, 1.2 },
        copy = { "[&DQUcLiw7OioMAQoBMwEzAVgBWAFYABkBnwEoAAAAAAAAAAAAAAAAAAAAAAACVQBrAAA=]", "", "" },
        copyMessage = "Build Template code copied to clipboard",
        maxPages = 3
    },
    {
        info = {
            "You may occasionally see this marker at a heart, or see a heart telling you to 'Condi-stack'\n\nCondi-stacking is simply stacking as many conditions as possible on a mob before it dies\n\nThis takes advantage of a bug to very quickly gain heart % from repeatedly killing an enemy\n\n(Press F to flip to the next page)",
            "Condi-stacking works because some 'enemies' will turn friendly or not actually die when you kill them\n\nSince conditions remain after they reach 0 HP, as they regen health, the condi's continue to tick and repeatedly 'kill' the mob, granting you heart contribution each time\n\n(Press F to flip to the next page)",
            "The best build for condi stacking is something that has high stack application and duration but low damage so they stay alive long enough for us to stack a bunch of conditions\n\nThe best gear for this is typically Trailblazers. If you are playing thief, the standard condi-stacking build template will be copied to your clipboard when you press F.\n\n(Press F to copy build template to your clipboard and return to the first page)"
        },
        iconFile = {"Data/TehsTrails/Markers/condistacking.png", "Data/TehsTrails/Markers/condistacking.png", "Data/TehsTrails/Markers/condistacking.png"},
        iconSize = { 1, 1, 1 },
        copy = { "", "", "[&DQUcGyw9OikKAQoBLwEvAT4BPgELAVgBnwEoAAAAAAAAAAAAAAAAAAAAAAA=]" },
        copyMessage = "Build Template code copied to clipboard",
        maxPages = 3
    },
    {
        info = {
            "If you have any questions that this tutorial did not answer, or you just want to join our community, feel free to join us on the Teh's Trails discord!\n\n(Press F to copy the discord link to your clipboard)"
        },
        iconFile = {"Data/TehsTrails/Markers/discord.png"},
        iconSize = { 0.9 },
        copy = { "https://discord.gg/bJV6VXT" },
        copyMessage = "Discord link copied to clipboard",
        maxPages = 1
    },
    {
        info = {
            "Welcome to Teh's Trails!\n\nThe markers around you are part of a tutorial to help you understand how to use the pack\n\nEach marker in the circle has different info attached to it, which you can read by walking up to the marker. Pressing F will advance the 'page'.\n\n(Press F to flip to the next page)",
            "As a disclaimer: This pack is specifically tailored to speed completing maps. It's a bit more on the 'try-hard' side and not intended for your first time doing map comp. If you want a more casual, 'brain-off' experience, I would recommend checking out Reactif or Tekkit's packs!\n\n(Press F to flip to the next page)",
            "To be able to use this pack properly you will need:\n - All mounts + mount masteries\n(especially Skyscale, Griffon and Beetle)\n - Prototype Position Rewinder\n - Jade Waypoint\n\nYou can follow the trails without these, but you may struggle at times and it will take considerably longer\n\n(Press F to flip to the next page)",
            "Feel free to move around to the other markers to read up on more tutorial info!\n\nIf you ever want to reread the tutorial, or if a tutorial marker spawned somewhere inaccessible, you can always reopen the tutorial from the Script Menu\n\nScripts -> Tehs Trails -> Show/Hide Tutorial\n\n(Press F to flip back to the first page)"
        },
        iconFile = {"Data/TehsTrails/Markers/Trail.png", "Data/TehsTrails/Markers/Trail.png", "Data/TehsTrails/Markers/Trail.png", "Data/TehsTrails/Markers/Trail.png" },
        iconSize = { 0.6, 0.6, 0.6, 0.6 },
        copy = { "", "", "", "" },
        copyMessage = "",
        maxPages = 4
    },
}

Teh.tutorial = {
    origin = nil,
    markerOffsets = {},
    pageTracker = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    markers = {},
    shown = false
}

Debug:Watch("tutorial", Teh.tutorial)

local function showTutorial()
    -- First we make the outer markers
    -- get angle between each marker
    local angle = 2 * math.pi / (MARKERS_IN_CIRCLE - 1)
    -- get player position as the origin
    Teh.tutorial.origin = Mumble.PlayerCharacter.Position

    for i = 1, MARKERS_IN_CIRCLE do
        local theta = angle * i
        local x = MARKER_DISTANCE_FROM_PLAYER * math.cos(theta)
        local y = MARKER_DISTANCE_FROM_PLAYER * math.sin(theta)

        if (i == MARKERS_IN_CIRCLE) then
            x = 0
            y = 0
        end

        local attributes = {
            xpos = Teh.tutorial.origin.X + x,
            ypos = Teh.tutorial.origin.Z,
            zpos = Teh.tutorial.origin.Y + y,
            MapVisibility = false,
            InGameVisibility = true,
            Info = MARKER_CATALOG[i].info[1],
            iconSize = MARKER_CATALOG[i].iconSize[1],
            InfoRange = INFO_RANGE,
            type = MARKER_CATEGORY,
            copy = MARKER_CATALOG[i].copy[1],
            ["copy-message"] = MARKER_CATALOG[i].copyMessage,
            ["script-trigger"] = "Teh_Infoflip(" .. i .. ")"
        }

        local newMarker = Pack:CreateMarker(attributes)
        newMarker:SetTexture(MARKER_CATALOG[i].iconFile[1])
        table.insert(Teh.tutorial.markers, newMarker)
    end

    Teh.tutorial.shown = true
end

local function hideTutorial()
    for _, marker in pairs(Teh.tutorial.markers) do
        marker:Remove()
    end

    Teh.tutorial.origin = nil
    Teh.tutorial.markerOffsets = {}
    Teh.tutorial.pageTracker = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
    Teh.tutorial.markers = {}
    Teh.tutorial.shown = false
end

if (Teh_GetBool("firstLaunch")) then
    showTutorial()
    Teh_ToggleStorage("firstLaunch")
end

function Teh_Infoflip(marker, autoTriggered, num)
    -- only do something if they actually pressed F
    if (autoTriggered == false) then
        -- Get catalog for the current marker
        local infoCatalog = MARKER_CATALOG[num]

        -- Get the new page
        local newPage = Teh.tutorial.pageTracker[num] + 1
        if (newPage > infoCatalog.maxPages) then newPage = 1 end

        -- Set new values to the new page
        marker:SetTexture(infoCatalog.iconFile[newPage])
        marker.Size = infoCatalog.iconSize[newPage]
        marker:GetBehavior("InfoModifier").InfoValue = infoCatalog.info[newPage]
        marker:GetBehavior("CopyModifier").CopyValue = infoCatalog.copy[newPage]

        Teh.tutorial.pageTracker[num] = newPage
    end
end

function Teh_ToggleTutorial()
    if (Teh.tutorial.shown) then
        hideTutorial()
    else
        showTutorial()
    end
end

local function tutorialTickHandler(gametime)
    if (Teh.tutorial.shown) then
        if ((Mumble.PlayerCharacter.Position - Teh.tutorial.origin):Length() > 50) then
            hideTutorial()
        end
    end
end

Event:OnTick(tutorialTickHandler)