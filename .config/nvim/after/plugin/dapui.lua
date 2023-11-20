require('dapui').setup()

vim.keymap.set("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset=true})<CR>", {noremap=true})
