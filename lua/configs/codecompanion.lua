---@diagnostic disable: undefined-global
local cmd = vim.cmd
---@diagnostic enable: undefined-global

cmd [[cab cc CodeCompanion]]

return {
    opts = {
        language = "Russian",
    },
    display = {
        chat = {
            intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
            separator = "─",
            show_context = true,
            show_header_separator = false,
            show_settings = false,
            show_token_count = false,
            show_tools_processing = true,
            start_in_insert_mode = false,
        },
    },
    interactions = {
        chat = {
            adapter = "openrouter",
        },
        inline = {
            adapter = "weegam_openai",
        },
        cmd = {
            adapter = "weegam_openai",
        },
    },
    adapters = {
        http = {
            weegam_openai = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://api.weegam.com/uni",
                        api_key = "OPENAI_API_KEY",
                        chat_url = "/v1/chat/completions",
                        models_endpoint = "/v1/models",
                    },
                    schema = {
                        model = {
                            default = "gpt-4.1",
                            choices = {},
                        },
                    },
                })
            end,
            weegam_google = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://api.weegam.com/uni",
                        api_key = "OPENAI_API_KEY",
                        chat_url = "/v1beta/chat/completions",
                        models_endpoint = "/v1beta/models",
                    },
                    schema = {
                        model = {
                            default = "gemeni-3-pro-preview",
                            choices = {},
                        },
                    },
                })
            end,
            openrouter = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://openrouter.ai/api",
                        api_key = "OPENROUTER_API_KEY",
                        chat_url = "/v1/chat/completions",
                    },
                    schema = {
                        model = {
                            default = "nvidia/nemotron-3-nano-30b-a3b:free",
                            choices = {
                                ["qwen/qwen3-next-80b-a3b-instruct:free"] = {},
                                ["qwen/qwen3-coder:free"] = {},
                                ["qwen/qwen3-4b:free"] = {},

                                ["openai/gpt-oss-120b:free"] = {},
                                ["openai/gpt-oss-20b:free"] = {},

                                ["google/gemma-3n-e2b-it:free"] = {},

                                ["deepseek/deepseek-r1-0528:free"] = {},

                                ["mistralai/mistral-small-3.1-24b-instruct:free"] = {},

                                ["meta-llama/llama-3.3-70b-instruct:free"] = {},
                                ["meta-llama/llama-3.2-3b-instruct:free"] = {},
                                ["nvidia/nemotron-3-nano-30b-a3b:free"] = {},
                            },
                        },
                    },
                })
            end,
        },
    },
}
