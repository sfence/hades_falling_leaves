
local S = hades_falling_leaves.translator

local decay_to = "air"
for i = 1,4 do
  local leaves_next = "hades_falling_leaves:fall_leaves_"..(i+1)
  if i==4 then
    leaves_next = "hades_falling_leaves:leaf_pile"
  end
  minetest.register_node("hades_falling_leaves:fall_leaves_"..i, {
    description = S("Fallen leaves"),
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "color",
    tiles = {"hades_falling_leaves_fall_leaves_"..i..".png"},
    buildable_to = true,
    drop = "",
    groups = {oddly_breakable_by_hand = 1, flammable = 2, attached_node =     1, fallen_leaves = 1},
    node_box = {
      type = "fixed",
      fixed = {-0.5,-0.5,-0.5, 0.5,-0.49,0.5},
    },
    _decay_to = decay_to,
    _leaves_next = leaves_next,
  })
  decay_to = "hades_falling_leaves:fall_leaves_"..i
end
minetest.register_node("hades_falling_leaves:leaf_pile", {
  description = S("Fallen leaves"),
  paramtype = "light",
  paramtype2 = "leveled",
  tiles = {"hades_falling_leaves_leaf_pile.png"},
  drawtype = "nodebox",
  node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
  leveled = 1,
  leveled_max = 64,
  groups = {oddly_breakable_by_hand = 1, flammable = 2, attached_node =     1, fallen_leaves = 1},
  
  floodable = true,
  
  _decay_to = decay_to,
  _leaves_next = true,
})

decay_to = "air"
for i = 1,4 do
  local needles_next = "hades_falling_leaves:fall_needles_"..(i+1)
  if i==4 then
    needles_next = "hades_falling_leaves:needles_pile"
  end
  minetest.register_node("hades_falling_leaves:fall_needles_"..i, {
    description = S("Fallen Needles"),
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "color",
    tiles = {"hades_falling_leaves_fall_needles_"..i..".png"},
    buildable_to = true,
    groups = {oddly_breakable_by_hand = 1, flammable = 2, attached_node =     1, fallen_needles = 1},
    node_box = {
      type = "fixed",
      fixed = {-0.5,-0.5,-0.5, 0.5,-0.49,0.5},
    },
    drop ="",

    _decay_to = decay_to,
    _needles_next = needles_next,
  })
  decay_to = "hades_falling_leaves:fall_needles_"..i
end
minetest.register_node("hades_falling_leaves:needles_pile", {
  description = S("Fallen Needles"),
  drawtype = "leveled",
  paramtype = "light",
  paramtype2 = "level",
  tiles = {"hades_falling_leaves_needles_pile.png"},
  leveled_max = 64,
  groups = {oddly_breakable_by_hand = 1, flammable = 2, attached_node =     1, fallen_needles = 1},

  _decay_to = decay_to,
  _needles_next = true,
})

