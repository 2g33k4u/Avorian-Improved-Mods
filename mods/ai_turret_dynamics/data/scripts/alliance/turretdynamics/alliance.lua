package.path = package.path .. ";data/scripts/lib/?.lua"

local Core = include("turretdynamics/core")

-- namespace TurretDynamicsAlliance
TurretDynamicsAlliance = {}

function TurretDynamicsAlliance.initialize()
    if onClient() then return end

    Alliance():registerCallback("onItemAdded", "onItemAdded")
end

function TurretDynamicsAlliance.onItemAdded(item, itemIndex, amount, amountBefore, tagsChanged)
    if onClient() then return end

    local alliance = Alliance()
    local inventory = alliance:getInventory()

    -- See the Player equivalent: replacement is required for persistence and
    -- keeps older items in an existing stack unchanged.
    for _ = 1, amount or 1 do
        local tunedTurret = Core.prepareForReplacement(inventory:find(itemIndex), "alliance")
        if not tunedTurret then return end

        inventory:remove(itemIndex)
        inventory:add(tunedTurret, true)
    end
end
