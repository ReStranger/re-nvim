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
                            default = "gemeni-pro-preview",
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
                            default = "qwen/qwen3-coder:free",
                            choices = {
                                -- Arcee AI
                                ["arcee-ai/trinity-mini:free"] = {},

                                -- Cognitive Computations
                                ["cognitivecomputations/dolphin-mistral-24b-venice-edition:free"] = {},

                                -- Google
                                ["google/gemini-2.0-flash-exp:free"] = {},
                                ["google/gemma-3-27b-it:free"] = {},
                                ["google/gemma-3-12b-it:free"] = {},
                                ["google/gemma-3-4b-it:free"] = {},
                                ["google/gemma-3n-e4b-it:free"] = {},
                                ["google/gemma-3n-e2b-it:free"] = {},

                                -- Meta (Llama)
                                ["meta-llama/llama-3.1-405b-instruct:free"] = {},
                                ["meta-llama/llama-3.3-70b-instruct:free"] = {},
                                ["meta-llama/llama-3.2-3b-instruct:free"] = {},

                                -- Mistral AI
                                ["mistralai/devstral-2512:free"] = {},
                                ["mistralai/mistral-small-3.1-24b-instruct:free"] = {},
                                ["mistralai/mistral-7b-instruct:free"] = {},

                                -- Moonshot AI
                                ["moonshotai/kimi-k2:free"] = {},

                                -- Nex AGI
                                ["nex-agi/deepseek-v3.1-nex-n1:free"] = {},

                                -- Nous Research
                                ["nousresearch/hermes-3-llama-3.1-405b:free"] = {},

                                -- NVIDIA
                                ["nvidia/nemotron-3-nano-30b-a3b:free"] = {},
                                ["nvidia/nemotron-nano-12b-v2-vl:free"] = {},
                                ["nvidia/nemotron-nano-9b-v2:free"] = {},

                                -- OpenAI (OSS models)
                                ["openai/gpt-oss-120b:free"] = {},
                                ["openai/gpt-oss-20b:free"] = {},

                                -- Qwen
                                ["qwen/qwen3-coder:free"] = {},
                                ["qwen/qwen-2.5-vl-7b-instruct:free"] = {},
                                ["qwen/qwen3-4b:free"] = {},

                                -- TNG Tech
                                ["tngtech/deepseek-r1t2-chimera:free"] = {},
                                ["tngtech/deepseek-r1t-chimera:free"] = {},
                                ["tngtech/tng-r1t-chimera:free"] = {},

                                -- Xiaomi
                                ["xiaomi/mimo-v2-flash:free"] = {},

                                -- Z-AI
                                ["z-ai/glm-4.5-air:free"] = {},
                            },
                        },
                    },
                })
            end,
        },
    },
}
