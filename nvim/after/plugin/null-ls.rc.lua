local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			extra_args = { "--single-quote", "--jsx-single-quote" },
		}),
		diagnostics.php,
		diagnostics.pylint,
		diagnostics.tsc,
		-- formatting.eslint_d,
		-- diagnostics.eslint_d,
		code_actions.eslint_d,
		completion.luasnip,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})