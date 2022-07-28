local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local snip_status, luasnip = pcall(require, "luasnip")
if not snip_status then
    return
end

-- CMP
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("luasnip/loaders/from_vscode").lazy_load()

vim.cmd([[set completeopt=menu,menuone,noselect]]) -- Should work from vimscript

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
                ["<C-e>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                },
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            fallback()
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
                {name = "nvim_lua"},
                {name = "luasnip"},
                {name = "buffer"},
                {name = "path"}
            }
        ),
        formatting = {
            format = lspkind.cmp_format(
                {
                    mode = "symbol_text",
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]"
                    }),
                    preset = "default",
                    maxwidth = 50
                }
            )
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        window = {
            documentation = {
                border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
                winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None"
            },
            completion = {
                border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
                winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None"
            }
        },
        experimental = {
            ghost_text = true
        }
    }
)

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])
