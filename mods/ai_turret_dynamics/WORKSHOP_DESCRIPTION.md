# [AI] Turret Dynamics

Turret Dynamics improves the physical traverse speed of newly acquired Player and Alliance turret items, so turrets can align with their targets more responsively without turning this into a broad weapon-stat overhaul.

This mod is deliberately narrow in scope. It does not alter enemy or NPC turret items, and it does not change existing turret items already installed or stored in inventory.

## Update notes — 0.1.1

This maintenance update replaces the old Player/Alliance helper scripts with one server-only inventory monitor. It fixes client script-load warnings without changing the mod's gameplay scope: joining players still do not need to install the mod, and turrets already present when the server starts remain untouched.

The optional *Autocannon turret* mod is also supported: its custom Autocannon weapon type is treated as projectile combat and receives the 2.25x turn-speed adjustment.

## When to enable it

Turret Dynamics is best started in a fresh galaxy. It also works safely in an existing save, but only turrets acquired after enabling the mod receive the adjustment; all existing turret items remain unchanged.

## What it changes

- Projectile combat turrets: 2.25x turn speed
- Defensive and combat hitscan turrets: 1.5x turn speed
- Mining and salvaging turrets: 1.75x turn speed
- Repair Beams: 1.75x turn speed and 1.5x range
- Force Guns: unchanged

## What it does not change

- Damage
- Fire rate
- Energy use
- Projectile velocity
- Targeting behavior
- Range, except Repair Beams
- Enemy or NPC turrets

All values are configurable. Turrets receive a persistent `◆ [AI] TURRET DYNAMICS — Applied (v1) ◆` tooltip entry after processing, so repeated inventory events, stacking, moving, or transferring an item do not apply the adjustment twice.

## Server / host installation

Turret Dynamics is server-side only. Install it on the multiplayer server or the single-player host. Other players do not need to install it to join and play.

A player needs their own copy only if they want to use Turret Dynamics in their own single-player galaxy or on a server they host.

## Compatibility

Use only one turret-handling mod at a time. Do not enable Turret Dynamics with another mod that changes turret turning speed, tracking speed, or weapon handling.

Turret Dynamics declares these legacy mods as incompatible:

- *Faster turret rotation speed* — Workshop `2022427999` by crazyscientist
- *Freelancer Style Turret Fire Turning Speed* — Workshop `2904033998` by Jack_Bob

Disable or unsubscribe from them before enabling Turret Dynamics. Other mods with overlapping turret-handling features may not be detectable automatically, so they should also remain disabled.

## Credits

Turret Dynamics was inspired by crazyscientist's *Faster turret rotation speed* and Jack_Bob's *Freelancer Style Turret Fire Turning Speed*. This is a clean, standalone implementation built around Player and Alliance acquisition handling; it does not copy or replace either mod.

Part of the Avorian Improved **[AI]** mod suite.
