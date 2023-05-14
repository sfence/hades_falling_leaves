

minetest.register_abm({
    label = "Different leaf decay logic",
    nodenames = {"group:leafdecay2"},
    interval = 2,
    chance = 5,
    action = function(pos, node)
      hades_falling_leaves.leafdecay_action(pos, node)
    end,
  })

minetest.register_abm({
    label = "Leaves life logic",
    nodenames = {"group:leaves_life"},
    interval = 30,
    chance = 54,
    -- ticks per year 30*20*60/30/54*1/3 * 4 = 7.4 * 4 = 29.6 // up four leaves above groud
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local leaves_life_cycle = def._leaves_life_cycle or hades_falling_leaves.leaves_life_cycle
      leaves_life_cycle(pos, node)
    end,
  })

minetest.register_abm({
    label = "Needles life logic",
    nodenames = {"group:needles_life"},
    interval = 33,
    chance = 76,
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local needles_life_cycle = def._needles_life_cycle or hades_falling_leaves.needles_life_cycle
      needles_life_cycle(pos, node)
    end,
  })

minetest.register_abm({
    label = "Leaf scatter logic",
    nodenames = {"group:fallen_leaves"},
    interval = 31,
    chance = 27,
    -- ticks per year 30*20*60/27/31*2/3 = 28.7
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local scatter_fallen_leaves = def._scatter_fallen_leaves or hades_falling_leaves.scatter_fallen_leaves
      scatter_fallen_leaves(pos, node)
    end,
  })

minetest.register_abm({
    label = "Fallen leaves decay",
    nodenames = {"group:fallen_leaves"},
    interval = 27,
    chances = 31,
    -- ticks per year 30*20*60/27/31*2/3 = 28.7
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local decay_fallen_leaves = def._decay_fallen_leaves or hades_falling_leaves.decay_fallen_leaves
      decay_fallen_leaves(pos, node)
    end,
  })

minetest.register_abm({
    label = "Fallen needles decay",
    nodenames = {"group:fallen_needles"},
    interval = 27,
    chances = 31,
    -- ticks per year 30*20*60/27/31*2/3 = 28.7
    action = function(pos, node)
      local def = minetest.registered_nodes[node.name]
      local decay_fallen_needles = def._decay_fallen_needles or hades_falling_needles.decay_fallen_needles
      decay_fallen_needles(pos, node)
    end,
  })

