meta =
{
    id = "3767994828",
    name = "ai_turret_dynamics",
    title = "[AI] Turret Dynamics",
    type = "mod",
    description = [[Turret Dynamics improves the physical traverse speed of newly acquired Player and Alliance turret items, so turrets can align with their targets more responsively without turning this into a broad weapon-stat overhaul.

This mod does not alter enemy or NPC turret items, and it does not change existing turret items already installed or stored in inventory.

Best started in a fresh galaxy. It also works safely in an existing save, but only turrets acquired after enabling the mod receive the adjustment; existing turret items remain unchanged.

What it changes:
- Projectile combat turrets: 2.25x turn speed
- Defensive and combat hitscan turrets: 1.5x turn speed
- Mining and salvaging turrets: 1.75x turn speed
- Repair Beams: 1.75x turn speed and 1.5x range
- Force Guns: unchanged

It does not change damage, fire rate, energy use, projectile velocity, targeting behavior, or range except for Repair Beams. All values are configurable.

Server-side only: Install Turret Dynamics on the multiplayer server or the single-player host. Other players do not need to install it to join and play. A player needs their own copy only to use it in their own single-player galaxy or on a server they host.

Compatibility: Do not enable alongside Faster turret rotation speed (Workshop 2022427999), Freelancer Style Turret Fire Turning Speed (Workshop 2904033998), or any other mod that changes turret turning speed, tracking speed, or weapon handling.

Inspired by crazyscientist's Faster turret rotation speed and Jack_Bob's Freelancer Style Turret Fire Turning Speed. Clean standalone implementation; it does not copy or replace either mod.

Part of the Avorian Improved [AI] mod suite.]],
    authors = {"2G33K4U"},
    version = "0.1.1",
    dependencies = {
        {id = "Avorion", min = "2.5", max = "2.*"},
        {id = "2022427999", incompatible = true},
        {id = "2904033998", incompatible = true}
    },
    serverSideOnly = true,
    clientSideOnly = false,
    saveGameAltering = true,
    contact = ""
}
