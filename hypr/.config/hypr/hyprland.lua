-- hyprland.lua
require("colors")
require("binds")
require("autostart")
local shader = require("shader")

--------------------
---- MONITORS ----
--------------------
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "radeonsi")
hl.env("XDG_SESSION_TYPE", "wayland")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 2,
		border_size = 1,
		col = {
			active_border = { colors = { primary, secondary }, angle = 45 },
			inactive_border = surface,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		active_opacity = 0.92,
		inactive_opacity = 0.88,
		dim_inactive = true,
		dim_strength = 0.08,
		dim_special = 0.4,
		shadow = {
			enabled = false,
			range = 0,
			render_power = 1,
			color = background,
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 2,
			contrast = 1.5,
			brightness = 0.8,
			new_optimizations = true,
			vibrancy = 0,
			vibrancy_darkness = 0,
		},
	},

	animations = {
		enabled = true,
	},
})

--------------------
---- ANIMATIONS ----
--------------------
hl.curve("snap", { type = "bezier", points = { { 0.19, 1 }, { 0.22, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
hl.curve("snappyOut", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "snap", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "snap", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snappyOut", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "smooth" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "smooth" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "snap", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "snap", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "linear", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "snap", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4, bezier = "snap", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "snappyOut", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "snap", style = "slidevert" })

--------------------
---- LAYOUTS ----
--------------------
hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
})

----------------
---- MISC ----
----------------
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
})

---------------
---- INPUT ----
---------------
hl.config({
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
			scroll_factor = 0.5,
		},
	},
	cursor = {
		no_hardware_cursors = false,
	},
})

-- 3-finger horizontal swipe to switch workspaces
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

------------------------------
---- WINDOW RULES ----
------------------------------

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
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
