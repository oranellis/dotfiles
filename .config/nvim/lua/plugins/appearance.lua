return {
  -- Gruvbox Colour Scheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = false -- true to make terminal background show through
    }
  },

  -- Git Signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
    }
  },

  -- Lua Line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        globalstatus = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    }
  },

  -- Whitespace Highlighting
  {
    'aidancz/whitespace.nvim',
    config = function ()
      require('whitespace').setup({
        excluded_buftypes = { 'terminal' },
      })
    end
  },
}
