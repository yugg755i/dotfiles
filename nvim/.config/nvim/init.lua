require("config.lazy")

local theme = require("config.theme").current

vim.schedule(function()
  vim.cmd.colorscheme(theme)
end)
