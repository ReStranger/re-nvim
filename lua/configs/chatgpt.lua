require("chatgpt").setup {
    -- this config assumes you have OPENAI_API_KEY environment variable set
    openai_params = {
        model = "o1-preview",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 1,
        top_p = 1,
        n = 1,
    },
}
