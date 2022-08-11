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
    'json',
    'scss',
    'less',
    'html',
    'graphql',
    'markdown',
    'yaml',
  },
  arrow_parens = 'always',
  trailing_comma = 'es5',
  single_quote = true,
  embedded_language_formatting = 'auto',
  bracket_spacing = true,
  end_of_line = 'lf',
  html_whitespace_sensitivity = 'css',
  jsx_bracket_same_line = false,
  jsx_single_quote = true,
  quote_props = 'as-needed',
  semi = true,
  use_tabs = false,
}
