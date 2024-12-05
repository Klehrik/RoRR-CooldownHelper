-- CooldownHelper
-- Klehrik

log.info("Successfully loaded ".._ENV["!guid"]..".")

local envy = mods["MGReturns-ENVY"]
envy.auto()
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

require("./cooldown")



-- ========== ENVY Setup ==========

function public.setup(env)
    if env == nil then
        env = envy.getfenv(2)
    end
    local wrapper = {}
    for k, v in pairs(Cooldown) do
        wrapper[k] = v
    end
    return wrapper
end



-- ========== Initialize ==========

Initialize(function()
    -- Add timer for Timekeeper's Secret
    local spriteCooldown = Resources.sprite_load("cooldownHelper", "cooldown/timeKeepersSecret", _ENV["!plugins_mod_folder_path"].."/timeKeepersSecret.png", 1, 4, 4)

    Item.find("ror-timeKeepersSecret"):onAcquire(function(actor, stack)
        -- Remove cooldown
        Cooldown.set(actor, "cooldownHelper-timeKeepersSecret", 0)
    end)

    Item.find("ror-timeKeepersSecretUsed"):onAcquire(function(actor, stack)
        -- Add cooldown
        Cooldown.set(actor, "cooldownHelper-timeKeepersSecret", 7 *60 *60, spriteCooldown, Color(0x826ec3))
    end)
end)