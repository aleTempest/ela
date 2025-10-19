local M = {}
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

local cmp = require('cmp')
local luasnip = require('luasnip')

M.setup = function()
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "pyright",
    },
    handlers = {
      mason_lspconfig.default_setup, 
      ['lua_ls'] = function()
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        }
      end,
    }
  })

  local on_attach = function(client, bufnr)
    -- Enable completion in Insert mode with <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local opts = { noremap=true, silent=true }

    -- Keymaps for LSP functions
    buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  end

  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

  cmp.setup({
    -- Setup for the snippet engine
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    -- Appearance/UI settings (optional)
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    -- Keybindings
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll backward
      ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll forward
      ['<C-Space>'] = cmp.mapping.complete(),  -- Show completion menu
      ['<C-e>'] = cmp.mapping.abort(),         -- Close completion menu
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item

      -- Use Tab to cycle through suggestions (optional, but popular)
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),

    -- Sources to use, in order of preference
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },    -- LSP source (most intelligent)
      { name = 'luasnip' },     -- Snippets
      { name = 'buffer' },      -- Words in current buffer
      { name = 'path' },        -- File paths
    }),
  })

end




return M
