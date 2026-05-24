"$schema" = "https://yazi-rs.github.io/schemas/theme.json"

# : Flavor {{{


# : }}}


# : App {{{

[app]
overall = { bg = "#101010", fg = "#f6f1ea" }

# : }}}


# : Manager {{{

[mgr]
cwd = { fg = "#afa193" }

find_keyword  = { fg = "#c2a47b", bold = true, italic = true, underline = true }
find_position = { fg = "#7a858b", bold = true, italic = true }

symlink_target = { fg = "#989085", italic = true }

marker_copied   = { fg = "#101010", bg = "#ad9474" }
marker_cut      = { fg = "#101010", bg = "#9f886a" }
marker_marked   = { fg = "#101010", bg = "#afa193" }
marker_selected = { fg = "#101010", bg = "#c2a47b" }

count_copied   = { fg = "#101010", bg = "#ad9474" }
count_cut      = { fg = "#101010", bg = "#9f886a" }
count_selected = { fg = "#101010", bg = "#c2a47b" }

border_symbol = "│"
border_style  = { fg = "#2a2a2a" }

syntect_theme = ""

# : }}}


# : Tabs {{{

[tabs]
active   = { fg = "#101010", bg = "#afa193", bold = true }
inactive = { fg = "#989085", bg = "#101010" }

sep_inner = { open = "▐", close = "▌" }
sep_outer = { open = "▐", close = "▌" }

# : }}}


# : Mode {{{

[mode]
normal_main = { fg = "#101010", bg = "#afa193", bold = true }
normal_alt  = { fg = "#afa193", bg = "#181818" }

select_main = { fg = "#101010", bg = "#c2a47b", bold = true }
select_alt  = { fg = "#c2a47b", bg = "#181818" }

unset_main = { fg = "#101010", bg = "#9f886a", bold = true }
unset_alt  = { fg = "#9f886a", bg = "#181818" }

# : }}}


# : Indicator {{{

[indicator]
parent  = { fg = "#101010", bg = "#afa193" }
preview = { fg = "#989085", underline = true }
current = { fg = "#101010", bg = "#f6f1ea" }
padding = { open = "▐", close = "▌" }

# : }}}


# : Status bar {{{

[status]
overall   = { bg = "#101010", fg = "#989085" }
sep_left  = { open = "▐", close = "▌" }
sep_right = { open = "▐", close = "▌" }

perm_sep   = { fg = "#2a2a2a" }
perm_type  = { fg = "#ad9474" }
perm_read  = { fg = "#c2a47b" }
perm_write = { fg = "#9f886a" }
perm_exec  = { fg = "#707b84" }

progress_label  = { fg = "#f6f1ea", bold = true }
progress_normal = { fg = "#afa193", bg = "#181818" }
progress_error  = { fg = "#c2a47b", bg = "#9f886a" }

# : }}}


# : Which {{{

[which]
cols            = 3
mask            = { bg = "#101010" }
cand            = { fg = "#afa193" }
rest            = { fg = "#989085" }
desc            = { fg = "#7a858b" }
separator       = "  "
separator_style = { fg = "#2a2a2a" }

# : }}}


# : Confirm {{{

[confirm]
border     = { fg = "#afa193" }
title      = { fg = "#f6f1ea" }
btn_yes    = { fg = "#101010", bg = "#afa193" }
btn_no     = { fg = "#989085" }
btn_labels = [ "  [Y]es  ", "  (N)o  " ]

# : }}}


# : Spot {{{

[spot]
border = { fg = "#afa193" }
title  = { fg = "#f6f1ea" }

tbl_col  = { fg = "#afa193" }
tbl_cell = { fg = "#101010", bg = "#afa193" }

# : }}}


# : Notify {{{

[notify]
title_info  = { fg = "#afa193" }
title_warn  = { fg = "#c2a47b" }
title_error = { fg = "#9f886a" }

icon_info  = ""
icon_warn  = ""
icon_error = ""

# : }}}


# : Picker {{{

[pick]
border   = { fg = "#afa193" }
active   = { fg = "#f6f1ea", bold = true }

# : }}}


# : Input {{{

[input]
border   = { fg = "#afa193" }
selected = { fg = "#101010", bg = "#f6f1ea" }

# : }}}


# : Completion {{{

[cmp]
border   = { fg = "#afa193" }
active   = { fg = "#101010", bg = "#afa193" }

icon_file    = ""
icon_folder  = ""
icon_command = ""

# : }}}


# : Tasks {{{

[tasks]
border  = { fg = "#afa193" }
hovered = { fg = "#f6f1ea", bold = true }

# : }}}


# : Help {{{

[help]
on      = { fg = "#afa193" }
run     = { fg = "#7a858b" }
hovered = { fg = "#101010", bg = "#afa193", bold = true }
footer  = { fg = "#101010", bg = "#f6f1ea" }

# : }}}

[icon]

# keep empty so defaults don’t interfere
globs = []
exts  = []

# override dirs
dirs = [
    { name = "*", text = "󰉋", fg = "#afa193" }
]

# override files
files = [
    { name = "*", text = "󰈔", fg = "#989085" }
]

# final fallback (very important)
conds = [
    { if = "dir",  text = "󰉋", fg = "#afa193" },
    { if = "exec", text = "󰆍", fg = "#ad9474" },
    { if = "!dir", text = "󰈔", fg = "#989085" },
]
