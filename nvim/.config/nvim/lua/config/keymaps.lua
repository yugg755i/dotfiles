-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local seen = {}
local themes = { "matugen" }
seen["matugen"] = true

for _, theme in ipairs(vim.fn.getcompletion("", "color")) do
  if not seen[theme] then
    seen[theme] = true
    table.insert(themes, theme)
  end
end

table.sort(themes)

vim.keymap.set("n", "<leader>ut", function()
  Snacks.picker.select(themes, {
    prompt = "Theme",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then
      return
    end

    -- Save selection
    local path = vim.fn.stdpath("config") .. "/lua/config/theme.lua"
    local file = io.open(path, "w")
    if file then
      file:write(("return {\n  current = %q,\n}\n"):format(choice))
      file:close()
    end

    package.loaded["config.theme"] = nil

    vim.cmd("highlight clear")
    vim.g.colors_name = nil

    if choice == "matugen" then
      package.loaded["colors.matugen"] = nil
      require("colors.matugen")
    else
      vim.cmd.colorscheme(choice)
    end

    vim.notify("Theme switched to " .. choice)
  end)
end, { desc = "Theme Picker" })
