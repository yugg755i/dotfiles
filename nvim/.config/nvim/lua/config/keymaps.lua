local themes = {}
for _, theme in ipairs(vim.fn.getcompletion("", "color")) do
  table.insert(themes, theme)
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

    local path = vim.fn.stdpath("config") .. "/lua/config/theme.lua"
    local file = io.open(path, "w")
    if file then
      file:write(("return {\n  current = %q,\n}\n"):format(choice))
      file:close()
    end

    package.loaded["config.theme"] = nil
    vim.cmd("highlight clear")
    vim.g.colors_name = nil
    vim.cmd.colorscheme(choice)

    vim.notify("Theme switched to " .. choice)
  end)
end, { desc = "Theme Picker" })

-- Keyboard users
vim.keymap.set("n", "<leader>m", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec('"normal! \\<RightMouse>"')

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})
