-- Basic Editor Options
local o = vim.opt
o.number = true                          -- show line numbers
o.relativenumber = true                  -- relative line numbers
o.shiftwidth = 2                         -- two-space indentation width
o.autoindent = true                      -- maintain indent on new lines
o.clipboard = 'unnamedplus'              -- use system clipboard

-- Diagnostics Configuration
vim.diagnostic.config({
  virtual_text = false,                  -- disable virtual text diagnostics
  virtual_lines = { only_current_line = true },  -- show inline diagnostics only for current line
})

-- Keymaps
vim.keymap.set('n', '<C-x>', ':Ex<CR>', { silent = true })

-- Colorscheme
vim.cmd 'colorscheme  elflord'

-- Bootstrapping and configuring lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Typst support
  { 'kaarmu/typst.vim',            
    ft = 'typst',
    lazy=false},
  { 'chomosuke/typst-preview.nvim',
    -- ft = 'typst',
    lazy=false,
    version = '1.*',
    opts = {},
  },

  -- Completion engine and sources
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-spell',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'spell' },
        },
        mapping = {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        },
      })
    end,
  },

  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local on_attach = function(client, bufnr)
        if client.name == 'r_language_server' then
          -- disable formatting from RLS
          client.server_capabilities.documentFormattingProvider = false
        end
      end

      -- Rust Analyzer
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        settings = {
          cargo = { buildScripts = { enable = true } },
        },
      })

      -- Python
      lspconfig.pyright.setup({ on_attach = on_attach })

      -- R
      lspconfig.r_language_server.setup({ on_attach = on_attach })

      -- C/C++
      lspconfig.ccls.setup({ 
	on_attach = on_attach,
      })

      -- Haskell
      lspconfig.hls.setup({
        on_attach = on_attach,
        settings = { haskell = { checkProject = false, installGhc = false } },
      })
    end,
  },

  -- Treesitter for syntax and indent
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        indent =    { enable = true },
      })
    end,
  },
})

