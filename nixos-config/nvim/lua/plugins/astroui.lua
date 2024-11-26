-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local astroui = require "astroui"
local normalFloatHl = astroui.get_hlgroup "NormalFloat"
local normalFloatFg = normalFloatHl.fg

local cursorLineHl = astroui.get_hlgroup "CursorLine"
local cursorLineBg = cursorLineHl.bg

local aerialLine = astroui.get_hlgroup "AerialLine"
local aerialLineBg = aerialLine.bg

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    -- colorscheme = "astrodark",
    -- colorscheme = "onedark_vivid",
    colorscheme = "catppuccin-macchiato",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
      onedark = {
        TelescopePromptTitle = { link = "PMenuSel" },
        TelescopePreviewTitle = { link = "PMenuSel" },
        TelescopePromptNormal = { fg = normalFloatFg, bg = aerialLineBg },
        TelescopePromptBorder = { fg = aerialLineBg, bg = aerialLineBg },
        TelescopeResultsBorder = { fg = cursorLineBg, bg = cursorLineBg },
        TelescopeNormal = { link = "CursorLine" },
        TelescopePreviewBorder = { fg = cursorLineBg, bg = cursorLineBg },
        TelescopeBorder = { fg = cursorLineBg, bg = cursorLineBg },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    status = {
      separators = {
        -- tab = { "", "" },
      },
    },
  },
}