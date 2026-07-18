-- Matugen theme for mini.base16

local base16 = require("mini.base16")
local shared = require("colors._shared")

local diff_palette = {
	add = { bg = "#4a4458", fg = "#e8def8" },
	delete = { bg = "#93000a", fg = "#ffdad6" },
	change = { bg = "#494453" },
	text = { bg = "#49454e" },
}

-- Base16 palette from matugen
local palette = {
	base00 = "#141314", -- background
	base01 = "#141314", -- lighter background
	base02 = "#141314", -- selection
	base03 = "#484648", -- comments, line numbers
	base04 = "#c9c5c7", -- dark foreground
	base05 = "#e6e1e3", -- foreground
	base06 = "#f2eff0", -- light foreground
	base07 = "#fdfdfd", -- lightest
	base08 = "#ffb4ab", -- red (variables, errors)
	base09 = "#b1a8b8", -- orange
	base0A = "#cac4cf", -- yellow
	base0B = "#ccc2db", -- green (strings)
	base0C = "#e7dff2", -- cyan (operators)
	base0D = "#cbc3d5", -- blue (functions)
	base0E = "#e8def8", -- purple (keywords)
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
	darker_black = "#201f21",
	black = "#131313",
	black2 = "#141314",
	one_bg = "#141314",
	grey = "#484648",
	red = "#ffb4ab",
	pink = "#e8def8",
	green = "#ccc2db",
	blue = "#cbc3d5",
	orange = "#b1a8b8",
	cyan = "#f5f1f9",
	teal = "#e7dff2",
	purple = "#d9c9f4",
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

local group = vim.api.nvim_create_augroup("MatugenTheme", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.g.colors_name == "matugen" then
			apply_custom_highlights()
		end
	end,
})

return {
	palette = palette,
	colors = colors,
}
