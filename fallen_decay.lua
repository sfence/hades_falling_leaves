
-- logic for decay fallen leaves / needles

function hades_falling_leaves.decay_fallen_leaves(pos node)
  local season = hades_seasons.get_season()
  if (season~=hades_seasons.SUMMER) then
    -- do decay
    if (node.param2>0) then
      node.param2 = node.param2 - 1
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
    
    if def._fallen_leaves_decay_effect then
      def._fallen_leaves_decay_effect(pos, under)
    end
  end
end

