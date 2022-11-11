--
-- Leafdecay
--

-- To enable leaf decay for a node, add it to the "leafdecay" group.
--
-- The rating of the group determines how far from a node in the group "tree=1"
-- the node can be without decaying.
--
-- If param2 of the node is ~= 0, the node will always be preserved. Thus, if
-- the player places a node of that kind, you will want to set param2=1 or so.
--
-- If the node is in the leafdecay_drop group then the it will always be dropped
-- as an item


local function leafdecay_particles(pos, node)
	minetest.add_particlespawner({
		amount = math.random(10, 20),
		time = 0.1,
		minpos = vector.add(pos, {x=-0.4, y=-0.4, z=-0.4}),
		maxpos = vector.add(pos, {x=0.4, y=0.4, z=0.4}),
		minvel = {x=-0.2, y=-0.2, z=-0.2},
		maxvel = {x=0.2, y=0.1, z=0.2},
		minacc = {x=0, y=-9.81, z=0},
		maxacc = {x=0, y=-9.81, z=0},
		minexptime = 0.1,
		maxexptime = 0.5,
		minsize = 0.5,
		maxsize = 1.5,
		collisiondetection = true,
		vertical = false,
		node = node,
	})
end

function hades_falling_leaves.leafdecay_action(p0, node)
  minetest.log("verbose", "[hades_falling_leaves] leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
  local do_preserve = false
  local def = minetest.registered_nodes[node.name]
  local d = def.groups.leafdecay2
  if not d or d == 0 then
    minetest.log("verbose", "[hades_falling_leaves] not groups.leafdecay2")
    return
  end
  local n0 = minetest.get_node(p0)
  if n0.param2 ~= 0 then
    -- Prevent decay
    return
  end
  local trunk_to_check = def._hades_trees_trunk
  local any = def.groups.leafdecay_any == 1
  local p0_hash = nil
  if hades_trees.leafdecay_enable_cache then
    p0_hash = minetest.hash_node_position(p0)
    local trunkp = hades_trees.leafdecay_trunk_cache[p0_hash]
    if trunkp then
      local n = minetest.get_node(trunkp)
      -- Assume ignore is a trunk, to make the thing work at the border of the active area
      if (n.name == "ignore") or (any and minetest.get_item_group(n.name, "tree") ~= 0) or (n.name == trunk_to_check) then
        minetest.log("verbose", "[hades_falling_leaves] leafdecay: cached trunk still exists")
        return
      end
      minetest.log("verbose", "[hades_falling_leaves] leafdecay: cached trunk is invalid")
      -- Cache is invalid
      table.remove(hades_trees.leafdecay_trunk_cache, p0_hash)
    end
  end
  if hades_trees.leafdecay_trunk_find_allow_accumulator <= 0 then
    return
  end
  hades_trees.leafdecay_trunk_find_allow_accumulator =
      hades_trees.leafdecay_trunk_find_allow_accumulator - 1
  -- Assume ignore is a trunk, to make the thing work at the border of the active area
  local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
  if p1 then
    local n1 = minetest.get_node(p1)
    if (n1.name == "ignore") or (any and minetest.get_item_group(n1.name, "tree") ~= 0) or (n1.name == trunk_to_check) then
      do_preserve = true
      if hades_trees.leafdecay_enable_cache then
        minetest.log("verbose", "[hades_falling_leaves] leafdecay: caching trunk")
        -- Cache the trunk
        hades_trees.leafdecay_trunk_cache[p0_hash] = p1
      end
    end
  end
  if not do_preserve then
    -- Drop stuff other than the node itself
    local itemstacks = minetest.get_node_drops(n0.name)
    local drop_items = false
    for _, itemname in ipairs(itemstacks) do
      if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0 or
          itemname ~= n0.name then
        local p_drop = {
          x = p0.x - 0.5 + math.random(),
          y = p0.y - 0.5 + math.random(),
          z = p0.z - 0.5 + math.random(),
        }
        drop_items = true
        minetest.add_item(p_drop, itemname)
      end
    end
    -- Remove node
    minetest.remove_node(p0)
    if not drop_items then
      leafdecay_particles(p0, n0)
      -- do fall leaves here
      if def._leafdecay_posteffect then
        def._leafdecay_posteffect(p0, n0, def, def._leafdecay_falling or 1)
      end
    end
    minetest.check_for_falling(p0)
  end
end

