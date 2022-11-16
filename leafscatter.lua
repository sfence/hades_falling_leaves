
local offsets = {
    vector.new(1,0,0),
    vector.new(-1,0,0),
    vector.new(0,0,1),
    vector.new(0,0,-1),
  }

local y_off = vector.new(0,-1,0)

function hades_falling_leaves.scatter_fallen_leaves(pos, node)
  local steepness = 8 + 2*(15-minetest.get_natural_light(pos, 0.5))
  for _,offset in pairs(offsets) do
    local side_pos = vector.add(pos, offset)
    local side_node = minetest.get_node(side_pos)
    if side_node.name==node.name then
      if node.param2>(side_node.param2+steepness) then
        side_node.param2 = side_node.param2 + 1
        minetest.swap_node(side_pos, side_node)
        node.param2 = node.param2 - 1
      end
    elseif minetest.get_item_group(side_node.name, "fallen_leaves")~=0 then
      if node.param2>steepness then
        minetest.swap_node(side_pos, {name=node.name, param2 = 1})
        node.param2 = node.param2 - 1
      end
    elseif side_node.name=="air" then
      local under_pos
      local under_node
      for y = 1,6 do
        under_pos = vector.add(side_pos, y_off)
        under_node = minetest.get_node(under_pos)
        if under_node.name~="air" then
          break
        end
        side_pos = under_pos
        side_node = under_node
      end
      if under_node.name=="air" then
      elseif side_node.name==node.name then
        if node.param2>(side_node.param2+steepness) then
          side_node.param2 = side_node.param2 + 1
          minetest.swap_node(side_pos, side_node)
          node.param2 = node.param2 - 1
        end
      elseif minetest.get_item_group(side_node.name, "fallen_leaves")~=0 then
        if node.param2>steepness then
          minetest.swap_node(side_pos, {name=node.name, param2 = 1})
          node.param2 = node.param2 - 1
        end
      elseif side_node.name=="air" then
        if node.param2>(steepness/2) then
          minetest.set_node(side_pos, {name="hades_falling_leaves:fall_leaves_"..math.random(1,4)})
          node.param2 = node.param2 - 1
        end
      end
    end
  end
end

