package.path = package.path .. ";data/scripts/lib/?.lua"

include("weapontype")
include("weapontypeutility")

local Config = include("turretdynamics/config")

TurretDynamicsCore = {}

local categoryByWeaponType = {
    [WeaponType.ChainGun] = "projectile",
    [WeaponType.PlasmaGun] = "projectile",
    [WeaponType.RocketLauncher] = "projectile",
    [WeaponType.Cannon] = "projectile",
    [WeaponType.RailGun] = "projectile",
    [WeaponType.Bolter] = "projectile",
    [WeaponType.PulseCannon] = "projectile",

    [WeaponType.PointDefenseChainGun] = "defensive",
    [WeaponType.PointDefenseLaser] = "defensive",
    [WeaponType.AntiFighter] = "defensive",

    [WeaponType.Laser] = "hitscan",
    [WeaponType.LightningGun] = "hitscan",
    [WeaponType.TeslaGun] = "hitscan",

    [WeaponType.MiningLaser] = "mining",
    [WeaponType.RawMiningLaser] = "mining",
    [WeaponType.SalvagingLaser] = "salvaging",
    [WeaponType.RawSalvagingLaser] = "salvaging",
    [WeaponType.RepairBeam] = "repair"
}

-- The optional Autocannon turret mod registers this type at runtime. Avoid a
-- hard dependency: if that mod is absent, its type simply does not exist.
if WeaponType.AutoCannon then
    categoryByWeaponType[WeaponType.AutoCannon] = "projectile"
end

local turnMultiplierByCategory = {
    projectile = Config.ProjectileCombatTurnMultiplier,
    defensive = Config.DefensiveTurnMultiplier,
    hitscan = Config.HitscanCombatTurnMultiplier,
    mining = Config.MiningTurnMultiplier,
    salvaging = Config.SalvagingTurnMultiplier,
    repair = Config.RepairBeamTurnMultiplier
}

function TurretDynamicsCore.isProcessed(turret)
    local descriptions = turret:getDescriptions()
    return descriptions[Config.ProcessedMarkerLabel] == Config.ProcessedMarkerValue
        or descriptions[Config.LegacyProcessedMarkerLabel] == Config.ProcessedMarkerValue
end

function TurretDynamicsCore.prepareForReplacement(turret, ownerLabel)
    if not turret or turret.itemType ~= InventoryItemType.Turret then
        if Config.DebugLogging then print("[AI] Turret Dynamics: skipped non-turret item.") end
        return nil
    end
    if TurretDynamicsCore.isProcessed(turret) then
        if Config.DebugLogging then print("[AI] Turret Dynamics: skipped already processed turret.") end
        return nil
    end

    local weaponType = WeaponTypes.getTypeOfItem(turret)
    if weaponType == WeaponType.ForceGun then
        if Config.DebugLogging then print("[AI] Turret Dynamics: Force Gun left unchanged.") end
        return nil
    end

    local category = categoryByWeaponType[weaponType]
    local turnMultiplier = turnMultiplierByCategory[category]
    if not turnMultiplier then
        if Config.DebugLogging then print("[AI] Turret Dynamics: skipped unclassified turret.") end
        return nil
    end

    -- Inventory:find() supplies an editable item value, not a persistent
    -- inventory reference. Do not construct InventoryTurret(turret): that
    -- constructor accepts a TurretTemplate and loses an InventoryTurret's
    -- weapon payload. The caller re-inserts this original complete item.
    local originalTurningSpeed = turret.turningSpeed
    turret.turningSpeed = originalTurningSpeed * turnMultiplier

    if category == "repair" then
        turret:setRange(turret.reach * Config.RepairBeamRangeMultiplier)
    end

    turret:addDescription(Config.ProcessedMarkerLabel, Config.ProcessedMarkerValue)

    if Config.DebugLogging then
        print(string.format("[AI] Turret Dynamics: prepared %s turret for %s (%.3f -> %.3f).", turret.weaponName, ownerLabel, originalTurningSpeed, turret.turningSpeed))
    end

    return turret
end

return TurretDynamicsCore
