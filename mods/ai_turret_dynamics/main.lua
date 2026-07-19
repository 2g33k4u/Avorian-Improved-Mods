-- [AI] Turret Dynamics bootstrap.
-- This file is loaded by Avorion when the mod is enabled on the server.

function initialize()
    print("[AI] Turret Dynamics: server bootstrap initialized.")
    Server():registerCallback("onPlayerLogIn", "onPlayerLogIn")
    Galaxy():registerCallback("onAllianceCreated", "onAllianceCreated")
end

function onPlayerLogIn(playerIndex)
    print(string.format("[AI] Turret Dynamics: player login callback for %s.", tostring(playerIndex)))
    local player = Player(playerIndex)
    if not valid(player) then return end

    player:addScriptOnce("turretdynamics/player.lua")

    local alliance = Alliance(player.allianceIndex)
    if valid(alliance) then
        alliance:addScriptOnce("turretdynamics/alliance.lua")
    end
end

function onAllianceCreated(allianceIndex)
    local alliance = Alliance(allianceIndex)
    if valid(alliance) then
        alliance:addScriptOnce("turretdynamics/alliance.lua")
    end
end
