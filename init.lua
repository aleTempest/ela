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

  Plug('nvim-treesitter/nvim-treesitter', { branch = 'master' })
vim.call('plug#end')

vim.cmd[[colorscheme solarized]]

vim.g.mapleader = " " 

-- {{ Mini }}
require'mini.pairs'.setup()
require'mini.move'.setup()
require'mini.statusline'.setup()

-- {{{ Telescope }}}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

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
