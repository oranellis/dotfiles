require('nvim-treesitter.configs').setup {
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
}
