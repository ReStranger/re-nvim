return {
    theme = "doom",
    config = {

        header = {
            " ██▀███  ▓█████ ▒▓▒  ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓",
            "▓██ ▒ ██▒▓█   ▀  ▒   ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
            "▓██ ░▄█ ▒▒███       ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░",
            "▒██▀▀█▄  ▒▓█  ▄ ▒▓▒ ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ",
            "░██▓ ▒██▒░▒████ ░▒  ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒",
            "░ ▒▓ ░▒▓░░░ ▒░  ░   ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░",
            "  ░▒ ░ ▒░ ░ ░    ░  ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░",
            "  ░░   ░    ░    ░     ░   ░ ░     ░░   ▒ ░░      ░   ",
            "   ░        ░                ░      ░   ░         ░   ",
            "                                                      ",
        },
        center = {
            { desc = "[ Github] [ ReStranger] [ 0.0.1]", group = "DashboardShortCut" },
            {
                icon = "  ",
                icon_hl = "@tag.builtin",
                desc = "Find File",
                key = "SPC f f",
                key_format = " %s",
            },
            {
                icon = "  ",
                icon_hl = "@tag.builtin",
                desc = "Find World",
                key = "SPC f w",
                key_format = " %s",
            },
        },
        package = { enabled = true },
        vertical_center = true,
    },
}
