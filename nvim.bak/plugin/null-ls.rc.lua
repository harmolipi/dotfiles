local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- vim.lsp.buf.formatting_sync()
          -- vim.lsp.buf.format()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    -- null_ls.builtins.diagnostics.fish,
    -- null_ls.builtins.diagnostics.php,
    -- null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.pint,
  }
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
