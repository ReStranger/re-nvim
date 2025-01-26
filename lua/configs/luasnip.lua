---@diagnostic disable: undefined-global
local api = vim.api
local g = vim.g
---@diagnostic enable: undefined-global

-- vscode format
require("luasnip.loaders.from_vscode").lazy_load { exclude = g.vscode_snippets_exclude or {} }
require("luasnip.loaders.from_vscode").lazy_load { paths = g.vscode_snippets_path or "" }

-- snipmate format
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load { paths = g.snipmate_snippets_path or "" }

-- lua format
require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load { paths = g.lua_snippets_path or "" }

api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if
            require("luasnip").session.current_nodes[api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
            require("luasnip").unlink_current()
        end
    end,
})
