-- binds.lua

local mainMod = "SUPER"

-- === Application Launchers ===
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("zen-browser --blank-window"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("kitty --class kittypad -e rmpc"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -theme /home/yugg755/.config/rofi/config.rasi"))
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		'bash -c "cliphist list | rofi -dmenu -i -theme ~/.config/rofi/config.rasi | cliphist decode | wl-copy"'
	)
)
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("loginctl terminate-session $XDG_SESSION_ID"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("kitty -e btop"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("kitty --class floatterm -e --config None nmtui"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("kitty --class floatterm -e bluetui"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("localsend"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd("~/.config/hypr/scripts/focus-mode.sh toggle"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("bash ~/.config/rofi/rofi-movies.sh"))

-- Special Workspace (scratchpad terminal)
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("term"))

-- Logout / power
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("bash ~/.config/rofi/powermenu.sh"))

-- Wallpapers & theming
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("bash ~/.config/rofi/wallpaper.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/toggle-mode.sh"))
hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.exec_cmd("bash ~/.config/rofi/vwallpaper.sh"))
hl.bind(mainMod .. " + ALT + SHIFT + A", hl.dsp.exec_cmd("bash ~/.config/rofi/matugen-theme.sh"))
hl.bind(mainMod .. " + ALT + SHIFT + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/lock-mode-select.sh"))
hl.bind(mainMod .. " + ALT + SHIFT + W", hl.dsp.exec_cmd("~/.config/waybar/scripts/waybar-style"))
-- Power modes
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("bash ~/.config/rofi/power-mode.sh"))

-- === Fn / Media Keys ===
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --max-volume 153 --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(
		'bash -c \'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then notify-send "Mic Muted"; else notify-send "Mic Unmuted"; fi\''
	),
	{ locked = true }
)
hl.bind(
	"XF86RFKill",
	hl.dsp.exec_cmd(
		'bash -c \'STATE=$(nmcli radio wifi); if [ "$STATE" = "enabled" ]; then nmcli radio wifi off && notify-send "Airplane Mode ON"; else nmcli radio wifi on && notify-send "Airoplane Mode OFF"; fi\''
	)
)
-- FIXED: was bound to exec_cmd("kitty") — opening a terminal on a touchpad
-- toggle key makes no sense. Use libinput's actual toggle command instead.
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("hyprctl keyword input:touchpad:disable_while_typing toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))

-- === Window Management ===
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen({
		action = "toggle",
		mode = "fullscreen",
	})
)

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))

-- === Focus Navigation ===
hl.bind(mainMod .. " + left", hl.dsp.layout("focus l"), { repeating = true })
hl.bind(mainMod .. " + right", hl.dsp.layout("focus r"), { repeating = true })
hl.bind(mainMod .. " + H", hl.dsp.layout("focus l"), { repeating = true })
hl.bind(mainMod .. " + L", hl.dsp.layout("focus r"), { repeating = true })
hl.bind(mainMod .. " + comma", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))

-- === Window Movement ===
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.layout("swapcol l"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("swapcol r"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"), { repeating = true })

-- === Monitor Focus ===
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ monitor = "r" }))

-- === Move Window to Monitor ===
hl.bind(mainMod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- === Workspace Navigation ===
hl.bind(mainMod .. " + J", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "e-1" }))

-- === Move Window to Workspace (silent) ===
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ workspace = "e+1", follow = false }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ workspace = "e-1", follow = false }))

-- === Mouse Wheel Workspace ===
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- === Numbered Workspaces (1-9) ===
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- === Column / Layout (scrolling) ===
hl.bind(mainMod .. " + R", hl.dsp.layout("promote"))

-- === Resize ===
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("colresize -conf"), { repeating = true })
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("colresize +conf"), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

-- === Mouse drag / resize ===
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- === System Controls ===
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.exec_cmd("dpms toggle"))
hl.bind(mainMod .. " + ALT + CTRL + L", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/lock.sh"))

-- === Screenshots ===
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'bash -c \'grim -g "$(slurp)" - | tee ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | wl-copy --type image/png && notify-send "Screenshot copied + saved"\''
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		"bash -c 'grim - | tee ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | wl-copy --type image/png && notify-send \"Copied + saved screenshot\"'"
	)
)

-- === File Search ===
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd('kitty -e bash -c "fd . ~ | fzf | xargs -r xdg-open"'))

-- === Touchpad Gestures ===
hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace",
})

hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
