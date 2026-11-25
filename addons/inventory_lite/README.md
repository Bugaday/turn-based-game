# Inventory (Lite)

**FREE.** Single-container item inventory for Godot 4.5+. Pure GDScript. MIT.

The working core of the [selodev Inventory addon](docs/upgrade.md). A bag on your player, items lying in the level that go into it when the player walks over them, and a plain list of the bag on the I key. Items are `ItemLite` Resources. Stacks merge by id, respect `max_stack`, and a full bag leaves the item where it lies.

> **No-code docks.** Enable the plugin and two tabs appear. **Inventory · Setup** puts things in your scene. **Items (Lite)** creates, edits, duplicates and deletes your items, with no `.tres` editing.

## One-click setup (no code)

Enable the plugin and an **Inventory · Setup** tab appears in the editor.

1. Select your player node, pick **Player inventory** and press **Apply**. The player gets a bag and is marked as the player, and a bag list goes in the bottom-left corner of the screen. It starts hidden. Press **I** in game to open it.
2. Select something lying on the ground (a sprite, a mesh or an Area2D/Area3D), pick **A pickup**, choose the item (or press **New item**), set the amount and press **Apply**. A node that isn't an area gets a **PickupArea** to be touched through.
3. Press Play and walk into it. The item goes into the bag, "+1 Apple" shows at the top of the screen, and the pickup disappears. A full bag says "Bag is full" and leaves it there.

Your player needs a collision shape so it can touch things (a CharacterBody2D or CharacterBody3D with a CollisionShape, the usual setup). If nothing in the scene is the player yet, the tab says so, and its **Make the selected node the player** button fixes it.

## 5-minute install

1. Copy `addons/inventory_lite/` into your project's `addons/` folder.
2. Project → Project Settings → Plugins → enable **Inventory (Lite)**.
3. Follow the three steps above. [docs/quick-start.md](docs/quick-start.md) has the details.

From code (optional):

```gdscript
var leftover := inventory.add_item(apple_resource, 5)  # returns what didn't fit
inventory.has_item(sword_resource)                     # bool
inventory.count_item(potion_resource)                  # int
inventory.snapshot()                                   # for custom save systems
```

## What's missing (and why)

| Feature | Tier |
|---|---|
| Styled `InventoryUI` grid with icons (Lite's list is plain text) | Pro |
| Drag-and-drop slots | Pro |
| `HotbarUI` | Pro |
| Per-item tooltips | Pro |
| Chests that open on touch, with their own panel | Pro |
| Weight limits + category gating | Pro |
| `InventoryTheme` Resource (colors, rarity tints) | Pro |
| Save-contract auto-join | Pro |
| Shared `Events` autoload (cross-system integration) | Pro |

See [docs/upgrade.md](docs/upgrade.md).

## License

MIT.


## Part of a family

This is one free tier from the selodev catalog of no-code Godot 4 systems. They share an item contract and a save contract, so they plug into each other, and each one also works fully on its own.

Free systems:

- [Inventory Lite](https://github.com/seloc0des/godot-inventory-lite)
- [Equipment Lite](https://github.com/seloc0des/godot-equipment-lite)
- [Loot Lite](https://github.com/seloc0des/godot-loot-lite)
- [Crafting Lite](https://github.com/seloc0des/godot-crafting-lite)
- [Vendor Lite](https://github.com/seloc0des/godot-vendor-lite)
- [Quests Lite](https://github.com/seloc0des/godot-quests-lite)
- [Stats / Skills Lite](https://github.com/seloc0des/godot-stats-skills-lite)
- [Save / Load Lite](https://github.com/seloc0des/godot-save-load-lite)
- [Dialogue Lite](https://github.com/seloc0des/godot-dialogue-lite)
- [Combat Lite](https://github.com/seloc0des/godot-combat-lite)
- [Controller Lite](https://github.com/seloc0des/godot-controller-lite)
- [Enemy AI Lite](https://github.com/seloc0des/godot-enemy-ai-lite)
- [Scene Flow Lite](https://github.com/seloc0des/godot-scene-flow-lite)
- [Audio Lite](https://github.com/seloc0des/godot-audio-lite)
- [Level Builder Lite](https://github.com/seloc0des/godot-level-builder-lite)
- [Weather System Lite](https://github.com/seloc0des/godot-weather-lite)
- [Settings + Menus](https://github.com/seloc0des/godot-settings-menus) (complete and free, no paid tier)

Free VFX: [Magic Cast](https://github.com/seloc0des/godot-magic-cast-vfx-lite), [Elemental Impact](https://github.com/seloc0des/godot-elemental-impact-vfx-lite), [Explosion](https://github.com/seloc0des/godot-explosion-vfx-lite), [Pickup, Buff & Heal](https://github.com/seloc0des/godot-pickup-buff-vfx-lite).

Free starter projects: [Free Starter](https://github.com/seloc0des/free-starter-godot), [Dungeon](https://github.com/seloc0des/godot-dungeon-starter), [Survival](https://github.com/seloc0des/godot-survival-starter), [RPG](https://github.com/seloc0des/godot-rpg-starter).

The full versions add drop-in UI, editor docks and the cross-system wiring. They're on itch.io: **https://selodev.itch.io**
