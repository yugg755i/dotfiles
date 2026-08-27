-- plugins.lua
hl.config({
	plugin = {
		scrolloverview = {
			gesture_distance = 300,
			scale = 0.5,
			workspace_gap = 100,
			layout = "vertical", -- vertical or horizontal overview grid
			wallpaper = 2, -- 0: global only, 1: per-workspace only, 2: both
			blur = true,
			shadow = {
				enabled = true,
				range = 50,
			},
		},
	},
})

hl.bind("SUPER + TAB", function()
	hl.plugin.scrolloverview.overview("toggle all")
end)
