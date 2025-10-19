-- VimPlug
local Plug = vim.fn['plug#']

vim.call('plug#begin')
  Plug 'nvim-mini/mini.nvim'
  Plug 'nvim-mini/mini.pairs'
  Plug 'nvim-mini/mini.move'
  Plug 'nvim-mini/mini.statusline'
  Plug 'nvim-lua/plenary.nvim'
  Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
  Plug'maxmx03/solarized.nvim'
  Plug 'folke/which-key.nvim'
  Plug('nvim-treesitter/nvim-treesitter', { branch = 'master' })
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
vim.call('plug#end')

local hostname = vim.fn.hostname()
local hostType = 0
local winDesktopName = "DESKTOP-C3BF2T4"

vim.cmd[[colorscheme solarized]]

if hostname ~= winDesktopName then
  vim.o.background = "light"
else
  hostType = 1
end

vim.g.mapleader = " "

function getPluginNames(hostType)
  local files = ""
  if hostType > 0 then
    files = io.popen("dir /b .\\lua\\plugins"):read("*a")
  else
    files = io.popen("ls -a ./lua/plugins"):read("*a")
  end
  return files
end

local plugins = getPluginNames(hostType)
print(plugins)

require'plugins.telescope'.setup()
require'plugins.mini'.setup()
require'plugins.treesitter'.setup()
require'plugins.lsp'.setup()

-- Highlight al cursor cuando se copia algo
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Yes
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sincronizar el clipboard de nvim con el del sistema
vim.o.clipboard = "unnamedplus"

-- Números absolutos y relativos
vim.o.number = true
vim.o.relativenumber = true

-- Tabs and Indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 2

vim.o.breakindent = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.wrap = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.mouse = ""
vim.o.ignorecase = true
vim.o.smartcase = true

-- External grep program configuration
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

vim.o.updatetime = 50

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.o.termguicolors = true

vim.o.cursorline = true

vim.o.scrolloff = 8

vim.o.colorcolumn = "80"

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
