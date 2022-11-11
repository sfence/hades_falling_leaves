
minetest.log("action", "[MOD] Falling leaves loading...")

hades_falling_leaves = {
  translator = minetest.get_translator("hades_falling_leaves")
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/nodes.lua")

dofile(modpath.."/fallen_decay.lua")
dofile(modpath.."/leaves_life.lua")
dofile(modpath.."/needles_life.lua")
dofile(modpath.."/leafdecay.lua")

dofile(modpath.."/abms.lua")

dofile(modpath.."/integration.lua")

--dofile(modpath.."/crafting.lua")

minetest.log("action", "[MOD] Falling leaves loaded.")

