-- Matugen theme for mini.base16

local base16 = require("mini.base16")
local shared = require("colors._shared")

local diff_palette = {
	add = { bg = "#4e4256", fg = "#edddf6" },
	delete = { bg = "#93000a", fg = "#ffdad6" },
	change = { bg = "#4c4452" },
	text = { bg = "#4a454d" },
}

-- Base16 palette from matugen
local palette = {
	base00 = "#141314", -- background
	base01 = "#141314", -- lighter background
	base02 = "#141314", -- selection
	base03 = "#484648", -- comments, line numbers
	base04 = "#cac5c7", -- dark foreground
	base05 = "#e6e1e3", -- foreground
	base06 = "#f2eff0", -- light foreground
	base07 = "#fdfdfd", -- lightest
	base08 = "#ffb4ab", -- red (variables, errors)
	base09 = "#b5a8b7", -- orange
	base0A = "#cdc4ce", -- yellow
	base0B = "#d1c1d9", -- green (strings)
	base0C = "#ebdef0", -- cyan (operators)
	base0D = "#cfc2d4", -- blue (functions)
	base0E = "#edddf6", -- purple (keywords)
	base0F = "#ffcbc5", -- brown
}

base16.setup({
	palette = palette,
	use_cterm = nil,
	plugins = {
		default = true,
		["echasnovski/mini.nvim"] = true,
	},
})

vim.g.colors_name = "matugen"

-- Custom highlight colors
local colors = {
	white = "#e6e1e3",
	darker_black = "#211f21",
	black = "#131313",
	black2 = "#141314",
	one_bg = "#141314",
	grey = "#484648",
	red = "#ffb4ab",
	pink = "#edddf6",
	green = "#d1c1d9",
	blue = "#cfc2d4",
	orange = "#b5a8b7",
	cyan = "#f6f0f8",
	teal = "#ebdef0",
	purple = "#e2c9f1",
	lavender = "#ffffff",
}

local function apply_custom_highlights()
	-- UI highlights
	vim.api.nvim_set_hl(0, "Normal", { bg = colors.black })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "TelescopePrompt", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "TelescopeResults", { bg = colors.darker_black })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.black2 })
	vim.api.nvim_set_hl(0, "CmpPmenu", { bg = colors.black2 })
	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = colors.black2 })
	vim.api.nvim_set_hl(0, "Visual", { bg = colors.grey })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.grey })

	-- Treesitter highlights
	vim.api.nvim_set_hl(0, "@variable", { fg = colors.white })
	vim.api.nvim_set_hl(0, "@module", { fg = colors.white })
	vim.api.nvim_set_hl(0, "@variable.member", { fg = colors.white })
	vim.api.nvim_set_hl(0, "@property", { fg = colors.teal })
	vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.red })
	vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors.purple })
	vim.api.nvim_set_hl(0, "@variable.parameter", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "@operator", { fg = colors.cyan })
	vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.cyan })
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.cyan })
	vim.api.nvim_set_hl(0, "@punctuation.special", { fg = colors.teal })
	vim.api.nvim_set_hl(0, "@function.macro", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "@keyword.storage", { fg = colors.purple })
	vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors.cyan })
	vim.api.nvim_set_hl(0, "@function", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "@constructor", { fg = colors.lavender })
	vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors.orange })

	-- Syntax highlights
	vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.purple })
	vim.api.nvim_set_hl(0, "Repeat", { fg = colors.purple })
	vim.api.nvim_set_hl(0, "Define", { fg = colors.blue })

	shared.apply_diff(diff_palette)

	-- Telescope custom
	vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.one_bg, fg = colors.blue })
end

apply_custom_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = apply_custom_highlights,
})

return {
	palette = palette,
	colors = colors,
}
