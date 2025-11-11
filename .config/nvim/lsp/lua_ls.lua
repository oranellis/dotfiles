return {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
