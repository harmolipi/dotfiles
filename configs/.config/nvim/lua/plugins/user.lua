-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "███╗   ██╗    ██╗    ██╗  ██╗     ██████╗         ██╗  ██╗    ███████╗    ██████╗     ███████╗",
        "████╗  ██║    ██║    ██║ ██╔╝    ██╔═══██╗        ██║  ██║    ██╔════╝    ██╔══██╗    ██╔════╝",
        "██╔██╗ ██║    ██║    █████╔╝     ██║   ██║        ███████║    █████╗      ██████╔╝    █████╗  ",
        "██║╚██╗██║    ██║    ██╔═██╗     ██║   ██║        ██╔══██║    ██╔══╝      ██╔══██╗    ██╔══╝  ",
        "██║ ╚████║    ██║    ██║  ██╗    ╚██████╔╝        ██║  ██║    ███████╗    ██║  ██║    ███████╗",
        "╚═╝  ╚═══╝    ╚═╝    ╚═╝  ╚═╝     ╚═════╝         ╚═╝  ╚═╝    ╚══════╝    ╚═╝  ╚═╝    ╚══════╝",
      }
      return opts
    end,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  -- { "navarasu/onedark.nvim" },
  {
    "zbirenbaum/copilot.lua",
    event = "User AstroFile",
    config = function()
      require("copilot").setup {
        panel = {
          auto_refresh = true,
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
          },
        },
      }
    end,
  },
  { "tpope/vim-surround", event = "User AstroFile" },
  { "urbit/hoon.vim", event = "User AstroFile" },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  {
    "phpactor/phpactor",
    ft = "php",
    -- run = "composer install --no-dev --optimize-autoloader",
    event = "User AstroFile",
  },

  -- Testing helper
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<Leader>dn", ":TestNearest<CR>")
      vim.keymap.set("n", "<Leader>df", ":TestFile<CR>")
      vim.keymap.set("n", "<Leader>ds", ":TestSuite<CR>")
      vim.keymap.set("n", "<Leader>dl", ":TestLast<CR>")
      vim.keymap.set("n", "<Leader>dv", ":TestVisit<CR>")
    end,
    event = "User AstroFile",
  },

  -- Quickfix diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "User AstroFile",
    config = function()
      vim.keymap.set("n", "<Leader>xx", ":TroubleToggle<CR>")
      vim.keymap.set("n", "<Leader>xw", ":TroubleToggle workspace_diagnostics<CR>")
      vim.keymap.set("n", "<Leader>xd", ":TroubleToggle document_diagnostics<CR>")
      vim.keymap.set("n", "<Leader>xq", ":TroubleToggle quickfix<CR>")
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "User AstroFile",
    config = function()
      require("hop").setup()
      vim.keymap.set("n", "s", ":HopWord<CR>")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    event = "User AstroFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Left index finger
      vim.keymap.set("n", "<Leader><Leader>f", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")

      -- Lift the finger to do something dangerous
      vim.keymap.set("n", "<Leader><Leader>g", ":lua require('harpoon.mark').add_file()<CR>")

      -- Right home row, no finger lifting required
      vim.keymap.set("n", "<Leader><Leader>j", ":lua require('harpoon.ui').nav_file(1)<CR>")
      vim.keymap.set("n", "<Leader><Leader>k", ":lua require('harpoon.ui').nav_file(2)<CR>")
      vim.keymap.set("n", "<Leader><Leader>l", ":lua require('harpoon.ui').nav_file(3)<CR>")
      vim.keymap.set("n", "<Leader><Leader>;", ":lua require('harpoon.ui').nav_file(4)<CR>")
    end,
  },
  -- {
  --   "mbbill/undotree",
  --   event = "User AstroFile",
  -- },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      vim.keymap.set("x", "<leader>re", ":Refactor extract ")
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
      vim.keymap.set({ "n", "x" }, "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end)
    end,
    event = "User AstroFile",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 2,
        line_numbers = false,
      }
    end,
    event = "User AstroFile",
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("oil").setup() end,
    event = "UIEnter",
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
