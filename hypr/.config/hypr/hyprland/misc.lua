-- misc.lua
hl.config({
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		enable_swallow = true,
		swallow_regex = "^(kitty)$",
		focus_on_activate = false,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		sensitivity = 0.8,
		follow_mouse = 1,
		accel_profile = "flat",
		mouse_refocus = false,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
		},
	},
	cursor = {
		no_hardware_cursors = false,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "logitech-wireless-receiver-mouse",
	accel_profile = "flat",
	sensitivity = 0,
})
