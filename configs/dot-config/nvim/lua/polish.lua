if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
local copilot_options = { silent = true, expr = true, script = true }
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept(<Tab>)", copilot_options)

-- stop snippets when you leave to normal mode
-- https://github.com/L3MON4D3/LuaSnip/issues/258
if require("astronvim.utils").is_available("luasnip") then
	vim.api.nvim_create_autocmd("ModeChanged", {
		pattern = "*",
		group = vim.api.nvim_create_augroup("ModeChangedGroup", { clear = true }),
		callback = function()
			local luasnip = require("luasnip")
			if
					((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
					and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
					and not luasnip.session.jump_active
			then
				luasnip.unlink_current()
			end
		end,
	})
	end
