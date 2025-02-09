-- Constants
local CATEGORY = "tt.mc.cm.rm.shoppinglist"
local worldCategory = World:CategoryByType(CATEGORY)
local ITEM_NAMES = {
    "Caledon Lavender",
    "Hylek Armor",
    "Crab Meat",
    "Seraph Badge",
    "Piece of Charr Scrap Metal",
    "Cursed Pirate Artifact",
    "Pirate Outfit",
    "Skritt Artifact",
    "Special Root",
    "Supplies",
    "Volcanic Earth Elemental Core",
    "Beta Inquest Control Key",
    "Barracuda Meat",
}

Teh.shoppinglist = {
    currentItem = 1,
    currentMarker = nil,
    shown = false
}

Debug:Watch("Teh_ShoppingList", Teh.shoppinglist)

local function spawnShoppingList()
    local pPos = Mumble.PlayerCharacter.Position
    local i = Teh.shoppinglist.currentItem
    local attributes = {
        xpos = pPos.X,
        ypos = pPos.Z,
        zpos = pPos.Y,
        type = CATEGORY,
        iconSize = 2,
        autotrigger = 0,
        triggerrange = 2,
        ["script-trigger"] = "Teh_ShoppingList()",
        info = "Press F to copy " .. ITEM_NAMES[i] .. " to clipboard",
        copy = ITEM_NAMES[i],
        ["copy-message"] = "Shopping list item copied to clipboard"
    }
    worldCategory:Show()
    Teh.shoppinglist.currentMarker = Pack:CreateMarker(attributes)
    Teh.shoppinglist.currentMarker:SetTexture("Data/TehsTrails/Markers/shoppinglist.png")
    Teh.shoppinglist.shown = true
end

local function removeShoppingList()
    Teh.shoppinglist.currentMarker:Remove()
    Teh.shoppinglist.currentMarker = nil
    Teh.shoppinglist.currentItem = 1
    Teh.shoppinglist.shown = false
    worldCategory:Hide()
end

function Teh_ShoppingList(marker, autoTriggered)
    Teh.shoppinglist.currentItem = Teh.shoppinglist.currentItem + 1
    if (Teh.shoppinglist.currentItem > 13) then Teh.shoppinglist.currentItem = 1 end
    local i = Teh.shoppinglist.currentItem
    marker:GetBehavior("CopyModifier").CopyValue = ITEM_NAMES[i]
    marker:GetBehavior("InfoModifier").InfoValue = "Press F to copy " .. ITEM_NAMES[i] .. " to clipboard"
end

function Teh_ToggleShoppingList()
    if (Teh.shoppinglist.shown) then
        removeShoppingList()
    else
        spawnShoppingList()
    end
end