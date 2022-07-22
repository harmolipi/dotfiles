-- CMP
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")

vim.cmd([[set completeopt=menu,menuone,noselect]]) -- Should work from vimscript

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm(
                    {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }
                ),
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "luasnip"}
            },
            {
                {name = "buffer"}
            }
        ),
        formatting = {
            format = lspkind.cmp_format(
                {
                    mode = "symbol_text",
                    preset = "default",
                    -- with_text = false,
                    maxwidth = 50
                }
            )
        }
    }
)

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])
