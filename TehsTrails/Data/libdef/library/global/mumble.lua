---@meta

--#region Current Map

---@enum MumbleMapType
local MUMBLEMAPTYPES = {
    Unknown = -1,
    Redirect = 0,
    CharacterCreate = 1,
    Pvp = 2,
    Gvg = 3,
    Instance = 4,
    Public = 5,
    Tournament = 6,
    Tutorial = 7,
    UserTournament = 8,
    Center = 9,
    ExternalBattlegrounds = 9,
    BlueHome = 10,
    BlueBorderlands = 10,
    GreenHome = 11,
    GreenBorderlands = 11,
    RedHome = 12,
    RedBorderlands = 12,
    FortunesVale = 13,
    JumpPuzzle = 14,
    ObsidianSanctum = 14,
    EdgeOfTheMists = 15,
    PublicMini = 16,
    WvwLounge = 18
}

---@class MumbleCurrentMap
---@field Id integer # The current map ID.
---@field IsCompetitiveMode boolean # If the current map is a competitive map.
---@field Type MumbleMapType # The type of the current map.

--#endregion

--#region Info

---@class MumbleInfo
---@field BuildId integer # The current build ID of the game.
---@field IsGameFocused boolean # Indicates if the game is actively focused.

--#endregion

--#region Player Camera

---@class MumblePlayerCamera
---@field FarPlaneRenderDistance number
---@field FieldOfView number # The camera's FoV.
---@field Forward Vector3 # The camera's forward vector.
---@field NearPlaneRenderDistance number
---@field Position Vector3 # The camera position.

--#endregion

--#region Player Character

---@enum MumbleMountType
local MUMBLEMOUNTTYPES = {
    None = 0,
    Jackal = 1,
    Griffon = 2,
    Springer = 3,
    Skimmer = 4,
    Raptor = 5,
    RollerBeetle = 6,
    Warclaw = 7,
    Skyscale = 8,
    Skiff = 9,
    SiegeTurtle = 10
}

---@enum MumbleRaceType
local MUMBLERACETYPES = {
    Asura = 0,
    Charr = 1,
    Human = 2,
    Norn = 3,
    Sylvari = 4
}

---@class MumblePlayerCharacter
---@field CurrentMount MumbleMountType # Indicates the player's current mount.
---@field Forward Vector3 # The character's forward vector.
---@field IsCommander boolean # Indicates if the player has a commander tag enabled.
---@field IsInCombat boolean # Indicates if the player is actively in combat.
---@field Name string # The character name.
---@field Position Vector3 # The character's position.
---@field Race MumbleRaceType # The character's race.
---@field Specialization integer # The ID of the character's specialization.
---@field TeamColorId integer

--#endregion

--#region UI

---@enum MumbleUiSize
local MUMBLEUISIZES = {
    Small = 0,
    Normal = 1,
    Large = 2,
    Larger = 3
}

---@class MumbleUi
---@field CompassRotation number # The compass' rotation.
---@field CompassSize any # The size of the compass.
---@field IsCompassRotationEnabled boolean # Indicates if the compass has rotation enabled.
---@field IsCompassTopRight boolean # Indicates if the compass is shown in the top right.
---@field IsMapOpen boolean # Indicates if the map is open fullscreen.
---@field IsTextInputFocused boolean # Indicates if a textbox is focused in-game (does not include the trading post search or some other textboxes).
---@field MapCenter any # The center of the map.
---@field MapPosition any # The position the map is currently set to.
---@field MapScale number # The current map zoom.
---@field UISize MumbleUiSize # The in-game UI scale.

--#endregion

---@class Mumble
---@field CurrentMap MumbleCurrentMap
---@field CurrentMumbleMapName string
---@field Info MumbleInfo
---@field IsAvailable boolean # Indicates if the Mumble API is currently available.
---@field PlayerCamera MumblePlayerCamera
---@field PlayerCharacter MumblePlayerCharacter
---@field Tick integer
---@field TimeSinceTick TimeSpan
---@field UI MumbleUi
Mumble = {}