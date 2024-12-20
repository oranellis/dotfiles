require('telescope').setup {
    defaults = {
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        file_ignore_patterns = {
            ".git"
        }
    },
}

local builtin = require('telescope.builtin')

vim.keymap.set({'n', 't'}, '<leader>b', builtin.buffers)
vim.keymap.set({'n', 't'}, '<leader>s', function()
    builtin.grep_string({ search = vim.fn.input('Search: ') });
end)
vim.keymap.set({'n', 't'}, '<leader>f', function()
    builtin.find_files({hidden=true})
end)
