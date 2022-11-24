if vim.g.roron_loaded then
  return
end
vim.g.roron_loaded = 1

local M = {}

M.rails = require('rails')

if vim.g.roron_autos == true then
  M.autos = require('autocmds')
end

return M
