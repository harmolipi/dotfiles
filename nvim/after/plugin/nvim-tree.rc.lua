-- Nvim-tree
require("nvim-tree").setup {
    view = {
        mappings = {
            list = {
                {key = "so", action = "system_open"} -- Remove 's' key conflict with moving windows shortcut
            }
        }
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    }
}
