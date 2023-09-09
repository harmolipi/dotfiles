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
		["<leader>pm"] = { ":PhpactorContextMenu<cr>" },
		-- Devaslife mappings:
		["x"] = { '"_x', desc = "Don't yank with 'x'" },
		["+"] = { "<C-a>", desc = "Increment" },
		["-"] = { "<C-x>", desc = "Decrement" },
		["dw"] = { 'vb"_d', desc = "Delete a word backwards" },
		["<C-a>"] = { "gg<S-v>G", desc = "Select all" },
	},
	t = {},
}
