-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local matugen_file = vim.fn.stdpath("config") .. "/lua/colors/matugen.lua"

local watcher = vim.uv.new_fs_event()

watcher:start(
  matugen_file,
  {},
  vim.schedule_wrap(function(err)
    if err then
      return
    end

    if vim.g.colors_name == "matugen" then
      package.loaded["colors.matugen"] = nil

      pcall(require, "colors.matugen")

      vim.cmd("redraw!")
    end
  end)
)
