local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

null_ls.setup {
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
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish,
    -- null_ls.builtins.diagnostics.php,
    -- null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.completion.luasnip,
    -- null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.formatting.autopep8,
    -- null_ls.builtins.formatting.pint,
  }
}
