-- local options = vim.opt
-- 
-- options.backupskip =
-- 	"set backupskip=$TMPDIR/*,$TMP/*,$TEMP/*,/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*"
-- options.showcmd = false

require("base")
require("highlight")
require("maps")
require("plugins")

local has = function(x)
	return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
local is_win = has("win32")

if is_mac then
	require("macos")
end

if is_win then
	require("windows")
end
