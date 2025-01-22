local dap = require "dap"
dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

    -- On windows you may have to uncomment this:
    -- detached = false,
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
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
