---@meta

---A menu.
---@class Menu
---@field Name string
---@field OnClick fun(menu: Menu): any
---@field CanCheck boolean
---@field Checked boolean
---@field Tooltip string
Menu = {}

---Adds a new menu.
---@param name string # The name and display text of the menu.
---@param onClick fun(menu: Menu): any # The function called when the menu is clicked or toggled.
---@param canCheck? boolean # If provided, indicates if the menu has a checkbox.
---@param checked? boolean # If provided, indicates if the menu checkbox is checked.
---@param tooltip? string # If provided, sets the tooltip used by the menu.
---@return Menu
function Menu.Add(this, name, onClick, canCheck, checked, tooltip) end

---Removes the specified menu item.
---@param menuItem Menu # The menu item to remove.
function Remove(this, menuItem) end