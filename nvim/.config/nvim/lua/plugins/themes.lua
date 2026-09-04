return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup({
        bold = true,
        italics = true,
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = {},
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = {
            zen = {},
            pearl = {},
            ink = {},
            all = {},
          },
        },
        overrides = function(colors)
          return {}
        end,
        background = {
          dark = "ink",
          light = "pearl",
        },
        foreground = "default",
        minimal = false,
      })

      vim.cmd("colorscheme kanso")
    end,
  },

  {
    "ember-theme/nvim",
    name = "ember",
    priority = 1000,
    opts = {
      variant = "ember",
    },
  },

  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
    end,
  },

  {
    "whatyouhide/vim-gotham",
    lazy = false,
    priority = 1000,
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
  },

  {
    "danfry1/lume",
    lazy = false,
    priority = 1000,
    config = function()
      require("lume").setup({
        transparent = false,
        italics = true,
        palette_overrides = {
          foregrounds = { text = "#c8c8d8" },
          accents = { lavender = "#a890d0" },
        },
        custom_highlights = function(colors, variant)
          return {
            Normal = { bg = "#1E1F2E" },
            MiniDiffSignAdd = { fg = colors.accents.sage },
          }
        end,
      })

      vim.cmd("colorscheme lume")
    end,
  },

  { "savq/melange-nvim", lazy = false, priority = 1000 },

  { "ptdewey/darkearth-nvim", priority = 1000 },

  {
    "everviolet/nvim",
    name = "evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          solid_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
    },
  },

  {
    "dark-orchid/neovim",
    main = "dark-orchid",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
