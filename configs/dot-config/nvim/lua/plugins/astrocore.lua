-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    termguicolors = true,
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = true,
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        scrolloff = 8,
        swapfile = false,
        backup = false,
        undodir = os.getenv "HOME" .. "/.config/nvim/undodir",
        undofile = true,
      },
      g = { -- vim.g.<key>
        copilot_no_tab_map = true, -- disable copilot tab map
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bD"] = {
          function()
            require("astroui.status").heirline.buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<leader>b"] = { name = "Buffers" },
        -- Devaslife mappings:
        ["x"] = { '"_x', desc = "Don't yank with 'x'" },
        ["+"] = { "<C-a>", desc = "Increment" },
        ["-"] = { "<C-x>", desc = "Decrement" },
        ["<C-a>"] = { "gg<S-v>G", desc = "Select all" },
        -- Primeagen mappings:
        ["<leader><leader>d"] = { '"_d', desc = "Don't yank with 'd'" }, -- Added second leader so I can still use the debugger
        ["<leader>s"] = {
          [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
          desc = "Find and replace current word",
        },
        ["<leader>U"] = { vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" },
        -- ["<leader>gs"] = { ":tab Git<cr>", desc = "Open Fugitive status" },
        -- Run the current python file:
        ["<leader>rp"] = { ":!python3 %<cr>", desc = "Run python file" },
      },
      v = {
        ["J"] = { ":m '>+1<cr>gv=gv", desc = "Move line down" },
        ["K"] = { ":m '<-2<cr>gv=gv", desc = "Move line up" },
      },
    },
  },
  env = {
    TERM = "xterm-256color",
  },
}
