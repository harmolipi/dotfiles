return {
	n = {
		["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
		["<leader>bD"] = {
			function()
				require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
					require("astronvim.utils.buffer").close(bufnr)
				end)
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
		["<leader>d"] = { '"_d', desc = "Don't yank with 'd'" },
		["<leader>s"] = {
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			desc = "Find and replace current word",
		},
		["<leader>U"] = { vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" },
	},
	t = {},
	v = {
		["J"] = { ":m '>+1<cr>gv=gv", desc = "Move line down" },
		["K"] = { ":m '<-2<cr>gv=gv", desc = "Move line up" },
	},
}
