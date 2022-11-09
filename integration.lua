
minetest.override_item("hades_core:ash", {
  _fallen_leaves_decay_effect = function(pos, node)
    if node.param2 < 16 then
      node.param2 = node.param2 + 1
      minetest.swap_node(pos, node)
    else
      minetest.set_node(pos, {name="hades_core:volcanic_sand"})
    end
  end,
})

minetest.override_item("hades_core:volcanic_sand", {
  _fallen_leaves_decay_effect = function(pos, node)
    if node.param2 < 128 then
      node.param2 = node.param2 + 1
      minetest.swap_node(pos, node)
    else
      minetest.set_node(pos, {name="hades_core:fertile_sand"})
    end
  end,
})

minetest.override_item("hades_core:clay", {
  _fallen_leaves_decay_effect = function(pos, node)
    if node.param2 < 224 then
      node.param2 = node.param2 + 1
      minetest.swap_node(pos, node)
    else
      minetest.set_node(pos, {name="hades_core:fertile_sand"})
    end
  end,
})

minetest.register_on_mods_loaded(function()
    for name, def in pairs(minetest.registered_nodes) do
      if (minetest.get_item_group(name, "leafdecay")>0)
          and (minetest.get_item_group(name, "leaves")>0) then
        local groups = def.groups
        local leaves_fall_side_limit = groups.ash_fertilizer
        local leaves_fall_limit
        if leaves_fall_side_limit then
          leaves_fall_limit = leaves_fall_side_limit*2
        end
        groups.ash_fertilizer = nil
        groups.leafdecay = nil
        groups.leafdecay2 = 1
        local leaves_falling = def._leaves_falling or 1
        minetest.override_item(name, {
            groups = groups,
            _leaves_fall_limit = leaves_fall_limit,
            _leaves_fall_side_limit = leaves_fall_side_limit,
            _leaves_falling = leaves_falling
          })
      end
    end
  end)

