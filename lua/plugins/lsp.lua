local M = {}
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

local cmp = require('cmp')
local luasnip = require('luasnip')

M.setup = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
      map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
      map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
    end
  })

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
      },
    })

    vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
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
