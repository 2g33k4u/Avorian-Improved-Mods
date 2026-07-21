# [AI] Turret Dynamics changelog

## 0.1.2

- Persisted the server-side inventory baseline across normal save/restart cycles for more reliable new-turret detection.
- Made optional custom weapon-type support configuration-based; Autocannon remains supported without a dependency.
- Preserved monitor timing remainder after a lag spike for steadier scan cadence.
- Kept the monitor at its tested 0.5-second interval and made the internal core module local to avoid namespace collisions.

## 0.1.1

- Replaced client-mirrored Player and Alliance helper scripts with a server-only inventory monitor.
- Fixes client script-load warnings from the original Workshop release.
- Corrected the monitor's item fingerprint to use only turret fields available to Avorion scripts.
- Added optional support for the Autocannon turret mod; Autocannons use the projectile-combat 2.25x turn-speed adjustment.
- Keeps the mod server/host-only: joining players do not need to install it.
- The monitor establishes a baseline on startup, so turrets already in an inventory remain unchanged.

## 0.1.0

- Initial Workshop release.
