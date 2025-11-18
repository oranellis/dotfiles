vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (ev)
    local opts = { buffer = ev.buf, silent = true, noremap = true }
    vim.keymap.set('n', '<leader>h', vim.cmd.LspClangdSwitchSourceHeader, opts)
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({async = false})
  end,
})
