local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- Nvim-treesitter
treesitter.setup {
    auto_install = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true
    }
}
