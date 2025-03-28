---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

g.rustaceanvim = {
    tools = {},
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                ["rust-analyzer.rust.analyzerTargetDir"] = true,
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                },
                diagnostics = {
                    enable = false,
                },
                experimental = {
                    serverStatusNotification = true,
                },
            },
        },
    },
}
