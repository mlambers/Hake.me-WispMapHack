---------------------------------
-- WispMaphack.lua Version 0.1 --
---------------------------------

local WispMaphack = {
    OptionEnable = Menu.AddOption({"mlambers", "Wisp Maphack"}, "1. Enable.", "Enable/Disable this script.")
}
local CachedIcon  = nil
local MyHero = nil

function WispMaphack.OnScriptLoad()
    CachedIcon  = nil
    MyHero = nil

    Console.Print("[" .. os.date("%I:%M:%S %p") .. "] - - [ WispMaphack.lua ] [ Version 0.1 ] Script load.")
end

function WispMaphack.OnParticleUpdateEntity(particle)
    if Menu.IsEnabled(WispMaphack.OptionEnable) == false then return end
	
    if MyHero == nil then return end
    
    if
        particle.entity
        and particle.position
        and Entity.GetClassName(particle.entity) == 'C_DOTA_Unit_Hero_Wisp'
        and Entity.IsSameTeam(MyHero, particle.entity) == false 
        and (
            Entity.IsDormant(particle.entity)
            or FogOfWar.IsPointVisible(particle.position) == false
        ) 
        then
            
        if NPC.IsIllusion(particle.entity) then return end

        CachedIcon = MiniMap.AddIconByName(CachedIcon, "minimap_heroicon_npc_dota_hero_wisp", particle.position, 255, 255, 255, 255, 0.9, 900)
        
    end
end

function WispMaphack.OnUpdate()
    if Menu.IsEnabled(WispMaphack.OptionEnable) == false then return end

    if MyHero == nil or MyHero ~= Heroes.GetLocal() then 
        CachedIcon = nil
        MyHero = Heroes.GetLocal()
        
        Console.Print("[" .. os.date("%I:%M:%S %p") .. "] - - [ WispMaphack.lua ] [ Version 0.1 ] Script init.")
        
        return
	end
end

return WispMaphack