---@meta

---@class Vector3
---@field X number # The X component of the vector.
---@field Y number # The Y component of the vector.
---@field Z number # The Z component of the vector.
---@operator add(Vector3): Vector3
---@operator sub(Vector3): Vector3
---@operator mul(Vector3): Vector3
---@operator div(Vector3): Vector3
---@operator mul(number): Vector3
---@operator div(number): Vector3
local Vector3 = {}

---Calculates the length of a vector.
---@return number vectorLength # The length of the vector.
function Vector3.Length(this) end

---Returns the dot product of this vector and another.
---@param vector3 Vector3
---@return number dotProduct # The dot product of the two vectors.
function Vector3.Dot(this, vector3) end

function Vector3.Normalize(this) end

---Returns the cross product of this vector and another.
---@param vector3 Vector3
---@return Vector3 crossProduct # The cross product of the two vectors.
function Vector3.Cross(this, vector3) end