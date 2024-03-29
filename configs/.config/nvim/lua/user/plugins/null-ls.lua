return {
	"jose-elias-alvarez/null-ls.nvim",
	opts = function(_, config)
		-- config variable is the default configuration table for the setup function call
		local null_ls = require("null-ls")

		-- Check supported formatters and linters
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		config.sources = {
			-- null_ls.builtins.diagnostics.eslint,
			-- Set a formatter
			-- null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.formatting.prettier,
			-- null_ls.builtins.diagnostics.stylelint,
			-- null_ls.builtins.code_actions.eslint_d
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.goimports,
			null_ls.builtins.formatting.golines,
			null_ls.builtins.formatting.deno_fmt,
		}
		return config -- return final config table
	end,
}
