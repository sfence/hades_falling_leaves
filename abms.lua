
minetest.register_abm({
    label = "Different leaf decay logic",
    nodenames = {"group:leafdecay2"},
    --interval = 67,
    interval = 1,
    chance = 67,
    action = function(pos, node)
      hades_falling_leaves.leaves_life_cycle(pos, node)
    end,
  })

minetest.register_abm({
    label = "Falling leaves logic",
    nodenames = {"group:falling_leaves"},
    interval = 67,
    chance = 67,
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local leaves_life_cycle = def._leaves_life_cycle or hades_falling_leaves.leaves_life_cycle
      leaves_life_cycle(pos, node)
    end,
  })

minetest.register_abm({
    label = "Falling needles logic",
    nodenames = {"group:falling_needles"},
    interval = 67,
    chance = 67,
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local needles_life_cycle = def._needles_life_cycle or hades_falling_leaves.needles_life_cycle
      needles_life_cycle(pos, node)
    end,
  })

minetest.register_abm({
    label = "Fallen leaves decay",
    nodenames = {"group:fallen_leaves"},
    --interval = 87,
    interval = 1,
    chances = 133,
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local decay_fallen_leaves = def._decay_fallen_leaves or hades_falling_leaves.decay_fallen_leaves
      decay_fallen_leaves(pos, node)
    end,
  })

