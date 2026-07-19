package.path = package.path .. ";data/scripts/lib/?.lua"

local Core = include("turretdynamics/core")
local Config = include("turretdynamics/config")

-- namespace TurretDynamicsPlayer
TurretDynamicsPlayer = {}

function TurretDynamicsPlayer.initialize()
    if onClient() then return end

    if Config.DebugLogging then
        print("[AI] Turret Dynamics: Player inventory handler initialized.")
    end
    Player():registerCallback("onItemAdded", "onItemAdded")
    Player():registerCallback("onAllianceChanged", "onAllianceChanged")
end

function TurretDynamicsPlayer.onItemAdded(itemIndex, amount, amountBefore)
    if onClient() then return end

    local player = Player()
    local inventory = player:getInventory()
    local item = inventory:find(itemIndex)
    if Config.DebugLogging then
        print(string.format("[AI] Turret Dynamics: Player onItemAdded index=%s itemType=%s.", tostring(itemIndex), tostring(item and item.itemType)))
    end

    -- Remove and replace only the just-added item. This preserves any older
    -- matching items already stacked at this index, which v1 must not modify.
    for _ = 1, amount or 1 do
        local tunedTurret = Core.prepareForReplacement(inventory:find(itemIndex), "player")
        if not tunedTurret then return end

        inventory:remove(itemIndex)
        inventory:add(tunedTurret, true)
    end
end

function TurretDynamicsPlayer.onAllianceChanged(allianceIndex)
    if onClient() then return end

    local alliance = Alliance(allianceIndex)
    if valid(alliance) then
        alliance:addScriptOnce("turretdynamics/alliance.lua")
    end
end
