return {
  -- Mason
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    opts = {},
  },

  -- Nvim LSP
  {
    'neovim/nvim-lspconfig',
    config = function ()
      local aug = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = aug,
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true, noremap = true }

          vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', 'gn', function() vim.diagnostic.jump({count=1, float=true}) end, opts)
          vim.keymap.set('n', 'gN', function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

          -- telescope-powered LSP pickers
          local tb = require('telescope.builtin')
          vim.keymap.set('n', 'gd', tb.lsp_definitions, opts)
          vim.keymap.set('n', 'gi', tb.lsp_implementations, opts)
          vim.keymap.set('n', 'gr', tb.lsp_references, opts)
          vim.keymap.set('n', 'gt', tb.lsp_type_definitions, opts)
          vim.keymap.set('n', 'gs', tb.lsp_dynamic_workspace_symbols, opts)

          -- your insert-completion shortcut
          vim.keymap.set('n', 'g<Space>', 'i<C-x><C-o>', opts)
        end,
      })
    end
  },

  -- Bridge Mason <-> nvim-lspconfig
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'bashls',
        'clangd',
        'docker_language_server',
        'lua_ls',
        'pyright',
        'rust_analyzer',

      },
      automatic_installation = true,
    },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        modules = {},
        ensure_installed = {},
        ignore_install = {},
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true,
        },
      })
    end
  },

  -- Treesitter Autotag
  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    opts = {}
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    -- `main` is untested, please open a PR if you've confirmed it works as expected
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
      snippets = { preset = 'luasnip' },
      -- ensure you have the `snippets` source (enabled by default)
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      keymap = {
        preset = 'none',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<Enter>'] = { 'select_and_accept', 'fallback' },
        ['<Esc>'] = { 'hide', 'cancel', 'fallback'}
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
    }
  },

  -- Neogen Comment Generator
  {
    'danymat/neogen',
    version = '*',
    config = function ()
      local neogen = require('neogen')
      neogen.setup({
        snippet_engine = 'luasnip',
        enabled = true
      })
      vim.api.nvim_set_keymap('n', '<Leader>dd', 'neogen.generate', {noremap = true, silent = true})
      vim.keymap.set('n', '<Leader>dd', function() neogen.generate() end, {noremap = true, silent = true})
    end
  }
}
