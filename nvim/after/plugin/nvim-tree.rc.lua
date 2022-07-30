-- Nvim-tree

local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        side = "left",
        mappings = {
            list = {
                {key = "so", action = "system_open"}, -- Remove 's' key conflict with moving windows shortcut
                {key = "l", cb = tree_cb "edit"},
                {key = "h", cb = tree_cb "close_node"},
            }
        }
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    }
}
