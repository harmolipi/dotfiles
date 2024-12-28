---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.nixpkgs_fmt,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.mdformat,
      null_ls.builtins.formatting.mix,
    }
    return config -- return final config table
  end,
}
