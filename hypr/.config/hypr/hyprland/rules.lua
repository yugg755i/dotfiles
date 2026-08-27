-- WINDOW RULES

-- Ignore maximize requests from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix XWayland drag issues
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- hyprland-run floating terminal
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- Floating terminal
hl.window_rule({
	name = "floatterm",
	match = { class = "floatterm" },
	float = true,
	center = true,
	size = "800 600",
})

-- Kittypad scratchpad
hl.window_rule({
	name = "kittypad-float",
	match = { class = "kittypad" },
	float = true,
	center = true,
	size = "1700 900",
})

-- Picture-in-Picture
hl.window_rule({
	name = "float-pip",
	match = { title = "Picture-in-Picture" },
	float = true,
	pin = false,
	size = "600 350",
})
hl.window_rule({
	name = "pin-pip",
	match = { title = "Picture-in-Picture" },
	pin = true,
})

-- Battery popup
hl.window_rule({
	name = "battery-popup",
	match = { class = "battery-popup" },
	float = true,
	center = true,
	size = "500 300",
})

-- Zathura opacity
hl.window_rule({
	name = "zathura-opacity",
	match = { class = "org.pwmt.zathura" },
	opacity = "0.93 0.93",
})

-- imv: float, center, dynamic resize to image aspect ratio
hl.window_rule({
	name = "imv",
	match = { class = "imv" },
	float = true,
	center = true,
})

hl.on("window.title", function(w)
	if w.class ~= "imv" then
		return
	end

	local dims = w.title:match("%[%d+/%d+%] %[(%d+x%d+)%]")
	if not dims then
		return
	end

	local iw, ih = dims:match("(%d+)x(%d+)")
	iw, ih = tonumber(iw), tonumber(ih)

	local max_w, max_h = 1728, 972
	local scale = math.min(max_w / iw, max_h / ih, 1)
	local width = math.floor(iw * scale)
	local height = math.floor(ih * scale)

	hl.dispatch(hl.dsp.window.resize({ window = w, x = tostring(width), y = tostring(height) }))
end)

------------------------------
---- LAYER RULES ----
------------------------------
hl.layer_rule({
	name = "waybar blur",
	match = {
		namespace = "waybar",
	},
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	match = { namespace = "mpvpaper" },
	above_lock = true,
})

hl.layer_rule({
	name = "rofi-noanim",
	match = { namespace = "rofi" },
	no_anim = true,
})
