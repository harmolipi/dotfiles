return function(client, bufnr)
  require("lsp_signature").on_attach {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
    auto_close_after = 3,
    hint_enable = false,
    hi_parameter = "IncSearch",
  }
end
