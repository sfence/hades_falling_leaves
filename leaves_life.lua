
-- living cycle of leaves
-- based on Hades season

function hades_falling_leaves.leaves_fall(pos, node, def, falling)
  local side_limit = def._leaves_fall_side_limit
  if not side_limit then
    minetest.log("error", "[hades_falling_leaves] Leaves life cycle operation on "..node.name)
  end
  local above = vector.add(pos, vector.new(math.random(-side_limit,side_limit),0,math.random(-side_limit,side_limit)))
  local ground = vector.copy(above)
  ground.y = ground.y - 1
  local a_node
  local g_node = minetest.get_node(ground)
  local g_def
  for n=1,def._leaves_fall_limit do
    above.y = above.y - 1
    ground.y = ground.y - 1
    a_node = g_node
    g_node = minetest.get_node(ground)
    g_def = minetest.registered_nodes[g_node.name]
    if (minetest.get_item_group(g_node.name, "leafdecay2")==0) 
        and (minetest.get_item_group(g_node.name, "vines")==0) then
      if (g_def and (g_def.walkable or g_def._leaves_next)) then
        if g_def._leaves_next then
          if g_def._leaves_next==true then
            if g_node.param2<64 then
              g_node.param2 = math.min(64, g_node.param2 + falling)
              minetest.swap_node(ground, g_node)
            end
          else
            minetest.set_node(ground, {name=g_def._leaves_next})
          end
        elseif (a_node.name=="air") or (minetest.get_item_group(a_node.name, "vines")>0) then
          minetest.set_node(above, {name="hades_falling_leaves:fall_leaves_"..math.min(4, falling)})
        end
      end
    end  
  end
end

function hades_falling_leaves.leaves_life_cycle(pos, node)
  if node.param2~=0 then
    return
  end
  local def = minetest.registered_nodes[node.name]
  
  local season = hades_seasons.get_season()
  
  local falling = def._leaves_falling or 0
  if def._season_falling then
    falling = def._season_falling[season] or 0
  end
  
  if def._season_leaves and def._season_leaves[season] then
    node.name = def._leaves_season[season]
    minetest.set_node(pos, node)
    
    def = minetest.registered_nodes[node.name]
    falling = falling + (def._leaves_falling or 0) + (def._leaves_falling_change or 0)
  end
  
  if falling>0 then
    hades_falling_leaves.leaves_fall(pos, node, def, falling)
  end
end

