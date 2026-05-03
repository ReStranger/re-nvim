return {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
        local loaded = false
        local function check()
            local cwd = vim.uv.cwd()
            if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
                ---@diagnostic disable: different-requires
                require("lazy").load { plugins = { "cmake-tools.nvim" } }
                ---@diagnostic enable: different-requires
                loaded = true
            end
        end
        check()
        vim.api.nvim_create_autocmd("DirChanged", {
            callback = function()
                if not loaded then
                    check()
                end
            end,
        })
    end,
    opts = function()
        local osys = require "cmake-tools.osys"
        local opts = {
            cmake_build_directory = function()
                if osys.iswin32 then
                    return "build\\${variant:buildType}"
                end
                return "build/${variant:buildType}"
            end,
            cmake_compile_commands_options = {
                action = "none",
            },
        }
        return opts
    end,
}
