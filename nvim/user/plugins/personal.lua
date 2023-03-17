return {
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  { "tpope/vim-surround",    event = "User AstroFile" },
  {
    "narutoxy/dim.lua",
    requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = function() require("dim").setup {} end,
    event = "User AstroFile",
  },
  { "urbit/hoon.vim",        event = "User AstroFile" },
  { "github/copilot.vim",    event = "User AstroFile" },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    event = "User AstroFile",
  },
  { "navarasu/onedark.nvim" },
  {
    "phpactor/phpactor",
    ft = "php",
    run = "composer install --no-dev --optimize-autoloader",
    event = "User AstroFile",
  },
  { "rafamadriz/friendly-snippets", event = "User AstroFile" },
  -- {
  --   "giusgad/pets.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
  --   config = function() require("pets").setup { row = 6 } end,
  --   lazy = false,
  -- },
}
