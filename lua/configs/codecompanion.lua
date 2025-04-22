require("codecompanion").setup {
    opts = {
        language = "Russian",
    },
    strategies = {
        chat = {
            adapter = "weegam_openai",
        },
        inline = {
            adapter = "weegam_openai",
            keymaps = {
                accept_change = {
                    modes = { n = "<leader>a" },
                    description = "Accept the suggested change",
                },
                reject_change = {
                    modes = { n = "<leader>r" },
                    description = "Reject the suggested change",
                },
            },
        },
        cmd = {
            adapter = "weegam_openai",
        },
    },
    adapters = {
        weegam_openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "https://oai.weegam.com/proxy/openai", -- optional: default value is ollama url http://127.0.0.1:11434
                    api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
                    chat_url = "/v1/chat/completions", -- optional: default value, override if different
                    models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
                },
                schema = {
                    model = {
                        default = "gpt-4o", -- define llm model to be used
                    },
                },
            })
        end,
    },
}
