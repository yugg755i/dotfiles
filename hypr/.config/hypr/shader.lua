-- shader.lua
-- Shader manager for Hyprland

local home = os.getenv("HOME") or "/home/yugg755"
local shader_dir = home .. "/.config/hypr/shaders/"

local M = {}

M.current_shader = nil
M.active_mode = nil

M.defaults = {
	rounding = 0,
	gaps_in = 3,
	gaps_out = 5,
	border_size = 1,
	animations = true,
	shadow = false,
	blur = true,
	dim_inactive = true,
	dim_strength = 0.08,
	dim_around = 0.6,
	damage_tracking = 2,
}

local function restore_defaults()
	hl.config({
		general = {
			gaps_in = M.defaults.gaps_in,
			gaps_out = M.defaults.gaps_out,
			border_size = M.defaults.border_size,
		},
		decoration = {
			rounding = M.defaults.rounding,
			active_opacity = 0.92,
			inactive_opacity = 0.88,
			dim_inactive = M.defaults.dim_inactive,
			dim_strength = M.defaults.dim_strength,
			dim_around = M.defaults.dim_around,
			shadow = { enabled = M.defaults.shadow },
			blur = { enabled = M.defaults.blur },
		},
		animations = { enabled = M.defaults.animations },
		debug = { damage_tracking = M.defaults.damage_tracking },
	})
	hl.config({ decoration = { screen_shader = "" } })
end

-- Simple one-liner shaders (no side effects)
M.simple_shaders = {
	["Outdoor"] = "outdoor.glsl",
	["Cinema"] = "cinema.glsl",
	["Fuji Acros"] = "fuji_acros.glsl",
}

-- Complex modes with activate/deactivate hooks
M.complex_modes = {

	["Reading Mode"] = {
		shader = "reading_mode_minimal.glsl",

		activate = function(shader_path)
			hl.config({
				general = {
					gaps_in = 0,
					gaps_out = 0,
					border_size = 1,
				},
				decoration = {
					rounding = 0,
					active_opacity = 1.0,
					inactive_opacity = 1.0,
					dim_inactive = false,
					shadow = { enabled = false },
					blur = { enabled = false },
				},
				animations = { enabled = false },
			})
			hl.config({ decoration = { screen_shader = shader_path } })
			hl.exec_cmd("awww img " .. home .. "/Pictures/Wallpapers/bkg1.png --transition-type none")
		end,

		deactivate = function()
			hl.exec_cmd("awww img " .. home .. "/.config/hypr/current_wallpaper --transition-type none")
			restore_defaults()
		end,
	},

	["Night Light"] = {
		shader = "night.glsl",

		activate = function(shader_path)
			hl.exec_cmd("brightnessctl set 37%")
			hl.config({ decoration = { screen_shader = shader_path } })
		end,

		deactivate = function()
			hl.exec_cmd("brightnessctl set 57%")
			restore_defaults()
		end,
	},

	["CRT Mode"] = {
		shader = "crt_mode.glsl",

		activate = function(shader_path)
			hl.exec_cmd("awww img " .. home .. "/Pictures/retro/van.png --transition-type wipe")
			hl.config({
				general = {
					gaps_in = 0,
					gaps_out = 0,
					border_size = 3,
				},
				decoration = {
					rounding = 0,
					dim_around = 0,
					shadow = { enabled = false },
					blur = { enabled = false },
				},
				animations = { enabled = false },
				debug = { damage_tracking = 0 },
			})
			hl.config({ decoration = { screen_shader = shader_path } })
		end,

		deactivate = function()
			restore_defaults()
		end,
	},
}

function M.turn_off_all()
	if M.active_mode then
		M.complex_modes[M.active_mode].deactivate()
		M.active_mode = nil
	end
	M.current_shader = nil
	hl.config({ decoration = { screen_shader = "" } })
end

function M.toggle(name)
	if name == "Turn Off All" then
		M.turn_off_all()
		return
	end

	-- toggle off if already active
	if M.current_shader == name then
		M.turn_off_all()
		return
	end

	-- deactivate previous complex mode if switching
	if M.active_mode and M.active_mode ~= name then
		M.complex_modes[M.active_mode].deactivate()
		M.active_mode = nil
		M.current_shader = nil
	end

	if M.complex_modes[name] then
		M.active_mode = name
		M.current_shader = name
		M.complex_modes[name].activate(shader_dir .. M.complex_modes[name].shader)
		return
	end

	if M.simple_shaders[name] then
		M.current_shader = name
		hl.config({ decoration = { screen_shader = shader_dir .. M.simple_shaders[name] } })
		return
	end
end

--------------------
---- KEYBINDS ----
--------------------
local mod = "SUPER"
local alt = "ALT"

hl.bind(mod .. " + D", function()
	M.toggle("Reading Mode")
end, { description = "Toggle Reading Mode" })
hl.bind(mod .. " + ALT + N", function()
	M.toggle("Night Light")
end, { description = "Toggle Night Light" })
hl.bind(alt .. " + C", function()
	M.toggle("CRT Mode")
end, { description = "Toggle CRT Mode" })
hl.bind(mod .. " + ALT + S", function()
	M.turn_off_all()
end, { description = "Turn Off All Shaders" })

return M
