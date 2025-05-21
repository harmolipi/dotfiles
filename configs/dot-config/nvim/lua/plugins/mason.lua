return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = false,
    opts = {
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "intelephense",

        -- install formatters
        "stylua",
        "nixpkgs-fmt",
        "prettier",
        "mdformat",

        -- install debuggers

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  -- { "williamboman/mason.nvim", enabled = false },
  -- { "williamboman/mason-lspconfig.nvim", enabled = false },
}
