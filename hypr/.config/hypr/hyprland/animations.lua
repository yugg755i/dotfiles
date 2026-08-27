-- animations.lua
hl.curve("scroll", { type = "bezier", points = { { 0.25, 1 }, { 0.35, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.2, 1 }, { 0.3, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "scroll", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "scroll", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "snappy", style = "slide" })
-- Borders / focus
hl.animation({ leaf = "border", enabled = true, speed = 7, bezier = "smooth" })
-- Fade
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "smooth" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smooth" })
-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "scroll", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "scroll", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "linear", style = "fade" })
-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "scroll", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5, bezier = "scroll", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4, bezier = "snappy", style = "slidevert" })
-- Special workspace
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "scroll", style = "slidevert" })
