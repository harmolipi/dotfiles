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
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
    event = "User AstroFile"
  },

  -- Testing helper
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set('n', '<Leader>dn', ':TestNearest<CR>')
      vim.keymap.set('n', '<Leader>df', ':TestFile<CR>')
      vim.keymap.set('n', '<Leader>ds', ':TestSuite<CR>')
      vim.keymap.set('n', '<Leader>dl', ':TestLast<CR>')
      vim.keymap.set('n', '<Leader>dv', ':TestVisit<CR>')
    end,
    event = "User AstroFile"
  },

  -- Quickfix diagnostics list
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    event = "User AstroFile",
    config = function()
      vim.keymap.set('n', '<Leader>xx', ':TroubleToggle<CR>')
      vim.keymap.set('n', '<Leader>xw', ':TroubleToggle workspace_diagnostics<CR>')
      vim.keymap.set('n', '<Leader>xd', ':TroubleToggle document_diagnostics<CR>')
      vim.keymap.set('n', '<Leader>xq', ':TroubleToggle quickfix<CR>')
    end,
  },

  -- {
  --   "giusgad/pets.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
  --   config = function() require("pets").setup { row = 6 } end,
  --   lazy = false,
  -- },
	{
		"justinmk/vim-sneak",
		event = "User AstroFile",
	},
}
