local function selected_style(bg, opts)
    return vim.tbl_extend("force", { bg = bg }, opts or {})
end

local function is_valid_buf(bufnr)
    return bufnr and bufnr > 0 and vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr)
end

local function resolve_bufnr(bufnr)
    if is_valid_buf(bufnr) then
        return bufnr
    end

    local current = vim.api.nvim_get_current_buf()
    if is_valid_buf(current) then
        return current
    end
end

local function get_buffer_icon_highlight(bufnr)
    bufnr = resolve_bufnr(bufnr)
    if not bufnr then
        return
    end

    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok or not devicons then
        return
    end

    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return
    end

    local filename = vim.fn.fnamemodify(name, ":t")
    local extension = vim.fn.fnamemodify(name, ":e")
    local _, highlight = devicons.get_icon(filename, extension, { default = true })
    if not highlight or highlight == "" then
        return
    end

    return "BufferLine" .. highlight .. "Selected"
end

local function delete_buffer(bufnr)
    local ok, snacks = pcall(require, "snacks")
    if ok and snacks and snacks.bufdelete then
        snacks.bufdelete(bufnr)
    end
end

local function get_hl_color(name, attr)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = true })
    if ok and type(hl[attr]) == "number" then
        return string.format("#%06x", hl[attr])
    end
end

local function get_theme_colors()
    local default = get_hl_color("Special", "fg")
    local hint = get_hl_color("DiagnosticHint", "fg") or get_hl_color("DiagnosticInfo", "fg") or default
    local warning = get_hl_color("Keyword", "fg")
    local error = get_hl_color("DiagnosticError", "fg") or get_hl_color("ErrorMsg", "fg")
    local base = get_hl_color("Normal", "bg") or get_hl_color("StatusLine", "bg")

    return {
        default = default,
        hint = hint,
        warning = warning,
        error = error,
        base = base,
    }
end

local function selected_highlight_overrides(colors)
    return {
        BufferLineBufferSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineNumbersSelected = { fg = colors.base, bold = true },
        BufferLineCloseButtonSelected = { fg = colors.base },
        BufferLineDiagnosticSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineHintSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineHintDiagnosticSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineWarningSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineWarningDiagnosticSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineErrorSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineErrorDiagnosticSelected = { fg = colors.base, bold = true, italic = true },
        BufferLineModifiedSelected = { fg = colors.base },
        BufferLineDuplicateSelected = { italic = true },
        BufferLinePickSelected = { fg = colors.base, bold = true, italic = true },
    }
end

local function static_highlights(colors)
    return {
        fill = {
            bg = colors.base,
        },
        close_button_selected = selected_style(colors.default, { fg = colors.base }),
        buffer_selected = selected_style(colors.default, { fg = colors.base, bold = true, italic = true }),
        numbers_selected = selected_style(colors.default, { fg = colors.base, bold = true }),
        diagnostic_selected = selected_style(colors.default, { fg = colors.base, bold = true, italic = true }),
        hint_selected = selected_style(colors.hint, { fg = colors.base, bold = true, italic = true }),
        hint_diagnostic_selected = selected_style(colors.hint, { fg = colors.base, bold = true, italic = true }),
        warning_selected = selected_style(colors.warning, { fg = colors.base, bold = true, italic = true }),
        warning_diagnostic_selected = selected_style(colors.warning, { fg = colors.base, bold = true, italic = true }),
        error_selected = selected_style(colors.error, { fg = colors.base, bold = true, italic = true }),
        error_diagnostic_selected = selected_style(colors.error, { fg = colors.base, bold = true, italic = true }),
        modified_selected = selected_style(colors.default, { fg = colors.base }),
        duplicate_selected = selected_style(colors.default, { italic = true }),
        indicator_selected = { fg = colors.default, bg = colors.default },
        separator_selected = {
            fg = colors.default,
            bg = colors.default,
        },
        tab_separator_selected = {
            fg = colors.default,
            bg = colors.default,
        },
    }
end

local function selected_bg(bufnr, colors)
    bufnr = resolve_bufnr(bufnr)
    if not bufnr then
        return colors.default
    end

    local diagnostics = vim.diagnostic.get(bufnr)
    local has_hint = false
    local has_warning = false
    for _, diagnostic in ipairs(diagnostics) do
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
            return colors.error
        end
        if diagnostic.severity == vim.diagnostic.severity.WARN then
            has_warning = true
        end
        if diagnostic.severity == vim.diagnostic.severity.HINT then
            has_hint = true
        end
    end

    if has_warning then
        return colors.warning
    end

    return has_hint and colors.hint or colors.default
end

local function update_bufferline_selected_highlights(bufnr)
    local colors = get_theme_colors()
    local selected = selected_highlight_overrides(colors)
    bufnr = resolve_bufnr(bufnr)
    local bg = selected_bg(bufnr, colors)
    local overrides = {
        BufferLineIndicatorSelected = { fg = bg, bg = bg },
        BufferLineSeparator = { fg = bg, bg = colors.base },
        BufferLineSeparatorVisible = { fg = bg, bg = colors.base },
        BufferLineSeparatorSelected = { fg = bg, bg = bg },
        BufferLineTabSeparatorSelected = { fg = bg, bg = bg },
    }

    for name, opts in pairs(selected) do
        overrides[name] = selected_style(bg, opts)
    end

    for name, override in pairs(overrides) do
        local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        if ok then
            current = vim.tbl_extend("force", current, override)
            vim.api.nvim_set_hl(0, name, current)
        end
    end

    local icon_highlight = get_buffer_icon_highlight(bufnr)
    if icon_highlight then
        local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = icon_highlight, link = false })
        if ok then
            current.bg = bg
            vim.api.nvim_set_hl(0, icon_highlight, current)
        end
    end

end

local function bufferline_opts()
    local colors = get_theme_colors()
    return {
        highlights = static_highlights(colors),
        options = {
            themable = false,
            separator_style = "thin",
            color_icons = false,
            show_buffer_close_icons = true,
            tab_size = 1,
            max_name_length = 80,
            truncate_names = false,
            enforce_regular_tabs = false,
            indicator = {
                style = "none",
            },
            persist_buffer_sort = true,
            close_command = function(n)
                delete_buffer(n)
            end,
            right_mouse_command = function(n)
                delete_buffer(n)
            end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            diagnostics_indicator = function(count, level, _, _)
                local is_error = type(level) == "string" and level:match("error")
                local icon = is_error and " " or " "
                return " " .. icon .. count
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = " File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
                {
                    filetype = "snacks_layout_box",
                },
            },
        },
    }
end

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    config = function()
        local opts = bufferline_opts()
        require("bufferline").setup(opts)

        local group = vim.api.nvim_create_augroup("bufferline-selected-diagnostics", { clear = true })
        local function refresh(bufnr)
            vim.schedule(function()
                update_bufferline_selected_highlights(bufnr)
                pcall(vim.fn.nvim_bufferline)
            end)
        end

        vim.api.nvim_create_autocmd({ "DiagnosticChanged", "ColorScheme" }, {
            group = group,
            callback = function(args)
                refresh(resolve_bufnr(args.buf))
            end,
        })

        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            group = group,
            callback = function()
                refresh(vim.api.nvim_get_current_buf())
            end,
        })

        refresh(vim.api.nvim_get_current_buf())
    end,
}
