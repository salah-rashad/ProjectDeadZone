## 🎯 High‑Level Goals

| # | Goal                              | Success Criteria                                                                                                 |
| - | --------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 1 | **Functional Base‑Building Loop** | Player can queue buildings/ upgrades via custom GUI; resources deducted, timers run, and objects spawn in‑world. |
| 2 | **Survivor Management & Classes** | Roster UI shows leader + recruits with class icons, health, morale, skills; player can assign tasks/positions.   |
| 3 | **Mission System**                | Player selects a zone, loads into it with chosen survivors, plays real‑time, returns with loot & XP.             |
| 4 | **Horde Defense Events**          | Timed attacks hit the compound; survivors auto‑move to assigned spots; victory/defeat logic fires.               |
| 5 | **Economy & Progression**         | Balanced flow of materials, food, XP; new survivors arrive only if beds + food thresholds met.                   |
| 6 | **Custom UI & Map Assets**        | All core screens (build queue, roster, mission planner) and at least one bespoke compound map.                   |
| 7 | **Polish & Release Package**      | Stable SP gameplay ≥30 min, no Lua errors, Steam Workshop page with screenshots & icon.                          |

---

## 🗺️ Phase‑by‑Phase Task Breakdown

### Phase 0 Setup & Foundations

1. **Repo & Build Pipeline**

   * Git repo with clear folder structure (`media/lua`, `media/ui`, `maps/…`)
   * Pre‑commit hook: LuaCheck + formatter.
2. **Core Data Schemas**

   * `BuildingDef`, `SurvivorClass`, `MissionTemplate` Lua tables.
   * Global save table attached to `ModData`.
3. **Base Object & Event Bus**

   * Singleton `DZ_Core` handling tick updates, scheduled events, and global state.

---

### Phase 1 Base‑Building MVP

1. **GUI Build Menu** (simple list) → choose structure → deduct resources → start timer.
2. **World Placement**

   * On completion, spawn a placeholder IsoObject at predefined coordinates.
3. **Resource System v1**

   * Two resources only (Materials, Food) stored on `DZ_Core`.

⏩ *Exit criteria*: Player can build Bed & Watchtower, see the model appear, and resources hit zero.

---

### Phase 2 Survivor System

1. **Class Definition & Spawn Logic**

   * Lua table for 6 classes, each with stat modifiers & allowed weapons.
   * Recruit event fires when `beds > survivors` **and** `food > (survivors×X)`.
2. **Roster Screen**

   * Scrollable panel: portrait, HP bar, morale bar, class icon, gear slot.
3. **Task Assignment Stub**

   * Right‑click → “Assign to: Guard / Engineer / Scavenge / Idle”.

---

### Phase 3 Mission Gameplay

1. **Mission Planner UI** (select template, add survivors, launch).
2. **Zone Loading**

   * Use vanilla cell changing; teleport team to mission map chunk.
3. **Extraction & Reward**

   * On exit trigger, record loot, award XP, heal calculation, return to base.

---

### Phase 4 Horde Defense Events

1. **Timer & Difficulty Curve**

   * Gametime event every N hours; zombies count scales with days survived + noise.
2. **Position Assignment**

   * Pre‑define guard nodes; survivors auto‑walk there when event starts.
3. **Wave Spawner**

   * Spawn groups outside walls; path toward compound; event ends when clear.

---

### Phase 5 Economy & UX Polish

1. **Resources v2** (Ammo, Medicine, Parts).
2. **Build Queue UI** (progress bars, cancel button).
3. **Notification System** (toasts: “Watchtower complete”, “Horde in 1 h”).
4. **Balancing Pass** (material costs, wave sizes, heal times).

---

### Phase 6 Art, Map, & Final QA

1. **Custom Compound Map** (WorldEd or TileZed).
2. **UI Skinning** (custom fonts, icons, grey‑orange palette).
3. **Sound Hooks** (build complete, survivor hurt, horde siren).
4. **Play‑Test Sessions**

   * 1 h survival run, fix crashes & soft‑locks.
5. **Steam Workshop Packaging**

   * `descriptor.txt`, preview image, changelog, tags.

---

## ⚙️ Technical To‑Dos (Cross‑Cutting)

* Write **Lua utility library** for timers, event dispatch, and save serialization.
* Leverage **ISPanel** derivatives for UI; wrap in your own `DZ_UI` module.
* Provide **mod options** UI (horde frequency, resource abundance).
* Implement **debug commands** (`/dz resources +100`, `/dz next_horde`) to speed up testing.
* Document public hooks early—future contributors will thank you.

---

## Possible Future Expansions (Parked)

* Multiplayer co‑op base defense.
* Faction diplomacy & NPC raiders.
* Procedural compound layouts.
* Automated scavenging missions with text outcomes.
