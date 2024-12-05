-- Cooldown

Cooldown = Proxy.new()

local section_count = 60
local section_size = 360 / section_count
local radius = 8
local x_spacing = 19



-- ========== Static Methods ==========

Cooldown.set = function(inst, id, duration, icon, color)
    inst = Wrap.wrap(inst)

    if not Instance.exists(inst.value) then log.error("Instance does not exist", 2) end
    if not id then log.error("ID unspecified", 2) end
    if not duration then log.error("Duration unspecified", 2) end

    local instData = inst:get_data()
    instData[id] = {duration, duration}
    if icon then instData[id][3] = icon end
    if color then instData[id][4] = color end

    local instDataOrder = inst:get_data("order")
    if not Helper.table_has(instDataOrder, id) then
        table.insert(instDataOrder, id)
    end

    if not inst:callback_exists("cooldownHelper-cooldownTick") then
        inst:onPreStep("cooldownHelper-cooldownTick", function(inst)
            local instData = inst:get_data()
            for k, v in pairs(instData) do
                instData[k][1] = v[1] - 1
                if v[1] <= 0 then
                    instData[k] = nil
                    Helper.table_remove(instDataOrder, k)
                end
            end
        end)
    end
end


Cooldown.get = function(inst, id)
    inst = Wrap.wrap(inst)

    if not Instance.exists(inst.value) then log.error("Instance does not exist", 2) end
    if not id then log.error("ID unspecified", 2) end

    local instData = inst:get_data()
    if not instData[id] then return 0 end
    return table.unpack(instData[id])
end



-- ========== Internal ==========

Callback.add("onPlayerHUDDraw", "cooldownHelper-playerCooldownDisplay", function(self, other, result, args)
    local p = Player.get_client()
    if not p:exists() then return end
    local pData = p:get_data()
    local pDataOrder = p:get_data("order")

    local x, y = args[3].value + 8, args[4].value - 13

    gm.draw_set_color(Color.WHITE)

    local _x = x
    for _, id in ipairs(pDataOrder) do
        local v = pData[id]
        if v then
            gm.draw_set_alpha(0.8)
            if v[4] then gm.draw_set_color(v[4]) end
            gm.draw_primitive_begin(6)  -- trianglefan
            gm.draw_vertex(_x, y)
            local ratio = math.floor((v[1] / v[2]) * section_count)
            for i = 0, ratio do
                local angle = (i * section_size) + 90
                local tx, ty = gm.dcos(angle) * radius, -gm.dsin(angle) * radius
                gm.draw_vertex(_x + tx, y + ty)
            end
            gm.draw_primitive_end()
            gm.draw_set_alpha(1)
            gm.draw_set_color(Color.WHITE)
            if v[3] then gm.draw_sprite(v[3], 0, _x, y) end
            _x = _x + x_spacing
        end
    end
end)



return Cooldown:lock()