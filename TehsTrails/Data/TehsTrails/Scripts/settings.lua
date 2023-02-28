--[[function Teh_Settings_Handler()
    local stomm = World:CategoryByType("tt.mc.ds.stomm")
    local shzomm = World:CategoryByType("tt.mc.ds.shzomm")
    local shzom = World:CategoryByType("tt.mc.ds.shzom")
    if (stomm:IsVisible()) then
        World:CategoryByType("tt.mc.hp.hpt")
        World:CategoryByType("tt.mc.tos")
        World:CategoryByType("tt.mc.sst")
        World:CategoryByType("tt.mc.h.ht")
        World:CategoryByType("tt.mc.ct")
    end
    if (shzomm:IsVisible()) then
        
    end
    if (shzom:IsVisible()) then
        
    end
end]]