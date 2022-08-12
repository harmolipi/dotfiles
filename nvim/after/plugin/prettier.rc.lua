local status, prettier = pcall(require, 'prettier')
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    'css',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'scss',
    'less',
    'html',
    'graphql',
    'markdown',
    'yaml',
  },

  -- prettier format options
  -- arrow_parens = "always",
  -- bracket_spacing = true,
  -- end_of_line = "lf",
  -- html_whitespace_sensitivity = "css",
  -- jsx_bracket_same_line = false,
  -- jsx_single_quote = true,
  -- prose_wrap = "preserve",
  -- quote_props = "as-needed",
  -- semi = true,
  -- single_quote = true,
  -- tab_width = 2,
  -- trailing_comma = "es5",
  -- use_tabs = false,
}
