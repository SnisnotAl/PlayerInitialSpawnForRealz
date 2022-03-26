--[[
    PlayerInitialSpawnForRealz b1.0
    Mainly created as a way to tell if a client is fully connected
    serverside, without the use of the net library

    This idea was inspired by the warning example code on
    https://wiki.facepunch.com/gmod/GM:PlayerInitialSpawn

    I have just made it into it's own (serverside) hook and
    a (shared) player metafunction to determine if the player
    has been fully loaded serverside!

    Functions:
        - player:HasSpawnedForRealz()
            - Returns boolean
    
    Hooks:
        - PlayerInitialSpawnForRealz( player ply, boolean transition )

    Example code (serverside):
        hook.Add("PlayerInitialSpawnForRealz", "PISFR_Example_1", function(ply, transition)
            MsgC(Color(255,155,155), ply:Nick(), Color(155,155,255), " has spawned for realz!\n")
        end)
]]

local PlayerMeta = FindMetaTable("Player")

if SERVER then
    local MainHookID = "PISFR_MHI"

    hook.Add("PlayerInitialSpawn", MainHookID, function(ply, transition)
        local PlayerHookID = string.format("PISFR_PHI_%s", ply:SteamID())

        hook.Add("SetupMove", PlayerHookID, function(ply2,_,mvc)
            if not IsValid(ply2) then return end
            if ply ~= ply2 then return end
            if mvc:IsForced() then return end

            hook.Run("PlayerInitialSpawnForRealz", ply, transition)
            hook.Remove("SetupMove", PlayerHookID)
            ply:SetNWBool("PISFR", true)
        end)
    end)
end

function PlayerMeta:HasSpawnedForRealz()
    if not IsValid(self) then return false end
    return self:GetNWBool("PISFR", false)
end
