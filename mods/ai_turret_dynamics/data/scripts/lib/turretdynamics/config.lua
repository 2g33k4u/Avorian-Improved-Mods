-- [AI] Turret Dynamics configuration.
-- Change only the multiplier values below. A value of 1.0 leaves that category unchanged.

return {
    ProjectileCombatTurnMultiplier = 2.25,
    DefensiveTurnMultiplier = 1.50,
    HitscanCombatTurnMultiplier = 1.50,
    MiningTurnMultiplier = 1.75,
    SalvagingTurnMultiplier = 1.75,
    RepairBeamTurnMultiplier = 1.75,
    RepairBeamRangeMultiplier = 1.50,

    -- This description is the persistent idempotency marker. It is intentionally
    -- visible in the turret tooltip so players can identify a processed item.
    ProcessedMarkerLabel = "◆ [AI] TURRET DYNAMICS — %s ◆",
    ProcessedMarkerValue = "Applied (v1)",
    LegacyProcessedMarkerLabel = "[AI] Turret Dynamics",

    -- The monitor runs twice per second. Its first pass creates a baseline and
    -- intentionally leaves all pre-existing turrets untouched.
    ScanInterval = 0.50,

    -- Keep false outside diagnostic testing to avoid routine log output.
    DebugLogging = false
}
