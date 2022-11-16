
-- logic for decay fallen leaves / needles

function hades_falling_leaves.decay_fallen_leaves(pos, node)
  local season_coef = 16
  local season = hades_seasons.get_season()
  if (season~=hades_seasons.SUMMER) then
    season_coef = 8
  end
  -- do decay
  local effect = 0
  if (node.param2>0) then
    effect = math.max(1, math.ceil(node.param2/season_coef))
    node.param2 = math.max(0, node.param2 - effect)
  end
  if (node.param2>0) then
    minetest.swap_node(pos, node)
  else
    local def = minetest.registered_nodes[node.name]
    minetest.set_node(pos, {name=def._decay_to or "air"})
  end

  pos.y = pos.y - 1
  local under = minetest.get_node(pos)
  local def = minetest.registered_nodes[under.name]
  
  if (effect>0) and def._fallen_leaves_decay_effect then
    def._fallen_leaves_decay_effect(pos, under, effect)
  end
end

