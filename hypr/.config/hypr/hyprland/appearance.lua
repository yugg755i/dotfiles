-- appearance.lua
hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = false,
	},
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 1,
		col = {
			active_border = "#454545",
			inactive_border = "#191919",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "scrolling",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		active_opacity = 0.93,
		inactive_opacity = 0.88,
		dim_inactive = true,
		dim_strength = 0.05,
		dim_special = 0.2,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = background,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			xray = true,
			special = false,
			ignore_opacity = true,
			brightness = 1,
			new_optimizations = true,
			noise = 0.1,
			contrast = 0.89,
			vibrancy = 0.5,
			vibrancy_darkness = 0.5,
			popups = false,
			popups_ignorealpha = 0.6,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
	},

	animations = {
		enabled = true,
	},
})
