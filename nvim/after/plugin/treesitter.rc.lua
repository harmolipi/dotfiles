local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'tsx',
    'lua',
    'json',
    'css',
    'javascript',
    'markdown',
    'php',
    'python',
    'regex',
    'ruby',
    'typescript',
    'vim',
    'yaml',
    'html',
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
}
