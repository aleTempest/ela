local M = {}

M.setup = function()
  require'mini.pairs'.setup()
  require'mini.move'.setup()
  require'mini.statusline'.setup()
end

return M
