---@meta

---A marker pack category.
---@class Category
---@field DefaultToggle boolean # If the category is enabled by default.
---@field DisplayName string # The display name of the category displayed within the UI.
---@field IsHidden boolean # If the category is hidden in the UI.
---@field IsSeparator boolean # If the category is used as a separator within the UI.
---@field LoadedFromPack boolean # If the category was loaded from a pack.
---@field Name string # The name of the category (the 'name' attribute).
---@field Namespace string # The namespace of the category (the 'type' attribute used by other pathables).
---@field Parent Category|nil # The parent category of this category or nil if there is no parent category.
---@field Root boolean # If the category is the root category.
local Category = {}

---Returns the requested category by namespace if one exists or creates one and returns it.
---@param namespace string # The namespace of the category to return.
---@return Category category # The existing or created category.
function Category.GetOrAddCategoryFromNamespace(this, namespace) end

--#region Extension Functions

---Indicates if the category is currently enabled by the user.
---@return boolean visible # True if the user has enabled this category.  Otherwise false.
function Category.IsVisible(this) end

---Enables the category.
function Category.Show(this) end

---Disables the category.
function Category.Hide(this) end

---Returns all markers directly within the category.
---@param getAll? boolean # If true, all child markers are returned. If false or not provided, only the markers directly within the category are returned.
---@return Marker[] markers
function Category.GetMarkers(this, getAll) end

--#endregion