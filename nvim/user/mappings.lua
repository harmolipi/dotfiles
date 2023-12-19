local custom_mappings = {
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
		["<leader><leader>d"] = { '"_d', desc = "Don't yank with 'd'" }, -- Added second leader so I can still use the debugger
		["<leader>s"] = {
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			desc = "Find and replace current word",
		},
		["<leader>U"] = { vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" },
		-- ["<leader>gs"] = { ":tab Git<cr>", desc = "Open Fugitive status" },
	},
	t = {},
	v = {
		["J"] = { ":m '>+1<cr>gv=gv", desc = "Move line down" },
		["K"] = { ":m '<-2<cr>gv=gv", desc = "Move line up" },
	},
}

-- local fugitive_group = vim.api.nvim_create_augroup("fugitive_group", {})
--
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("BufWinEnter", {
-- 	group = fugitive_group,
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.ft ~= "fugitive" then
-- 			return
-- 		end
--
-- 		local bufnr = vim.api.nvim_get_current_buf()
--
-- 		vim.keymap.set("n", "<Leader>gp", ":Git push<CR>", {
-- 			desc = "Git push",
-- 			buffer = bufnr,
-- 			remap = false,
-- 		})
--
-- 		vim.keymap.set("n", "<Leader>gP", ":Git pull --rebase<CR>", {
-- 			desc = "Git pull with rebase",
-- 			buffer = bufnr,
-- 			remap = false,
-- 		})
--
-- 		vim.keymap.set("n", "q", "<space>c", {
-- 			desc = "Exit Fugitive",
-- 			buffer = bufnr,
-- 			remap = true,
-- 			silent = true,
-- 		})
--
-- 		vim.keymap.set("n", "?", "g?", {
-- 			desc = "Open Fugitive help",
-- 			buffer = bufnr,
-- 			remap = true,
-- 		})
--
-- 		vim.keymap.set("n", "<space>", "-", {
-- 			desc = "Stage file under cursor",
-- 			buffer = bufnr,
-- 			remap = true,
-- 		})
-- 	end,
-- })

return custom_mappings
