-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_php_lsp = "intelephense"

local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart("./godothost")
end
