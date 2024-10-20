Allows for displaying cooldowns on the HUD.  
(Automatically adds Time Keeper's Secret's cooldown.)  

![image](https://github.com/user-attachments/assets/b0c5e189-05b3-48a2-ab57-0cc0d68b1e52)

Import line:  
```lua
Cooldown = mods["Klehrik-CooldownHelper"].setup()

```

---

### Functions

```lua
Cooldown.set(inst, id, duration, [icon], [color]) -> nil
```

Adds a cooldown to the instance.  
Overrides the existing cooldown if the ID is already in use.  

**Parameters:**  
| **Parameter** | **Type** | **Description** |
| ------------- | -------- | --------------- |
| `inst`        | CInstance or Instance object | The instance to set the cooldown for. |
| `id`          | string  | The identifier for the cooldown. |
| `duration`    | number  | The maximum time for the cooldown (in frames). |
| `[icon]`      | sprite  | _Player HUD:_ The icon to display on the cooldown visual. |
| `[color]`     | color   | _Player HUD:_ The color to use for the cooldown visual. |

<br>

```lua
Cooldown.get(inst, id) -> number, number, sprite, color
```

Returns information about a cooldown as unpacked values.  
`remaining time`, `maximum time`, `icon sprite`, `color`  

**Parameters:**  
| **Parameter** | **Type** | **Description** |
| ------------- | -------- | --------------- |
| `inst`        | CInstance or Instance object | The instance to get the cooldown from. |
| `id`          | string  | The identifier for the cooldown. |

---

### Installation Instructions
Follow the instructions [listed here](https://docs.google.com/document/d/1NgLwb8noRLvlV9keNc_GF2aVzjARvUjpND2rxFgxyfw/edit?usp=sharing).  
Join the [Return of Modding server](https://discord.gg/VjS57cszMq) for support.  