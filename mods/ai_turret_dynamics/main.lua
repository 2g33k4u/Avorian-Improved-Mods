-- [AI] Turret Dynamics server-only inventory monitor.
-- New turret acquisitions are detected without attaching scripts to players or clients.

package.path = package.path .. ";data/scripts/lib/?.lua"

local Core = include("turretdynamics/core")
local Config = include("turretdynamics/config")

local elapsed = 0
local snapshots = {}

local function fingerprint(turret)
    return table.concat({
        tostring(turret.weaponName or ""),
        tostring(turret.reach or ""),
        tostring(turret.turningSpeed or "")
    }, "\31")
end

local function ownerKey(ownerLabel, owner)
    return ownerLabel .. ":" .. tostring(owner.index)
end

local function tuneNewTurrets(owner, ownerLabel)
    if not valid(owner) then return end

    local inventory = owner:getInventory()
    if not inventory then return end

    local key = ownerKey(ownerLabel, owner)
    local previous = snapshots[key]

    for index, entry in pairs(inventory:getItems()) do
        local item = entry.item
        if item and item.itemType == InventoryItemType.Turret then
            local itemFingerprint = fingerprint(item)
            local amount = entry.amount or 1

            -- The first pass establishes a baseline so existing turrets are never migrated.
            if previous then
                local prior = previous[index]
                local newCount = 0
                if not prior or prior.fingerprint ~= itemFingerprint then
                    newCount = amount
                elseif amount > prior.amount then
                    newCount = amount - prior.amount
                end

                for _ = 1, newCount do
                    local turret = inventory:find(index)
                    if turret and Core.prepareForReplacement(turret, ownerLabel) then
                        inventory:remove(index)
                        inventory:add(turret, true)
                    end
                end
            end
        end
    end

    -- Re-snapshot after any replacement, including Turret Dynamics' own marker.
    local refreshed = {}
    for index, entry in pairs(inventory:getItems()) do
        local item = entry.item
        if item and item.itemType == InventoryItemType.Turret then
            refreshed[index] = {fingerprint = fingerprint(item), amount = entry.amount or 1}
        end
    end
    snapshots[key] = refreshed
end

local function scanInventories()
    local scannedAlliances = {}
    for _, player in pairs({Server():getPlayers()}) do
        tuneNewTurrets(player, "Player")

        local allianceIndex = player.allianceIndex
        if allianceIndex and allianceIndex >= 0 and not scannedAlliances[allianceIndex] then
            local alliance = Alliance(allianceIndex)
            if valid(alliance) then
                tuneNewTurrets(alliance, "Alliance")
                scannedAlliances[allianceIndex] = true
            end
        end
    end
end

function initialize()
    print("[AI] Turret Dynamics: server-only inventory monitor initialized.")
end

function update(timeStep)
    if not onServer() then return end

    elapsed = elapsed + timeStep
    if elapsed < Config.ScanInterval then return end
    elapsed = 0

    scanInventories()
end
