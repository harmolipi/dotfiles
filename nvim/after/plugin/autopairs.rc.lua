local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then
    return
end

autopairs.setup(
    {
        check_ts = true,
        disable_filetype = {"TelescopePrompt", "vim"}
    }
)

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
