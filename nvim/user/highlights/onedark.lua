local astronvim = require("astronvim.utils")
local normalFloatHl = astronvim.get_hlgroup "NormalFloat"
local normalFloatFg = normalFloatHl.fg

local cursorLineHl = astronvim.get_hlgroup "CursorLine"
local cursorLineBg = cursorLineHl.bg

local aerialLine = astronvim.get_hlgroup "AerialLine"
local aerialLineBg = aerialLine.bg

return {
  TelescopePromptTitle = { link = "PMenuSel" },
  TelescopePreviewTitle = { link = "PMenuSel" },
  TelescopePromptNormal = { fg = normalFloatFg, bg = aerialLineBg },
  TelescopePromptBorder = { fg = aerialLineBg, bg = aerialLineBg },
  TelescopeResultsBorder = { fg = cursorLineBg, bg = cursorLineBg },
  TelescopeNormal = { link = "CursorLine" },
  TelescopePreviewBorder = { fg = cursorLineBg, bg = cursorLineBg },
  TelescopeBorder = { fg = cursorLineBg, bg = cursorLineBg },
}
