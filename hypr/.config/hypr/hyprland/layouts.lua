-- layouts.lua
-- vscroll.lua must be required before this in hyprland.lua so "lua:vscroll"
-- is already registered when general.layout references it in appearance.lua.
hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	scrolling = {
		fullscreen_on_one_column = true,
		column_width = 0.5,
		follow_focus = true,
		follow_min_visible = 0.4,
		wrap_focus = true,
		wrap_swapcol = true,
	},
})
