return {
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{ "tpope/vim-surround", event = "User AstroFile" },
	{
		"narutoxy/dim.lua",
		requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		config = function()
			require("dim").setup({})
		end,
		event = "user astrofile",
	},
	{ "urbit/hoon.vim",     event = "User AstroFile" },
	-- { "github/copilot.vim", event = "User AstroFile" },
	{
		"zbirenbaum/copilot.lua",
		event = "User AstroFile",
		config = function()
			require("copilot").setup({
				panel = {
					auto_refresh = true,
				},
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-l>",
					},
				},
			})
		end,
	},
	{ "wakatime/vim-wakatime", event = "User AstroFile" },
	{ "navarasu/onedark.nvim" },
	{
		"phpactor/phpactor",
		ft = "php",
		run = "composer install --no-dev --optimize-autoloader",
		event = "User AstroFile",
	},
	-- { "rafamadriz/friendly-snippets", event = "User AstroFile" },
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
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
		requires = "kyazdani42/nvim-web-devicons",
		event = "User AstroFile",
		config = function()
			vim.keymap.set("n", "<Leader>xx", ":TroubleToggle<CR>")
			vim.keymap.set("n", "<Leader>xw", ":TroubleToggle workspace_diagnostics<CR>")
			vim.keymap.set("n", "<Leader>xd", ":TroubleToggle document_diagnostics<CR>")
			vim.keymap.set("n", "<Leader>xq", ":TroubleToggle quickfix<CR>")
		end,
	},
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			api_key_cmd = "pass show openai/chatgpt.nvim",
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	enabled = true,
	-- },
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
		require = {
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
	{
		"mbbill/undotree",
		event = "User AstroFile",
	},
	-- {
	-- 	"tpope/vim-fugitive",
	-- 	lazy = false,
	-- },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",      -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim",     -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				integrations = {
					telescope = true,
					diffview = true,
				},
			})
		end,
		lazy = false,
	},
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
			vim.keymap.set({ "n", "x" }, "<leader>rr", function()
				require("telescope").extensions.refactoring.refactors()
			end)
		end,
		event = "User AstroFile",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 2,
				line_numbers = false,
			})
		end,
		event = "User AstroFile",
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
		event = "User AstroFile",
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
		end,
		event = "UIEnter",
	},
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	enabled = false,
	-- },
}
