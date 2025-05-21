---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    ensure_installed = {
      "bash",
      "css",
      "elixir",
      "elm",
      "gitignore",
      "go",
      "hoon",
      "html",
      "javascript",
      "lua",
      "nix",
      "regex",
      "typescript",
      "vim",
      "tsx",
    },
  },
}
