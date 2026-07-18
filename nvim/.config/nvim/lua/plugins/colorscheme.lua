local theme = require("config.theme").current

return {
  {
    "nvim-mini/mini.base16",
    lazy = false,
    priority = 1000,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        if theme == "matugen" then
          require("colors.matugen")
        else
          vim.cmd.colorscheme(theme)
        end
      end,
    },
  },
}
