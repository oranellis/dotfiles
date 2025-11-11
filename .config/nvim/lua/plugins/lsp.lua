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
        'cmake',
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

  -- Blink Completion
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'none',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Enter>'] = { 'select_and_accept', 'fallback' }
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' }
    },
    opts_extend = { 'sources.default' }
  },

  -- Neogen Comment Generator
  {
    'danymat/neogen',
    version = '*',
    config = function ()
      local neogen = require('neogen')
      vim.api.nvim_set_keymap('n', '<Leader>dd', 'neogen.generate', {noremap = true, silent = true})
      vim.keymap.set('n', '<Leader>dd', function() neogen.generate() end, {noremap = true, silent = true})
    end
  }
}
