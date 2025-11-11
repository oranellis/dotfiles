-- custom quit commands
local function quit_if_empty()
  if vim.api.nvim_buf_line_count(0) and vim.fn.getline(1) == '' then
    vim.api.nvim_command('q')
  end
end

local br = require('mini.bufremove')

local function custom_quit()
  if vim.fn.expand('%:t') == '' then
    quit_if_empty()
    print('Enter a name for this buffer or leave blank to delete')
    local fname = vim.fn.input('File: ')
    if fname ~= '' then
      vim.api.nvim_command('w ' .. fname)
    end
    br.delete(0, true)
    quit_if_empty()
  else
    if not vim.bo.readonly and vim.bo.buftype == '' then
      vim.api.nvim_command('w')
    end
    br.delete(0, true)
    quit_if_empty()
  end
end

vim.keymap.set({'n', 't'}, '<leader>q', custom_quit)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>t', vim.cmd.terminal)
vim.keymap.set('n', '<leader>w', vim.cmd.wa)
