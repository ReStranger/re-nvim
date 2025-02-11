require("better_escape").setup {
    timeout = 200,
    default_mappings = false,
    mappings = {
        i = { j = { j = "<Esc>" }, ["о"] = { ["о"] = "<Esc>" } },
        c = { j = { j = "<Esc>" } },
        t = { j = { j = "<C-\\><C-n>" } },
        v = { ["<C-j>"] = { ["<C-j>"] = "<Esc>" } },
        s = { j = { j = "<Esc>" } },
    },
}
