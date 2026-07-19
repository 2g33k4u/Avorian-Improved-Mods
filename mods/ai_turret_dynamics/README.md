# [AI] Turret Dynamics — local test build

This standalone server-side mod adjusts only newly acquired Player and Alliance `InventoryItemType.Turret` items. It does not override `turretgenerator.lua`, change existing inventory items, or modify NPC/enemy turrets.

## When to enable it

Turret Dynamics is best started in a fresh galaxy. It also works safely in an existing save, but only turrets acquired after enabling the mod receive the adjustment; all existing turret items remain unchanged.

## Defaults

| Weapon category | Turn multiplier | Range multiplier |
| --- | ---: | ---: |
| Projectile combat | 2.25x | 1.0x |
| Defensive weapons | 1.5x | 1.0x |
| Combat hitscan | 1.5x | 1.0x |
| Mining | 1.75x | 1.0x |
| Salvaging | 1.75x | 1.0x |
| Repair Beam | 1.75x | 1.5x |
| Force Gun | unchanged | unchanged |

## Server / host installation

Turret Dynamics is server-side only. Install it on the multiplayer server or the single-player host. Other players do not need to install it to join and play.

A player needs their own copy only if they want to use Turret Dynamics in their own single-player galaxy or on a server they host.

## Compatibility

Turret Dynamics is a standalone turret-handling mod. Use only one mod that changes turret turning speed, tracking speed, or weapon handling at a time.

Do not enable Turret Dynamics alongside either of these legacy turret-turning mods:

- *Faster turret rotation speed* — Workshop `2022427999` by crazyscientist
- *Freelancer Style Turret Fire Turning Speed* — Workshop `2904033998` by Jack_Bob

Those two Workshop IDs are declared incompatible in `modinfo.lua`, so Avorion can flag the conflict when both are installed. Other mods with similar turret-handling features may not be detectable automatically; disable them before enabling Turret Dynamics.

## Safety and idempotency

The mod changes only `turningSpeed` and, for Repair Beams, uses Avorion's `setRange` API. Because inventory callbacks provide an editable item value rather than a persistent inventory reference, the mod safely removes and re-inserts only the newly added complete turret item after tuning it. It records a persistent tooltip entry, `◆ [AI] TURRET DYNAMICS — Applied (v1) ◆`, after a successful adjustment. The marker prevents repeat inventory events, transfers, and stacking from applying the multiplier again.

Turret blueprints (`InventoryItemType.TurretTemplate`) are intentionally out of scope for v1. Existing turret items are never scanned or migrated.

## Disposable-galaxy test checklist

1. Create a new disposable galaxy and enable this mod.
2. Confirm *Faster turret rotation speed* and *Freelancer Style Turret Fire Turning Speed* are disabled or unsubscribed. Also disable any other mod that changes turret turning speed, tracking speed, or weapon handling.
3. Acquire one Player turret from each listed category and record its displayed stats before and after receipt.
4. Repeat with an Alliance inventory.
5. Confirm only the specified turn speed changes, Repair Beam range is exactly 1.5x, and Force Guns remain unchanged.
6. Confirm damage, fire rate, energy use, projectile speed, and other weapon ranges remain unchanged.
7. Move, stack, and transfer a processed turret; confirm its marker remains and its values do not change again.
8. Generate/acquire an enemy turret and confirm it remains vanilla.

Do not use this test build on a real save until the checklist passes and a dated backup has been approved.

Part of the Avorian Improved **[AI]** mod suite.
