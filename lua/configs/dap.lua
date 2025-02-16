---@diagnostic disable: undefined-global
local fn = vim.fn
---@diagnostic enable: undefined-global

local dap = require "dap"

-- FIXME: Debugger breaks if you use symlinks
dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
    executable = {
        command = fn.stdpath "data" .. "/mason/bin/codelldb",
        args = { "--port", "13000" },
    },
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return fn.input("Path to executable: ", fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.h = dap.configurations.cpp

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 8123,
    executable = {
        command = "js-debug-adapter",
    },
}

for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
        },
    }
end
