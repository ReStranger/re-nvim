---@diagnostic disable: undefined-global
local fn = vim.fn
local o = vim.o
---@diagnostic enable: undefined-global

local ufo = require "ufo"

o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]]

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

ufo.setup {
    -- close_fold_kinds_for_ft = {
    --   default = { "imports", "comment" },
    --   json = { "array" },
    --   c = { "comment", "region" },
    -- },
    preview = {
        win_config = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Folded",
            winblend = 0,
        },
        mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
        },
    },

    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end,
}
