-- General settings
vim.g.neoformat_basic_format_align = 1 -- Enable alignment
vim.g.neoformat_basic_format_retab = 1 -- Enable tab to spaces conversion
vim.g.neoformat_basic_format_trim = 1 -- Enable trimming of trailing whitespace
vim.g.neoformat_try_node_exe = 1 -- Look for exe in local directories

-- Enable languages
vim.g.neoformat_enabled_javascript = {"prettier"}
vim.g.neoformat_enabled_typescript = {"prettier"}
vim.g.neoformat_enabled_html = {"prettier"}
vim.g.neoformat_enabled_css = {"prettier"}
vim.g.neoformat_enabled_php = {"prettier"}
vim.g.neoformat_enabled_json = {"prettier"}
vim.g.neoformat_enabled_yaml = {"prettier"}

vim.g.neoformat_lua_luafmt = {
    exe = "luafmt",
    try_node_exe = 1 -- Check local directories for luafmt
}
vim.g.neoformat_enabled_lua = {"luafmt"}
