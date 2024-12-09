local api = vim.api
local g = vim.g
local schedule = vim.schedule
local autocmd = api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
    group = api.nvim_create_augroup("NvFilePost", { clear = true }),
    callback = function(args)
        local file = api.nvim_buf_get_name(args.buf)
        local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })

        if not g.ui_entered and args.event == "UIEnter" then
            g.ui_entered = true
        end

        if file ~= "" and buftype ~= "nofile" and g.ui_entered then
            api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
            api.nvim_del_augroup_by_name "NvFilePost"

            schedule(function()
                api.nvim_exec_autocmds("FileType", {})

                if g.editorconfig then
                    require("editorconfig").config(args.buf)
                end
            end)
        end
    end,
})
