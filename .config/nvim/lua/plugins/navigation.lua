return {
  -- Telescope fuzzy search tools
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local actions = require('telescope.actions')

      require('telescope').setup({
        file_ignore_patterns = { '.git' },
        scroll_strategy = 'limit',
        sorting_strategy = 'descending',
        prompt_prefix=' 🔍 ',
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close
            },
          },
        },
        pickers = {
          lsp_dynamic_workspace_symbols = {
            symbol_kinds = {
              "File",
              "Module",
              "Namespace",
              "Package",
              "Class",
              "Method",
              "Property",
              "Field",
              "Constructor",
              "Enum",
              "Interface",
              "Function",
              "Variable",
              "Constant",
              "String",
              "Number",
              "Boolean",
              "Array",
              "Object",
              "Key",
              "Null",
              "EnumMember",
              "Struct",
              "Event",
              "Operator",
              "TypeParameter",
            },
          },
        }
      })

      local builtin = require('telescope.builtin')
      vim.keymap.set({'n', 't'}, '<leader>b', builtin.buffers)
      vim.keymap.set({'n', 't'}, '<leader>s', function()
        builtin.grep_string({ search = vim.fn.input('Search: ') });
      end)
      vim.keymap.set({'n', 't'}, '<leader>f', function()
        builtin.find_files({hidden=true})
      end)
    end
  },

  -- Nvim Tree
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local function edit_or_enter()
          local node = api.tree.get_node_under_cursor()
          if node.type == 'directory' and not node.open then
            api.node.open.edit()
            vim.cmd('normal! j')
          else
            api.node.open.edit()
          end
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Parent Directory'))
        vim.keymap.set('n', 'l', edit_or_enter, opts('Open'))
      end

      require('nvim-tree').setup({
        on_attach = on_attach,
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          centralize_selection = true,
          width = 30,
        },
        actions = {
          change_dir = {
            global = true,
          },
          open_file = {
            quit_on_open = true,
          },
        },
        renderer = {
          group_empty = true,
          highlight_opened_files = 'all',
        },
        filters = {
          custom = {
            '.git',
          }
        },
      })

      vim.keymap.set('n', '<leader>n', function ()
        local api = require('nvim-tree.api')
        api.tree.toggle()
      end)
    end,
  },

  -- Buffer Remove
  {
    'nvim-mini/mini.bufremove',
    version = false
  },
}
