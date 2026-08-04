return {
    "qleveque/hexa.nvim",
    opts = {
        keymaps = {
            hex = {
                reformat = "<leader>f",
            },
            ascii = {
                replace = "r",
                undo = "u",
                redo = "<C-R>",
            },
            run = "<CR>",
        },
        run_cmd = function(file)
            return 'bot sp | term "' .. file .. '"'
        end,
        ascii_left = false,
    },
}
